import 'package:admin/src/user/bloc/user_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/client.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(this._apiClient) : super(const UserDetailState.loading());
  final ApiClient _apiClient;

  Future<void> getUser({required int id}) async {
    final apiResult = await _apiClient.getUser(id);
    apiResult.when(
      success: (data) {
        emit(
          UserDetailState.data(data),
        );
      },
      failure: (error) => emit(UserDetailState.failure(error.toString())),
    );
  }

  Future<void> changeUserStatus({required int id}) async {
    final apiResult = await _apiClient.changeUserStatus(id);
    apiResult.when(
      success: (data) {
        emit(
          UserDetailState.data(data),
        );
      },
      failure: (error) => emit(UserDetailState.failure(error.toString())),
    );
  }

  Future<void> updateProfile(
      {required String email,
      required int id,
      required String name,
      required String phone}) async {
    emit(const UserDetailState.loading());
    final apiResult = await _apiClient.updateProfile(
      email: email,
      id: id,
      name: name,
      phone: phone,
    );
    apiResult.when(
        success: (data) {
          emit(
            UserDetailState.data(data),
          );
        },
        failure: (error) => UserDetailState.failure(error.toString()));
  }
}
