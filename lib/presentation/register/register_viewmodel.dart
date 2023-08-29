import 'dart:async';
import 'dart:io';

import 'package:flutter_restapi/domain/usecase/register_usecase.dart';
import 'package:flutter_restapi/presentation/base/baseviewmodel.dart';
import 'package:flutter_restapi/presentation/base/common/freezed_data.dart';

import '../../app/functions.dart';
import '../base/common/state_renderer/state_renderer.dart';
import '../base/common/state_renderer/state_renderer.impl.dart';

class RegistrationViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  final StreamController isLoggedInSuccessfullyStreamController =
  StreamController<bool>();

  RegisterUseCase _registerUseCase;

  RegistrationViewModel(this._registerUseCase);

  var registrationViewObject = RegistrationObject("", "", "", "", "", "");

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
    isLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get outputEmail =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail =>
      outputEmail.map((isEmailValid) => isEmailValid ? null : "Invalid email");

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputMobileNumber.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Invalid Mobile Number");

  @override
  Stream<bool> get outputMobileNumber => _mobileNumberStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase?.execute(RegisterUseCaseInput(
            registrationViewObject.countryMobileCode,
            registrationViewObject.userName,
            registrationViewObject.email,
            registrationViewObject.password,
            registrationViewObject.mobileNumber,
            registrationViewObject.profilePicture)))
        ?.fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                }, (data) {
      inputState.add(ContentState());
       isLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registrationViewObject =
          registrationViewObject.copyWith(countryMobileCode: countryCode);
    } else {
      registrationViewObject =
          registrationViewObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registrationViewObject = registrationViewObject.copyWith(email: email);
    } else {
      registrationViewObject = registrationViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registrationViewObject =
          registrationViewObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registrationViewObject =
          registrationViewObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registrationViewObject =
          registrationViewObject.copyWith(password: password);
    } else {
      registrationViewObject = registrationViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      registrationViewObject =
          registrationViewObject.copyWith(profilePicture: file.path);
    } else {
      registrationViewObject =
          registrationViewObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registrationViewObject =
          registrationViewObject.copyWith(userName: userName);
    } else {
      registrationViewObject = registrationViewObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  Sink get inputAllInputsValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputAllInputsValid =>
      _isAllInputValidStreamController.stream.map((_) => _validateAllInputs());

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isMobileNumberValid(mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _validateAllInputs() {
    print(
        " ${registrationViewObject.userName}, "
            " ${registrationViewObject.profilePicture},"
            "  ${registrationViewObject.countryMobileCode},"
            " ${registrationViewObject.mobileNumber}, "
            "${registrationViewObject.password}, "
            " ${registrationViewObject.email}");
    return registrationViewObject.profilePicture.isNotEmpty &&
        registrationViewObject.countryMobileCode.isNotEmpty &&
        registrationViewObject.password.isNotEmpty &&
        registrationViewObject.userName.isNotEmpty &&
        registrationViewObject.mobileNumber.isNotEmpty &&
        registrationViewObject.email.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract mixin class RegisterViewModelInputs {
  //three functions
  register();

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setCountryCode(String countryCode);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File file);

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;
}

abstract mixin class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputMobileNumber;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputEmail;

  Stream<String?> get outputErrorEmail;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAllInputsValid;
}
