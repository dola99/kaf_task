import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/core/helpers/secure_sharedprefernce.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/service_urls.dart';
import 'package:kafiil_test/features/who_am/repo/who_am_repo.dart';

class WhoAmRepoImb extends WhoAmRepo {
  WhoAmRepoImb({required super.networkService});

  @override
  Future<Either<String, GenericResponse<UserData>>> getUserData() async {
    networkService.headers['Authorization'] =
        '${await SharedPreferencesHelper.getToken()}';

    inspect(networkService.headers);
    final response = await networkService.getRequest(
      ServicesUrl.whoamIUrl,
    );

    if (response['error'] != null) {
      return Left(response['error']['message']);
    } else {
      return Right(GenericResponse<UserData>.fromJson(
          response, (va) => UserData.fromJson(va)));
    }
  }
}
