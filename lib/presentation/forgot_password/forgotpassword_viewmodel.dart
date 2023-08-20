import 'dart:async';


import 'package:flutter_restapi/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_restapi/presentation/base/baseviewmodel.dart';
import 'package:flutter_restapi/presentation/base/common/state_renderer/state_renderer.dart';

import '../../app/functions.dart';
import '../base/common/freezed_data.dart';
import '../base/common/state_renderer/state_renderer.impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _isEmailInputValidStreamController =
  StreamController<void>.broadcast();


//  var forgotPasswordObject = ForgotPasswordObject("");

  ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";

  @override
  void dispose() {
    _emailStreamController.close();
    _isEmailInputValidStreamController.close();

  }

  @override
  void start() {
    //view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase?.execute(
        email))
        ?.fold(
            (failure) => {
          inputState.add(ErrorState(
              StateRendererType.POPUP_ERROR_STATE, failure.message))
        },
            (data)  => {inputState.add(ContentState())}
       // isLoggedInSuccessfullyStreamController.add(true);
        );

  }


  @override
  setEmail(String email) {
    inputEmailText.add(email);
    this.email = email;
    _validate();
  }

  bool _isEmailInputValid(String email){
    return email.isNotEmpty;
  }

  _validate(){
    inputEmailValid.add(null);
  }




  @override
  Sink get inputEmailValid => _isEmailInputValidStreamController;

  @override
  Sink get inputEmailText => _emailStreamController.sink;


  @override
  Stream<bool> get outputEmailValid => _isEmailInputValidStreamController.stream.map((event) => isEmailValid(email));

  @override
  Stream<bool> get outputEmailText => _emailStreamController.stream.map((email) => _isEmailInputValid(email));



  // @override
  // login() async {
  //   inputState.add(
  //       LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
  //   (await _loginUseCase?.execute(
  //           LoginUseCaseInput(loginObject.userName, loginObject.password)))
  //       ?.fold(
  //           (failure) => {
  //                 inputState.add(ErrorState(
  //                     StateRendererType.POPUP_ERROR_STATE, failure.message))
  //               },
  //           (data)  {inputState.add(ContentState());
  //           isLoggedInSuccessfullyStreamController.add(true);
  //           });
  //
  // }




}

abstract mixin class ForgotPasswordViewModelInputs {
  //three functions
  setEmail(String email);
  forgotPassword();
  // two sinks
  Sink get inputEmailText;
  Sink get inputEmailValid;
}

abstract mixin class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputEmailValid;
  Stream<bool> get outputEmailText;
}
