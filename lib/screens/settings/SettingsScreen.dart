import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/my_profile/MyProfileScreen.dart';
import 'package:Aayan/screens/update_password/UpdatePasswordScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class SettingsScreen extends StatefulWidget {
  static final String routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool onNotification = true;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          '${AppLocalizations.of(context).settings.capitalize()}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SettingsTile(
                  title: Text(
                    '${AppLocalizations.of(context).myProfile.capitalize()}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF212121)),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Color(0xFF9E9E9E),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyProfileScreen.routeName);
                  },
                ),
                /*SettingsTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppLocalizations.of(context).loyaltyPoints.capitalize()}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF212121)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            color: Color(0xFFF9A602),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: Icon(
                                Icons.stars_rounded,
                                color: Color(0xFF212121),
                              ),
                            ),
                            Text(
                              '${_appProvider.getCurrentUser().loyaltyPoints}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF212121)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Color(0xFF9E9E9E),
                  ),
                ),*/
                SettingsTile(
                  title: Text(
                    '${AppLocalizations.of(context).changePassword.capitalize()}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF212121)),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Color(0xFF9E9E9E),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(UpdatePasswordScreen.routeName);
                  },
                ),
                Padding(padding: EdgeInsets.all(4)),
                SettingsTile(
                  title: Text(
                    '${AppLocalizations.of(context).notifications.capitalize()}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF212121)),
                  ),
                  trailing: FlutterSwitch(
                    value: onNotification,
                    padding: 2,
                    toggleSize: MediaQuery.of(context).size.width *
                        0.09722222 *
                        0.42857,
                    width: MediaQuery.of(context).size.width * 0.09722222,
                    height: MediaQuery.of(context).size.width *
                        0.09722222 *
                        0.57142,
                    activeColor: Theme.of(context).primaryColor,
                    onToggle: (value) {
                      setState(() {
                        onNotification = value;
                      });
                    },
                  ),
                  onPressed: () {
                    setState(() {
                      onNotification = !onNotification;
                    });
                  },
                ),
              ],
            ),
          ),
          Positioned.fill(
              child: Visibility(
                  visible: isLoading,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(child: CircularProgressIndicator()),
                  )))
        ],
      ),
    );
  }
}
