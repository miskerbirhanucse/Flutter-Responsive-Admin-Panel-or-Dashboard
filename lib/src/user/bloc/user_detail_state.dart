import 'package:freezed_annotation/freezed_annotation.dart';

import '../../auth/models/user.dart';

part 'user_detail_state.freezed.dart';

@freezed
class UserDetailState with _$UserDetailState {
  const UserDetailState._();

  const factory UserDetailState.loading() = _Loading;

  const factory UserDetailState.unauthenticated() = _Unauthenticated;

  const factory UserDetailState.data(User user) = _Data;

  const factory UserDetailState.failure([String? message]) = _Failure;
}
