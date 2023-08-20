import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/presentation/resources/color_manager.dart';
import 'package:flutter_restapi/presentation/resources/routes_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/dependecy_injection.dart';
import '../resources/assets_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  AppPreferences _appPreferences = instance<AppPreferences>();
  _startDelay(){
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext() async{
    _appPreferences.getUserLoggedIn().then((getUserLoggedIn) =>
    {
      if(getUserLoggedIn){
        Navigator.pushReplacementNamed(context, Routes.mainRoute)
      } else
        {
          _appPreferences.getOnBoardingScreenView().then((getOnBoardingScreenView) =>{
            if(getOnBoardingScreenView){
              Navigator.pushReplacementNamed(context, Routes.loginRoute)
            }else{
              Navigator.pushReplacementNamed(context, Routes.onBoardingRoutes)
            }

          })
        }
    }

    );


  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: ColorManager.primary,
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo),)),
    );
  }
}
