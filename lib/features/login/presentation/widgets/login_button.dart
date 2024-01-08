import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/core/routing.dart';
import 'package:kafiil_test/features/login/cubit/login_cubit.dart';
import 'package:kafiil_test/features/navbar/presentation/main_screen.dart';
import 'package:kafiil_test/features/register/presentation/screens/register_screen.dart';
import 'package:kafiil_test/widgets/custom_button.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/snack_bar.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginButton({super.key, required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailed) {
              ShowSnackBar.show(
                  context: context,
                  message: state.errorMessages!.entries.first.value,
                  textColor: AppColors.error_300,
                  color: AppColors.error_50,
                  isSuccess: false);
            } else if (state is LoginSuccesfully) {
              ShowSnackBar.show(
                  context: context,
                  message: 'Welcome ${state.userData?.firstName ?? ''}',
                  textColor: AppColors.bgGrey_900,
                  color: AppColors.primaryColor,
                  isSuccess: true);
              NavigatorHelper.push(context, const MainScreen());
            }
          },
          builder: (context, state) {
            return CustomButton(
              titleButton: 'Login',
              weight: double.infinity,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  LoginCubit.get(context).login();
                }
              },
              buttonState: state.buttonState,
            );
          },
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DisplayText(
              textContent: 'Don’t have an account ?',
              textStyle: AppTextStyle().montserratFont.copyWith(
                  height: 1, fontSize: 14.sp, color: AppColors.grey_500),
            ),
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: () {
                NavigatorHelper.push(context, const RegisterScreen());
              },
              child: DisplayText(
                textContent: 'Register',
                textStyle: AppTextStyle().montserratFont.copyWith(
                    height: 1,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.primaryColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}
