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
  Future<ApiResult<bool>> adminRegister(
      {required String email,
      required String name,
      required String phone}) async {
    try {
      final url = UserEndpoints.createUser;
      await dio.post(
        url,
        data: {
          "email": email,
          "phone": phone,
          "name": name,
        },
      );
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
      print(userResponse);
      return ApiResult.success(data: userResponse);
    } on DioError catch (e) {
      print(e);
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }

  @override
  Future<ApiResult<User>> getUser(int id) async {
    try {
      final url = UserEndpoints.getUsers;
      final response = await dio.get('$url/$id');
      final User userResponse = User.fromJson(response.data['user']);
      return ApiResult.success(data: userResponse);
    } on DioError catch (e) {
      // print(e.response!.data);
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }

  @override
  Future<ApiResult<User>> changeUserStatus(int id) async {
    try {
      final url = UserEndpoints.changeUserStatus(id);
      final response = await dio.post(url);
      final User userResponse = User.fromJson(response.data['user']);
      return ApiResult.success(data: userResponse);
    } on DioError catch (e) {
      print(e);
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }

  //delete user
  @override
  Future<ApiResult<bool>> deleteUser({required int id}) async {
    try {
      final url = UserEndpoints.getUsers;
      await dio.delete('$url/$id');
      return const ApiResult.success(data: true);
    } on DioError catch (e) {
      // print(e.response!.data);
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }

  @override
  Future<ApiResult<User>> updateProfile(
      {required String email,
      required String name,
      required String phone,
      required int id}) async {
    try {
      final url = UserEndpoints.getUsers;
      final response = await dio.put(
        '$url/$id',
        data: {
          "email": email,
          "name": name,
          "phone": phone,
        },
      );
      final User userResponse = User.fromJson(response.data['user']);
      return ApiResult.success(data: userResponse);
    } on DioError catch (e) {
      // print(e.response!.data);
      return ApiResult.failure(error: NetworkExceptions.fromError(e));
    }
  }
}
