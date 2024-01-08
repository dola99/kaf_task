import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/core/helpers/custom_textfield_params.dart';
import 'package:kafiil_test/core/helpers/validators.dart';
import 'package:kafiil_test/features/appData/cubit/app_data_cubit.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';
import 'package:kafiil_test/widgets/custom_button.dart';
import 'package:kafiil_test/widgets/custom_radio_button.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/custom_textformfieldtitle.dart';
import 'package:progress_state_button/progress_button.dart';

// ignore: must_be_immutable
class MainInformationForm extends StatelessWidget {
  final UserData? userData;
  final bool isShowOnly;
  MainInformationForm({super.key, this.isShowOnly = false, this.userData});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordTextEditing = TextEditingController();
  final passwordFocusNode = FocusNode();
  bool _isPasswordObscure = true;
  @override
  Widget build(BuildContext context) {
    final cubit = RegisterCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isShowOnly ? 0 : AppContentPadding.horizontalPadding),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 160.w,
                    child: CustomTextFormFieldWithTitle(
                      params: CustomTextFormFieldParams(
                        validator: (value) {
                          if (value == null || value == '') {
                            cubit.formNotValidate();
                            return 'Please enter your first name';
                          } else if (value.length > 50) {
                            cubit.formNotValidate();
                            return 'First name should not exceed 50 characters';
                          }
                          return null;
                        },
                        intialValue: userData?.firstName,
                        isReadOnly: isShowOnly,
                        onSaved: (va) => cubit.setFirstName(va!),
                      ),
                      fieldTitle: 'First Name',
                    )),
                SizedBox(
                  width: 15.w,
                ),
                SizedBox(
                    width: 160.w,
                    child: CustomTextFormFieldWithTitle(
                        params: CustomTextFormFieldParams(
                          validator: (value) {
                            if (value == null || value == '') {
                              cubit.formNotValidate();
                              return 'Please enter your last name';
                            } else if (value.length > 50) {
                              cubit.formNotValidate();
                              return 'Last name should not exceed 50 characters';
                            }
                            return null;
                          },
                          isReadOnly: isShowOnly,
                          intialValue: userData?.lastName,
                          onSaved: (va) => cubit.setSecondName(va!),
                        ),
                        fieldTitle: 'Second Name')),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextFormFieldWithTitle(
              fieldTitle: 'Email Address',
              params: CustomTextFormFieldParams(
                validator: (value) {
                  final emailRegex =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                  if (value == null || !emailRegex.hasMatch(value)) {
                    cubit.formNotValidate();
                    return 'Please enter a valid email address';
                  }
                  if (value.length > 64) {
                    cubit.formNotValidate();
                    return 'Email should not exceed 64 characters';
                  }
                  return null;
                },
                isReadOnly: isShowOnly,
                intialValue: userData?.email,
                onSaved: (va) => cubit.setEmail(va!),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            if (!isShowOnly)
              StatefulBuilder(builder: (thisLowerContext, innerSetState) {
                return CustomTextFormFieldWithTitle(
                    fieldTitle: 'Password',
                    params: CustomTextFormFieldParams(
                      obscureText: _isPasswordObscure,
                      controller: passwordTextEditing,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          innerSetState(
                              () => _isPasswordObscure = !_isPasswordObscure);
                        },
                        child: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          size: 18,
                          color: AppColors.grey_400,
                        ),
                      ),
                      validator: (value) {
                        return ValidatorHelper.validatePassword(value);
                      },
                      onSaved: (value) {},
                    ));
              }),
            if (!isShowOnly)
              SizedBox(
                height: 15.h,
              ),
            if (!isShowOnly)
              StatefulBuilder(
                builder: (thisLowerContext, innerSetState) {
                  return CustomTextFormFieldWithTitle(
                      fieldTitle: 'Confirm Password',
                      params: CustomTextFormFieldParams(
                        obscureText: _isPasswordObscure,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            innerSetState(
                                () => _isPasswordObscure = !_isPasswordObscure);
                          },
                          child: Icon(
                            _isPasswordObscure
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            size: 18,
                            color: AppColors.grey_400,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            cubit.formNotValidate();
                            return 'Password should be at least 8 characters';
                          } else if (value != passwordTextEditing.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                        onSaved: (va) => cubit.setPassword(va!),
                      ));
                },
              ),
            SizedBox(
              height: 15.h,
            ),
            DisplayText(
              textContent: 'User Type',
              textStyle: AppTextStyle().montserratFont,
            ),
            SizedBox(
              height: 12.h,
            ),
            BlocConsumer<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) => current is TypeSelected,
              listener: (context, state) {},
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: List.generate(
                      AppDataCubit.get(context)
                          .types
                          .length, // number of radio buttons
                      (index) => AnimatedRadioButton(
                        value: AppDataCubit.get(context).types[index].value!,
                        selectedValue: isShowOnly
                            ? userData!.type.code
                            : cubit.selectedType,
                        onChanged: (va) {
                          cubit.selectType(
                              AppDataCubit.get(context).types[index].value!);
                        },
                        title: AppDataCubit.get(context).types[index].label!,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            if (!isShowOnly)
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                    weight: 160.w,
                    buttonState: ButtonState.idle,
                    titleButton: 'Next',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        cubit.validateFirstForm();
                        RegisterCubit.get(context).pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      }
                    }),
              )
          ],
        ),
      ),
    );
  }
}
