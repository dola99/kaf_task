import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/bootstrap.dart';
import 'package:kafiil_test/core/dependency_injection/service_locator.dart';
import 'package:kafiil_test/core/helpers/secure_sharedprefernce.dart';
import 'package:kafiil_test/core/network/certifications.dart';
import 'package:kafiil_test/core/theme.dart';
import 'package:kafiil_test/features/appData/cubit/app_data_cubit.dart';
import 'package:kafiil_test/features/appData/repo/app_data_imb.dart';
import 'package:kafiil_test/features/country/cubit/country_cubit.dart';
import 'package:kafiil_test/features/country/repo/country_repo_imb.dart';
import 'package:kafiil_test/features/login/cubit/login_cubit.dart';
import 'package:kafiil_test/features/login/presentation/screens/login_screen.dart';
import 'package:kafiil_test/features/login/repo/login_repo_imb.dart';
import 'package:kafiil_test/features/navbar/cubit/navbar_cubit.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';
import 'package:kafiil_test/features/register/repo/register_repo_imb.dart';
import 'package:kafiil_test/features/services/cubit/services_cubit.dart';
import 'package:kafiil_test/features/services/repo/services_repo_imb.dart';
import 'package:kafiil_test/features/who_am/cubit/who_am_cubit.dart';
import 'package:kafiil_test/features/who_am/repo/who_am_repo_imb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  HttpOverrides.global = MyHttpOverrides();
  await SharedPreferencesHelper.init();
  bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            loginRepo: serviceLocator<LoginRepoImb>(),
          ),
        ),
        BlocProvider(
          create: (context) => NavbarCubit()..init(),
        ),
        BlocProvider(
          create: (context) =>
              ServicesCubit(servicesRepo: serviceLocator<ServiceRepoImb>()),
        ),
        BlocProvider(
          create: (context) =>
              CountryCubit(countryRepo: serviceLocator<CountryRepoImb>()),
        ),
        BlocProvider(
          create: (context) => AppDataCubit(
            appDataRepo: serviceLocator<AppDataRepoImb>(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(
            registerRepo: serviceLocator<RegisterRepoImb>(),
          ),
        ),
        BlocProvider(
          create: (context) => UserCubit(
            whoAmRepo: serviceLocator<WhoAmRepoImb>(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            title: 'Kafill APP',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().appTheme,
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
