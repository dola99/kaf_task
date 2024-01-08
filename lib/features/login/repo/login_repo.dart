import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/network_layer.dart';

abstract class LoginRepo {
  final NetworkService networkService;
  LoginRepo({required this.networkService});

  Future<Either<Map<String, String>, GenericResponse<UserData>>> login(
      Map<String, dynamic> logincredentials);
}
