import 'package:dartz/dartz.dart';


import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../../data/responses/responses.dart';


abstract class Repository {
  Future<Either <Failure,AuthenticationResponse>> login(LoginRequest loginRequest);

}
