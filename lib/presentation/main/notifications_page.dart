
import 'package:flutter/material.dart';
import 'package:flutter_restapi/presentation/resources/strings_manager.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage ({super.key});

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Center (
      child: Text(AppStrings.notification),
    );
  }
}
