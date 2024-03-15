import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/register_model.dart';
import 'package:kafiil_test/core/network/network_layer.dart';

abstract class RegisterRepo {
  final NetworkService networkService;
  RegisterRepo({required this.networkService});

  Future<Either<Map<String, String>, bool>> register(
      RegisterModel registerModel);
}
