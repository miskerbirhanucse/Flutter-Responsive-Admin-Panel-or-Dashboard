part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserListLoaded extends UserState {
  final List<User>? users;

  UserListLoaded(this.users);
}

class UserListLoading extends UserState {
  final List<User>? oldUsers;
  final bool isFirstFetch;

  UserListLoading(this.oldUsers, {this.isFirstFetch = false});
}

class Failure extends UserState {
  final String? message;

  Failure(this.message);
}
