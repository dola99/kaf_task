import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/core/helpers/secure_sharedprefernce.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/network_layer.dart';
import 'package:kafiil_test/core/network/service_urls.dart';
import 'package:kafiil_test/features/login/repo/login_repo.dart';
import 'package:dartz/dartz.dart';

class LoginRepoImb extends LoginRepo {
  LoginRepoImb({required NetworkService networkService})
      : super(networkService: networkService);

  @override
  Future<Either<Map<String, String>, GenericResponse<UserData>>> login(
      Map<String, dynamic> logincredentials) async {
    final response = await networkService.postRequest(
        ServicesUrl.loginApi, logincredentials);

    if (response.containsKey('errors') && response['errors'] != null) {
      Map<String, String> errorMap = {};

      response['errors'].forEach(
        (key, value) {
          if (value is List && value.isNotEmpty) {
            errorMap[key] = value[0];
          }
        },
      );
      return Left(errorMap);
    } else if (response['error'] != null) {
      return Left({'error': response['error']['message']});
    } else {
      await SharedPreferencesHelper.setToken(response["access_token"]);
      await SharedPreferencesHelper.init();
      return Right(GenericResponse<UserData>.fromJson(
          response, (map) => UserData.fromJson(map)));
    }
    // return Response<String>.fromJson(
    //   jsonResponse,
    //   (itemJson) => MerchantItem.fromJson(itemJson),
    // );
  }
}
