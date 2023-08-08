import 'package:dio/dio.dart';
import 'package:flutter_restapi/app/constant.dart';

import 'package:retrofit/retrofit.dart';

import '../responses/responses.dart';
part 'app_api.g.dart';
@RestApi(baseUrl: Constant.baseUrl )
abstract class AppServiceClient{
  factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;

  @POST("/customer/login")
  Future<AuthenticationResponse>login(
  @Field("email") String email,
  @Field("password") String password,
  @Field("imei") String imei,
  @Field("device_type") String deviceType,


  );

}