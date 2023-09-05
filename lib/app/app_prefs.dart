 import 'package:flutter_restapi/data/mapper/mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
class AppPreferences{

 SharedPreferences _sharedPreferences;

 AppPreferences(this._sharedPreferences);


 Future<void> setOnBoardingScreenView() async{
   _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
 }

 Future<bool> getOnBoardingScreenView() async{
  return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
 }

 Future<void> setUserLoggedIn() async{
  _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
 }

 Future<bool> getUserLoggedIn() async{
  return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
 }

 Future<void> setToken(String token) async{
  _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
 }

 Future<String> getToken() async{
  return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? "NO TOKEN SAVE";
 }


 Future<void> logout() async{
  _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
 }



 }