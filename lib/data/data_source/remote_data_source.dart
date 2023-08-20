import 'package:flutter_restapi/data/request/request.dart';
import 'package:flutter_restapi/data/responses/responses.dart';

import '../network/app_api.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", "");
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async{
   return await _appServiceClient.forgotPassword(email);
  }




}