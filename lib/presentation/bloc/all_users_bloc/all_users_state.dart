part of 'all_users_bloc.dart';

@immutable
abstract class AllUsersState {}

class AllUsersLoadingState extends AllUsersState {}

class AllUsersNetworkExceptionState extends AllUsersState {}

class AllUsersFailedState extends AllUsersState {
  final String message;
  AllUsersFailedState({required this.message});
}

class AllUsersDoneState extends AllUsersState {
  final List<Results> users;
  AllUsersDoneState({required this.users});
}
