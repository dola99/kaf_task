import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/register/presentation/screens/complete_signup_form.dart';
import 'package:kafiil_test/features/register/presentation/screens/main_information_form.dart';
import 'package:kafiil_test/features/who_am/cubit/who_am_cubit.dart';
import 'package:kafiil_test/widgets/custom_text.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserState();
}

class _UserState extends State<UserScreen> {
  @override
  void initState() {
    UserCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppContentPadding.horizontalPadding),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is WhoAmLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WhoAmSuccesfully) {
              final cubit = UserCubit.get(context);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    DisplayText(
                      textContent: 'Who Am I',
                      textStyle: AppTextStyle().montserratFont.copyWith(
                          height: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: AppColors.grey_900),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Container(
                        width: 83.w,
                        height: 82.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(cubit.userData.avatar))),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      height: 260.h,
                      child: MainInformationForm(
                        isShowOnly: true,
                        userData: cubit.userData,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      height: 600.h,
                      child: CompleteSignupForm(
                        isShowOnly: true,
                        userData: cubit.userData,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    ));
  }
}
