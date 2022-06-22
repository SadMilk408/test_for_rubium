part of 'favorite_check_cubit.dart';

@immutable
abstract class FavoriteCheckState {}

class FavoriteCheckInitial extends FavoriteCheckState {}

class FavoriteCheckChangeState extends FavoriteCheckState {
  final bool check;
  FavoriteCheckChangeState({required this.check});
}
