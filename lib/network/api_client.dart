import 'package:admin/src/auth/models/user.dart';
import 'package:admin/src/user/models/users.dart';
import 'package:dio/dio.dart';

import 'core/core.dart';

abstract class ApiClient {
  final Dio _dio;
  String? _authToken;

  String? get authToken => _authToken;

  Dio get dio => _dio;

  bool get isAuthenticated => _authToken != null;

  set authToken(String? token) {
    // debugPrint('Setting ApiClient token: $token');
    _authToken = token;
  }

  ApiClient(this._dio) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_authToken != null) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }

        final body = options.data;

        if (body != null) {
          // debugPrint('Request Body:');
          // _printRequestBody(body);
        }
        return handler.next(options);
      },
    ));
  }

  //Auth
  Future<ApiResult<UserResponse>> login(
      {required String email, required String password});

  Future<ApiResult<bool>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  Future<ApiResult<Users>> getUsers(int page);
}
