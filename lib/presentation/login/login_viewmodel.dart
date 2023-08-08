import 'dart:async';

import 'package:flutter_restapi/app/constant.dart';
import 'package:flutter_restapi/domain/usecase/login_usecase.dart';
import 'package:flutter_restapi/presentation/base/baseviewmodel.dart';

import '../base/common/freezed_data.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase? _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllValid => _isAllInputsValidStreamController;

  @override
  login() async {
    // (await _loginUseCase?.execute(
    //         LoginUseCaseInput(loginObject.userName, loginObject.password)))
    //     ?.fold((failure) => {print(failure.message)},
    //         (data) => {print(data.customer?.name)});
  }

  @override
  setPass(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  _validate() {
    inputIsAllValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.userName);
  }

  //outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUsernameValid(username));


  @override
  Stream<bool> get outputIsAllValid => _isAllInputsValidStreamController.stream
      .map((event) => _isAllInputValid());
}

abstract mixin class LoginViewModelInputs {
  //three functions
  setUserName(String userName);

  setPass(String password);

  login();

  // two sinks
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllValid;
}

abstract mixin class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllValid;
}
