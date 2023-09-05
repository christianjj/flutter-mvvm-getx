import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class ForgotPasswordObject with _$ForgotPasswordObject {
  factory ForgotPasswordObject(String email) = _ForgotPasswordObject;
}

@freezed
class RegistrationObject with _$RegistrationObject {
  factory RegistrationObject(
      String countryMobileCode,
      String userName,
      String email,
      String password,
      String mobileNumber,
      String profilePicture) = _RegistrationObject;
}


