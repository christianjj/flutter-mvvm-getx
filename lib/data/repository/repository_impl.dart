import 'package:dartz/dartz.dart';
import 'package:flutter_restapi/data/mapper/mapper.dart';
import 'package:flutter_restapi/data/network/error_handler.dart';
import 'package:flutter_restapi/data/network/failure.dart';
import 'package:flutter_restapi/data/request/request.dart';
import 'package:flutter_restapi/data/responses/responses.dart';
import 'package:flutter_restapi/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthenticationResponse>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.baseResponseStatus == ApiInternalStatus.SUCCESS) //success
        {
          return Right(response.toDomain() as AuthenticationResponse);
        } else {
          return Left(Failure(
              response.baseResponseStatus ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
