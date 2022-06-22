part of 'all_users_bloc.dart';

@immutable
abstract class AllUsersEvent {}

class AllUsersLoadingEvent extends AllUsersEvent {
  final int page;
  final int results;
  AllUsersLoadingEvent({required this.page, required this.results});
}

class AllUsersAddElementsEvent extends AllUsersEvent {
  final int page;
  final int results;
  final List<Results> oldList;
  AllUsersAddElementsEvent({required this.page, required this.results, required this.oldList});
}