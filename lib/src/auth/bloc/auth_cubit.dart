import 'package:admin/constants/auth_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../../network/api_client.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._apiClient) : super(const AuthState.initial());
  final ApiClient _apiClient;
  static const storage = FlutterSecureStorage();

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    final apiResult = await _apiClient.login(email: email, password: password);
    apiResult.when(
      success: (data) async {
        await storage.write(key: AuthKey.key, value: data.token);
        GetIt.I<ApiClient>().authToken = data.token;
        emit(AuthState.signedInUser(data.user));
      },
      failure: (error) => AuthState.failure(error.toString()),
    );
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    emit(const AuthState.loading());
    final apiResult = await _apiClient.register(
        email: email, name: name, password: password, phone: phone);
    apiResult.when(
      success: (data) => emit(
        const AuthState.authenticated(),
      ),
      failure: (error) => AuthState.failure(error.toString()),
    );
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await storage.read(key: AuthKey.key);
    if (isLoggedIn == null) {
      emit(const AuthState.unauthenticated());
    } else {
      GetIt.I<ApiClient>().authToken = isLoggedIn;
      emit(const AuthState.authenticated());
    }
  }

  Future<void> logout() async {
    await storage.delete(key: AuthKey.key);
    _apiClient.authToken = null;
    emit(const AuthState.unauthenticated());
  }
}
