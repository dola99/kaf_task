import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';
import 'package:kafiil_test/features/register/presentation/widgets/stepper.dart';
import 'package:kafiil_test/widgets/custom_appbar.dart';
import 'package:kafiil_test/widgets/snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    RegisterCubit.get(context).init(pageController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Register'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is SecondFormValidationFailed ||
                    state is FirstFormValidationFailed) {
                  ShowSnackBar.show(
                      context: context,
                      message: 'All Fields Required',
                      textColor: AppColors.error_300,
                      color: AppColors.error_50,
                      isSuccess: false);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    MyStepper(
                      pageController: RegisterCubit.get(context).pageController,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 550.h,
                      child: PageView.builder(
                          controller: RegisterCubit.get(context).pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) =>
                              RegisterCubit.get(context).forms[index]),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
