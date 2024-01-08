import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/service_model.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/network_layer.dart';

abstract class ServicesRepo {
  final NetworkService networkService;
  ServicesRepo({required this.networkService});

  Future<Either<String, ListResponse<ServiceProduct>>> getServices();

  Future<Either<String, ListResponse<ServiceProduct>>> getPopularService();
}
