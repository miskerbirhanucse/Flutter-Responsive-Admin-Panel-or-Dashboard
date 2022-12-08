import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.signedInUser(User user) = _SignedInUser;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.registered() = _Registered;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.failure([String? message]) = _Failure;
}
