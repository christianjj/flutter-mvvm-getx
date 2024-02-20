import 'package:flutter/material.dart';
import 'package:flutter_restapi/app/app_prefs.dart';
import 'package:flutter_restapi/data/data_source/local_data_source.dart';
import 'package:flutter_restapi/presentation/resources/assets_manager.dart';
import 'package:flutter_restapi/presentation/resources/routes_manager.dart';
import 'package:flutter_restapi/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/dependecy_injection.dart';
import '../resources/strings_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppPreferences _appPreferences = instance<AppPreferences>();
  LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(AppStrings.changeLanguage,
              style: Theme.of(context).textTheme.titleSmall),
          leading: SvgPicture.asset(ImageAssets.changeLangauge),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(AppStrings.contactUs,
              style: Theme.of(context).textTheme.titleSmall),
          leading: SvgPicture.asset(ImageAssets.contactUs),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(AppStrings.inviteFriends,
              style: Theme.of(context).textTheme.titleSmall),
          leading: SvgPicture.asset(ImageAssets.inviteFriends),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(AppStrings.signature,
              style: Theme.of(context).textTheme.titleSmall),
          leading: SvgPicture.asset(ImageAssets.logout),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
          onTap: () {
            Navigator.pushNamed(context, Routes.signatureRoute);
          },
        ),
        ListTile(
          title: Text(AppStrings.logout,
              style: Theme.of(context).textTheme.titleSmall),
          leading: SvgPicture.asset(ImageAssets.logout),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
          onTap: () {
            _onLogout();
          },
        ),
      ],
    );
  }

  void _changeLanguage() {}

  void _contactUs() {}

  void _inviteFriends() {}

  void _onLogout() {
    _localDataSource.clearCache();
    _appPreferences.logout();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
