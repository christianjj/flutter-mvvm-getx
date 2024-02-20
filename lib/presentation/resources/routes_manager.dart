import 'package:flutter/material.dart';
import 'package:flutter_restapi/app/dependecy_injection.dart';
import 'package:flutter_restapi/presentation/forgot_password/forgot_password.dart';
import 'package:flutter_restapi/presentation/login/login.dart';
import 'package:flutter_restapi/presentation/main/main_view.dart';
import 'package:flutter_restapi/presentation/onboarding/onboarding.dart';
import 'package:flutter_restapi/presentation/register/register.dart';
import 'package:flutter_restapi/presentation/resources/strings_manager.dart';
import 'package:flutter_restapi/presentation/splash/splash.dart';
import 'package:flutter_restapi/presentation/store_detail/store_detail.dart';

import '../signature/signature.dart';

class Routes{
  static const String splashRoute = "/";
  static const String onBoardingRoutes = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String signatureRoute = "/signature";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String forGotPasswordRoute = "/forgotPassword";
}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case Routes.splashRoute:
      return MaterialPageRoute(builder: (_)=> const SplashView());
    case Routes.onBoardingRoutes:
      return MaterialPageRoute(builder: (_)=> const OnBoardingView());
    case Routes.loginRoute:
      initLoginModule();
      return MaterialPageRoute(builder: (_)=> const LoginView());
    case Routes.registerRoute:
      initRegisterModule();
      return MaterialPageRoute(builder: (_)=> const RegisterView());
    case Routes.mainRoute:
      initHomeModule();
      return MaterialPageRoute(builder: (_)=> const MainView());
    case Routes.storeDetailsRoute:
      initStoreDetailsModule();
      return MaterialPageRoute(builder: (_)=> const StoreDetailsView());
    case Routes.forGotPasswordRoute:
      initForgotPasswordModule();
      return MaterialPageRoute(builder: (_)=> const ForgotPasswordView());

    case Routes.signatureRoute:
      return MaterialPageRoute(builder: (_)=> const SignatureView());

    default:
      return UnDefineRoute();
  }

  }

  static Route<dynamic> UnDefineRoute(){
    return MaterialPageRoute(builder: (_)=>
    Scaffold(
      appBar: AppBar(title: const Text(AppStrings.noRouteFound),),
      body: const Center(child: Text(AppStrings.noRouteFound)),
    )
    );
  }
}