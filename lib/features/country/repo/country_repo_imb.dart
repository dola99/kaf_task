import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/country_model.dart';
import 'package:kafiil_test/core/network/service_urls.dart';
import 'package:kafiil_test/features/country/repo/country_repo.dart';

class CountryRepoImb extends CountryRepo {
  CountryRepoImb({required super.networkService});

  @override
  Future<Either<String, CountryResponse>> getCountry({int page = 1}) async {
    final response = await networkService.getRequest(
      '${ServicesUrl.countryServicesUrl}?page=$page',
    );

    if (response['error'] != null) {
      return Left(response['error']['message']);
    } else {
      return Right(CountryResponse.fromJson(response));
    }
  }
}
