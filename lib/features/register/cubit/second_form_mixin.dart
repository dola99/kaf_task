import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafiil_test/Model/register_model.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';

mixin SecondFormMixin on Cubit<RegisterState> {
  SecondRegisterForm secondRegisterForm =
      SecondRegisterForm(salary: 100, gender: 0);

  List<int> selectedTags = [];
  void setAbout(String about) {
    secondRegisterForm.about = about;
  }

  void setSalary(int newSalary) {
    secondRegisterForm.salary = newSalary;
  }

  void serBirthday(String birthday) {
    secondRegisterForm.birthDate = birthday;
  }

  void setGender(int value) {
    secondRegisterForm.gender = value;
  }

  configFavourite(String socialSelected) {
    debugPrint('test');
    secondRegisterForm.favoriteSocialMedia = socialSelected;
    debugPrint(secondRegisterForm.favoriteSocialMedia = socialSelected);
  }

  configTage(int selectedTag) {
    if (selectedTags.contains(selectedTag)) {
      selectedTags.remove(selectedTag);
    } else {
      selectedTags.add(selectedTag);
    }
  }

  setImageSelected(File selectedFile) {
    secondRegisterForm.avatarPath = selectedFile;
  }

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();

      XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 50, // Adjust the image quality (0 to 100)
      );
      if (pickedFile != null) {
        setImageSelected(File(pickedFile.path));
      }
      return pickedFile;
    } catch (e) {
      return null;
    }
  }

  String? validateSecondForm() {
    secondRegisterForm.tags = selectedTags;
    inspect(secondRegisterForm);
    // if (secondRegisterForm.favoriteSocialMedia == null ||
    //     secondRegisterForm.favoriteSocialMedia?.length == 0) {
    //   return 'you must Select at least one of Favorite Social Media';
    // } else if (secondRegisterForm.tags!.isEmpty) {
    //   return 'you must Select at least one of Skills';
    // } else if (secondRegisterForm.avatarPath == null) {
    //   return 'Profile Picture Required';
    // }
    return null;
  }
}
