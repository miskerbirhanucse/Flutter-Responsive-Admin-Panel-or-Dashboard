import 'package:admin/src/auth/models/user.dart';
import 'package:dio/dio.dart';

import '../constants/endpoints.dart';
import 'api_client.dart';
import 'core/core.dart';

class ApiClientImpl extends ApiClient {
  ApiClientImpl(Dio dio) : super(dio);

  @override
  Future<ApiResult<UserResponse>> login(
      {required String email, required String password}) async {
    try {
      final url = AuthEndpoints.login;

      final response =
          await dio.post(url, data: {'email': email, 'password': password});
      print(response);
      final UserResponse userResponse = UserResponse.fromJson(response.data);
      return ApiResult.success(data: userResponse);
    } catch (e) {
      print(e);
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }

  @override
  Future<ApiResult<bool>> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final url = AuthEndpoints.sign_up;
      await dio.post(url, data: {
        "email": email,
        "phone": phone,
        "name": name,
        "password": password,
      });
      return const ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }
}
