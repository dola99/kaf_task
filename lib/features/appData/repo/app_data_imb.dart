import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/app_data.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/service_urls.dart';
import 'package:kafiil_test/features/appData/repo/app_data_repo.dart';

class AppDataRepoImb extends AppDataRepo {
  AppDataRepoImb({required super.networkService});

  @override
  Future<Either<String, GenericResponse<AppData>>> getAppData() async {
    final response = await networkService.getRequest(
      ServicesUrl.appData,
    );

    if (response['error'] != null) {
      return Left(response['error']['message']);
    } else {
      return Right(GenericResponse<AppData>.fromJson(
          response, (map) => AppData.fromJson(map)));
    }
  }
}
