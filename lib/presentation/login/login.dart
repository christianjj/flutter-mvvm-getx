import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_restapi/presentation/base/common/state_renderer/state_renderer.impl.dart';
import 'package:flutter_restapi/presentation/login/login_viewmodel.dart';
import 'package:flutter_restapi/presentation/resources/color_manager.dart';
import 'package:flutter_restapi/presentation/resources/strings_manager.dart';
import 'package:flutter_restapi/presentation/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_prefs.dart';
import '../../app/dependecy_injection.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>(); //to do pass here login usecase
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
    _viewModel.isLoggedInSuccessfullyStreamController.stream.listen((isSuccess) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _appPreferences.setUserLoggedIn();
        _appPreferences.setToken(isSuccess);
        resetAllModules();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
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
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapchat) {
        return snapchat.data?.getScreenWidget(context, _getContentWidget(), () {
              _viewModel.login();
            }) ??
            _getContentWidget();
      },
    )
    );
  }

  Widget _getContentWidget() {
      return Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(ImageAssets.onboarding_logo1),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                            enabledBorder: (snapshot.data ?? false)
                                ? OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.green, width: AppSize.s1_5))
                                : OutlineInputBorder(
                                borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5)),
                            hintText: AppStrings.hintUsername,
                            labelText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
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
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p20, right: AppPadding.p20),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.login();
                                    }
                                  : null,
                              child: const Text(AppStrings.Login)),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p20,
                      right: AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.forGotPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword,
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerText,
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  Widget _getContentWidgetv2() {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // iphone141cDf (1:2)
        padding: EdgeInsets.fromLTRB(22 * fem, 25 * fem, 22 * fem, 22 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // atestapplicationzdX (2:5)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 29 * fem),
              child: Text(
                'A TEST APPLICATION',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Container(
              // vectorpsT (2:15)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 30 * fem),
              width: 95 * fem,
              height: 77 * fem,
              child: Image.asset(
                'assets/page-1/images/vector.png',
                width: 95 * fem,
                height: 77 * fem,
              ),
            ),
            Container(
              // frame5Lau (2:13)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 30 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // frame3GjT (2:9)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 15 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // usernameBrR (2:7)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          child: Text(
                            'Username',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        Container(
                          // frame2pnu (2:8)
                          width: double.infinity,
                          height: 42 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff565656)),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // frame4wMj (2:10)
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // passwordHAh (2:11)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          child: Text(
                            'Password',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        Container(
                          // frame2Nxq (2:12)
                          width: double.infinity,
                          height: 42 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff565656)),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // frame6Xaq (2:16)
              width: double.infinity,
              height: 37 * fem,
              decoration: BoxDecoration(
                color: Color(0xffd86a6a),
                borderRadius: BorderRadius.circular(20 * fem),
              ),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
