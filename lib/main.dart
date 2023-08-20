import 'package:flutter/material.dart';
import 'package:flutter_restapi/app/dependecy_injection.dart';

import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp( MyApp());
}




