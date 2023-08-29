import 'package:flutter_restapi/app/app_prefs.dart';
import 'package:flutter_restapi/data/data_source/remote_data_source.dart';
import 'package:flutter_restapi/data/network/app_api.dart';
import 'package:flutter_restapi/data/network/dio_factory.dart';
import 'package:flutter_restapi/data/network/network_info.dart';
import 'package:flutter_restapi/data/repository/repository_impl.dart';
import 'package:flutter_restapi/domain/repository/repository.dart';
import 'package:flutter_restapi/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_restapi/domain/usecase/home_usecase.dart';
import 'package:flutter_restapi/domain/usecase/login_usecase.dart';
import 'package:flutter_restapi/domain/usecase/register_usecase.dart';
import 'package:flutter_restapi/presentation/forgot_password/forgotpassword_viewmodel.dart';
import 'package:flutter_restapi/presentation/login/login_viewmodel.dart';
import 'package:flutter_restapi/presentation/main/home/home_viewmodel.dart';
import 'package:flutter_restapi/presentation/register/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  //shared preferencce instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(
          () => DioFactory(instance()));

  //app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(
          () => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImplementer(instance()));

  //repository
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance()));


}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
            () => LoginUseCase(instance()));

    instance.registerFactory<LoginViewModel>(
            () => LoginViewModel(instance()));
  }
}
  initForgotPasswordModule() {
    if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
      instance.registerFactory<ForgotPasswordUseCase>(
              () => ForgotPasswordUseCase(instance()));

      instance.registerFactory<ForgotPasswordViewModel>(
              () => ForgotPasswordViewModel(instance()));
    }
  }

  initRegisterModule() {
    if (!GetIt.I.isRegistered<RegisterUseCase>()) {
      instance.registerFactory<RegisterUseCase>(
              () => RegisterUseCase(instance()));
      instance.registerFactory<RegistrationViewModel>(
              () => RegistrationViewModel(instance()));
      instance.registerFactory<ImagePicker>(
              () => ImagePicker());
    }
  }

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
            () => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(
            () => HomeViewModel(instance()));
  }
}