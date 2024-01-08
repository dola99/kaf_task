import 'dart:io';

class RegisterModel {
  final FirstRegisterFrom firstRegisterFrom;
  final SecondRegisterForm secondRegisterForm;

  RegisterModel({
    required this.firstRegisterFrom,
    required this.secondRegisterForm,
  });

  Map<String, dynamic> toJson() {
    return {
      ...firstRegisterFrom.toFormData(),
      ...secondRegisterForm.toFormData(),
    };
  }
}

class FirstRegisterFrom {
  String? firstName;
  String? lastName;
  String? password;
  String? email;
  int? type;
  FirstRegisterFrom({
    this.type,
    this.firstName,
    this.lastName,
    this.password,
    this.email,
  });
  Map<String, dynamic> toFormData() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'password_confirmation': password,
      'type': type,
      'email': email,
    };
  }
}

class SecondRegisterForm {
  String? about;
  List<int>? tags;
  String? favoriteSocialMedia;
  int? salary;
  String? birthDate;
  int? gender;
  File? avatarPath;

  SecondRegisterForm({
    this.about,
    this.tags,
    this.favoriteSocialMedia,
    this.salary,
    this.birthDate,
    this.gender,
    this.avatarPath,
  });

  Map<String, dynamic> toFormData() {
    return {
      'about': about,
      'tags[]': tags?.join(""),
      'favorite_social_media[]': favoriteSocialMedia?.toLowerCase(),
      'salary': salary,
      'birth_date': birthDate,
      'gender': gender,
      // 'avatar': avatarPath,
    };
  }
}
