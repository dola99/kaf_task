import 'package:get_it/get_it.dart';
import 'package:kafiil_test/core/network/network_layer.dart';
import 'package:kafiil_test/core/network/service_urls.dart';
import 'package:kafiil_test/features/appData/repo/app_data_imb.dart';
import 'package:kafiil_test/features/country/repo/country_repo_imb.dart';
import 'package:kafiil_test/features/login/repo/login_repo_imb.dart';
import 'package:kafiil_test/features/register/repo/register_repo_imb.dart';
import 'package:kafiil_test/features/services/repo/services_repo_imb.dart';
import 'package:kafiil_test/features/who_am/repo/who_am_repo_imb.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(
      () => NetworkService(baseUrl: ServicesUrl.baseUrl));
  serviceLocator.registerLazySingleton(
      () => LoginRepoImb(networkService: serviceLocator<NetworkService>()));
  serviceLocator.registerLazySingleton(
      () => AppDataRepoImb(networkService: serviceLocator<NetworkService>()));
  serviceLocator.registerLazySingleton(
      () => RegisterRepoImb(networkService: serviceLocator<NetworkService>()));
  serviceLocator.registerLazySingleton(
      () => ServiceRepoImb(networkService: serviceLocator<NetworkService>()));
  serviceLocator.registerLazySingleton(
      () => CountryRepoImb(networkService: serviceLocator<NetworkService>()));
  serviceLocator.registerLazySingleton(
      () => WhoAmRepoImb(networkService: serviceLocator<NetworkService>()));
}
