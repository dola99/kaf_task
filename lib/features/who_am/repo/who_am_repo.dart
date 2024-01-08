import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/network_layer.dart';

abstract class WhoAmRepo {
  final NetworkService networkService;
  WhoAmRepo({required this.networkService});

  Future<Either<String, GenericResponse<UserData>>> getUserData();
}
