import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/appData/cubit/app_data_cubit.dart';
import 'package:kafiil_test/features/login/presentation/widgets/login_form.dart';
import 'package:kafiil_test/features/navbar/cubit/navbar_cubit.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';

import 'package:kafiil_test/widgets/image_loader.dart';
import 'package:kafiil_test/widgets/custom_appbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    NavbarCubit.get(context);
    RegisterCubit.get(context);
    super.initState();
    AppDataCubit.get(context).getappData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Account Login'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppContentPadding.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: ImageLoader(
                  imagePath: AppImages.loginImage,
                  size: Size(225, 225),
                ),
              ),
              SizedBox(height: 30.h),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
