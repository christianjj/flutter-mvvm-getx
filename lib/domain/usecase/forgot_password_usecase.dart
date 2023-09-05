import 'package:dartz/dartz.dart';
import 'package:flutter_restapi/app/functions.dart';
import 'package:flutter_restapi/data/network/failure.dart';
import 'package:flutter_restapi/data/request/request.dart';
import 'package:flutter_restapi/data/responses/responses.dart';
import 'package:flutter_restapi/domain/model/model.dart';
import 'package:flutter_restapi/domain/repository/repository.dart';
import 'package:flutter_restapi/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase
    implements BaseUseCase<String, String> {
  Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(
      String input) async {
    return await _repository.forgotPassword(input);
  }
}

