import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/service_model.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/service_urls.dart';
import 'package:kafiil_test/features/services/repo/services_repo.dart';

class ServiceRepoImb extends ServicesRepo {
  ServiceRepoImb({required super.networkService});
  @override
  Future<Either<String, ListResponse<ServiceProduct>>>
      getPopularService() async {
    final response = await networkService.getRequest(
      ServicesUrl.servicesUrl,
    );

    if (response['error'] != null) {
      return Left(response['error']['message']);
    } else {
      return Right(ListResponse<ServiceProduct>.fromJson(
          response, (map) => ServiceProduct.fromJson(map)));
    }
  }

  @override
  Future<Either<String, ListResponse<ServiceProduct>>> getServices() async {
    final response = await networkService.getRequest(
      ServicesUrl.popularServicesUrl,
    );

    if (response['error'] != null) {
      return Left(response['error']['message']);
    } else {
      return Right(ListResponse<ServiceProduct>.fromJson(
          response, (map) => ServiceProduct.fromJson(map)));
    }
  }
}
