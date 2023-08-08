import 'package:flutter/material.dart';
import 'package:flutter_restapi/presentation/login/login_viewmodel.dart';
import 'package:flutter_restapi/presentation/resources/color_manager.dart';
import 'package:flutter_restapi/presentation/resources/strings_manager.dart';
import 'package:flutter_restapi/presentation/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel(
      null); //to do pass here login usecase
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPass(_passwordController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(ImageAssets.onboarding_logo1),
                SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p20, right: AppPadding.p20),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllValid
                      , builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(onPressed: (snapshot.data ??
                            false)
                            ? () {
                          _viewModel.login();
                        }
                            : null
                            , child: Text(AppStrings.Login)),
                      );
                    },
                    )),

                Padding(padding: EdgeInsets.only(
                    top: AppPadding.p8, left: AppPadding.p28, right: AppPadding.p28),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.forGotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        )),

                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.registerText,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        )),
                  ],
                  ),

                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
