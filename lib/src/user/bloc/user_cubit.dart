import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/client.dart';
import '../../auth/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._apiClient) : super(UserInitial());
  final ApiClient _apiClient;
  bool isFetching = false;
  int page = 1;

  Future<void> getUsers() async {
    if (state is UserLoading) return;
    emit(UserLoading());
    final currentState = state;
    var oldInquiries = <User>[];
    if (currentState is UserListLoaded) {
      oldInquiries = currentState.users!;
    }
    emit(UserListLoading(oldInquiries, isFirstFetch: page == 1));

    final apiResult = await _apiClient.getUsers(page);

    apiResult.when(
      success: (data) {
        page++;
        final userList = (state as UserListLoading).oldUsers;
        userList!.addAll(data.user!);
        emit(
          UserListLoaded(userList),
        );
      },
      failure: (error) => Failure(error.toString()),
    );
  }
}
