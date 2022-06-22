import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_check_state.dart';

class FavoriteCheckCubit extends Cubit<FavoriteCheckState> {
  FavoriteCheckCubit() : super(FavoriteCheckInitial());

  changeFavorite(bool check){
    emit(FavoriteCheckChangeState(check: check));
  }
}
