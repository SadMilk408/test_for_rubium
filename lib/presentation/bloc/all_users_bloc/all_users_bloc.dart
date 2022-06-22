import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/failure.dart';
import '../../../data/models/random_api_model.dart';
import '../../../data/repository/all_users_repo_impl/all_users_repo_impl.dart';

part 'all_users_event.dart';
part 'all_users_state.dart';

class AllUsersBloc extends Bloc<AllUsersEvent, AllUsersState> {
  AllUsersBloc() : super(AllUsersLoadingState()) {
    on<AllUsersLoadingEvent>((event, emit) async {
      emit(AllUsersLoadingState());
      final re = await AlarmsInfoRepositoryImpl.getAllUsers(
          page: event.page, results: event.results);
      re.fold((l) {
        if (l is ConnectionFailure) {
          emit(AllUsersNetworkExceptionState());
        } else if (l is ServerFailure) {
          emit(AllUsersFailedState(message: l.message));
        }
      }, (r) => emit(AllUsersDoneState(users: r.results!)));
    });

    on<AllUsersAddElementsEvent>((event, emit) async {
      final re = await AlarmsInfoRepositoryImpl.getAllUsers(
          page: event.page, results: event.results);
      re.fold(
        (l) {
          if (l is ConnectionFailure) {
            emit(AllUsersNetworkExceptionState());
          } else if (l is ServerFailure) {
            emit(AllUsersFailedState(message: l.message));
          }
        },
        (r) {
          emit(
            AllUsersDoneState(users: [...event.oldList, ...r.results!]),
          );
        },
      );
    });
  }
}
