import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/app_data.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/network_layer.dart';

abstract class AppDataRepo {
  final NetworkService networkService;
  AppDataRepo({required this.networkService});

  Future<Either<String, GenericResponse<AppData>>> getAppData();
}
