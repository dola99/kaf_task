import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/Model/register_model.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';

mixin FirstFormMixin on Cubit<RegisterState> {
  int selectedType = 0;
  bool isFormValid = true;
  FirstRegisterFrom firstRegisterFrom = FirstRegisterFrom(type: 0);

  void selectType(int selectedTypeID) {
    selectedType = selectedTypeID;
    firstRegisterFrom.type = selectedType;
    emit(TypeSelected());
  }

  void setFirstName(String firstName) {
    firstRegisterFrom.firstName = firstName;
  }

  void setSecondName(String secondName) {
    firstRegisterFrom.lastName = secondName;
  }

  void setEmail(String email) {
    firstRegisterFrom.email = email;
  }

  void setPassword(String password) {
    firstRegisterFrom.password = password;
  }

  formNotValidate() {
    isFormValid = false;
  }

  validateFirstForm() {
    if (!isFormValid) {
      emit(FirstFormValidationFailed());
    }
    inspect(firstRegisterFrom);
  }
}
