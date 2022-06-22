import '../../../core/dictionaries/errors.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data_sources/all_users_remote_data/all_users_remote_data.dart';
import '../../models/random_api_model.dart';

class AlarmsInfoRepositoryImpl{
  static Future<Either<Failure, RandomApiModel>> getAllUsers(
      {required int page, required int results}
    ) async {
    try{
      final remoteRandomApiData = await RandomApiData().fetch(page: page, results: results);
      return Right(remoteRandomApiData);
    }on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }on ConnectException catch (e){
      return Left(ConnectionFailure(message: e.message));
    }on UnAuthException catch (e){
      return Left(UnAuthFailure(message: e.message));
    } catch(_){
      return Left(ServerFailure(message: Errors.criticalServerErrorTitle));
    }
  }
}