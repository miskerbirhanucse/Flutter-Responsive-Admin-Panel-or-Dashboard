import 'package:admin/src/auth/models/user.dart';
import 'package:admin/src/user/models/users.dart';
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
      print(url);
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

  @override
  Future<ApiResult<Users>> getUsers(int page) async {
    try {
      final url = UserEndpoints.getUsers;
      final response = await dio.get('$url?page=$page');
      final Users userResponse = Users.fromJson(response.data);
      return ApiResult.success(data: userResponse);
    } on DioError catch (e) {
      // print(e.response!.data);
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }
}
