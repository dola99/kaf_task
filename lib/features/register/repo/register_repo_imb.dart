import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:kafiil_test/Model/register_model.dart';
import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/core/network/generic_model.dart';
import 'package:kafiil_test/core/network/service_urls.dart';
import 'package:kafiil_test/features/register/repo/register_repo.dart';
import 'package:http/http.dart' as http;

class RegisterRepoImb extends RegisterRepo {
  RegisterRepoImb({required super.networkService});

  @override
  Future<Either<Map<String, String>, bool>> register(
      RegisterModel registerModel) async {
    networkService.headers["Content-Type"] = "multipart/form-data";
    final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${ServicesUrl.baseUrl}/${ServicesUrl.register}',
        ));
    request.headers.addAll(networkService.headers);
    for (var entry in registerModel.toJson().entries) {
      request.fields[entry.key] = '${entry.value}';
    }

    inspect(request.fields);
    request.files.add(http.MultipartFile.fromBytes(
      'avatar',
      registerModel.secondRegisterForm.avatarPath!.readAsBytesSync(),
      filename: 'avatar.jpg', // Change the filename accordingly
      // Adjust content type
    ));
    request.files;
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      inspect(response);
      print(response.body);
      // Handle response based on status code
      if (response.statusCode == 200) {
        // Successful response
        return const Right(true);
      } else {
        // Handle other status codes (e.g., 400, 404, 500)
        return Left({'error': 'Server Error: ${response.statusCode}'});
      }
    } catch (error) {
      // Handle other errors (e.g., timeout, network issues)
      return Left({'error': 'Error: $error'});
    }

    // return Response<String>.fromJson(
    //   jsonResponse,
    //   (itemJson) => MerchantItem.fromJson(itemJson),
    // );
  }
}
