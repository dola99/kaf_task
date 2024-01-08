import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/country_model.dart';
import 'package:kafiil_test/core/network/network_layer.dart';

abstract class CountryRepo {
  final NetworkService networkService;
  CountryRepo({required this.networkService});

  Future<Either<String, CountryResponse>> getCountry({int page});
}
