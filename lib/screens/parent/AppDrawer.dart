import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/on_boarding/OnBoardingScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/screens/settings/SettingsScreen.dart';
import 'package:Aayan/util/aayan_icons.dart';
import 'package:Aayan/util/session_manager_util.dart';
import 'package:Aayan/widgets/app_drawer_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Aayan/extensions/app_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<String> titles = [
    'Home',
    'My Leased Vehicles',
    'My Purchased Vehicles',
    'My Servicings',
    'My Emergency Requests',
    'About Us',
    'Contact Us',
    'العربية'
  ];
  List<IconData> icons = [
    AayanIcons.home,
    /*AayanIcons.lease,
    AayanIcons.purchase,
    AayanIcons.servicing,
    Icons.warning_amber_rounded,*/
    Icons.info,
    AayanIcons.contact_us,
    AayanIcons.translate
  ];

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    titles = _appProvider.getBoolIsLoggedIn?[
      '${AppLocalizations.of(context).home}',/*
      '${AppLocalizations.of(context).myLeasedVehicles}',
      '${AppLocalizations.of(context).myPurchasedVehicles}',
      '${AppLocalizations.of(context).mySevicings}',
      '${AppLocalizations.of(context).myEmergencyRequests}',*/
      '${AppLocalizations.of(context).aboutUs}',
      '${AppLocalizations.of(context).contactUs}',
      _appProvider.getIsEnglish ?'Change language' :'تغيير اللغة'
    ]:[
      '${AppLocalizations.of(context).home}',
      '${AppLocalizations.of(context).aboutUs}',
      '${AppLocalizations.of(context).contactUs}',
      _appProvider.getIsEnglish ?'Change language' :'تغيير اللغة'
    ];
    icons = _appProvider.getBoolIsLoggedIn?[
    AayanIcons.home,/*
    AayanIcons.lease,
    AayanIcons.purchase,
    AayanIcons.servicing,
    Icons.warning_amber_rounded,*/
    Icons.info,
    AayanIcons.contact_us,
    AayanIcons.translate
    ]:[
    AayanIcons.home,
    Icons.info,
    AayanIcons.contact_us,
    AayanIcons.translate
    ];

    return Container(
      color: Colors.white,
      child: Drawer(
        child: SingleChildScrollView(
          padding: _appProvider.isEnglish
              ? EdgeInsets.only(left: 24, right: 0)
              : EdgeInsets.only(left: 0, right: 24),
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context).hi.capitalize()}, ${_appProvider.getBoolIsLoggedIn ? _appProvider.userModel.name?.capitalize() : '${AppLocalizations.of(context).guest.capitalize()}'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w500),
                        ),
                        /*Visibility(
                          visible: _appProvider.getBoolIsLoggedIn,
                          child: Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: Color(0xFFF9A602),
                              ),
                              Text(
                                '${_appProvider.getCurrentUser().loyaltyPoints}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF9A602),
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        )*/
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.settings_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: _appProvider.getBoolIsLoggedIn
                          ? () {
                              Provider.of<AppProvider>(context, listen: false)
                                ..toggleNavOpen();
                              Navigator.of(context)
                                  .pushNamed(SettingsScreen.routeName);
                            }
                          : () async {
                              Provider.of<AppProvider>(context, listen: false)
                                ..toggleNavOpen();
                              Provider.of<AppProvider>(context, listen: false)
                                  .setIsFreshLoggingIn(false);
                              await Navigator.of(context)
                                  .pushNamed(LoginScreen.routeName);
                            })
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              for (int i = 0; i < titles.length; i++)
                AppDrawerTile(
                  icon: icons[i],
                  text: titles[i],
                  isSelected: i == _appProvider.getCurrentPage,
                  onPressed: icons[i] != AayanIcons.translate
                      ? icons[i] == AayanIcons.contact_us
                          ? () {
                              Provider.of<AppProvider>(context, listen: false)
                                ..toggleNavOpen();
                              Future.delayed(Duration(milliseconds: 150),(){
                                UrlLauncher.launch("tel://${_appProvider.getContactUsNumber()}");
                              });

                            }
                          : () {
                              Provider.of<AppProvider>(context, listen: false)
                                ..setCurrentPage(i)
                                ..toggleNavOpen();
                            }
                      : () {
                    _appProvider.getIsEnglish?SessionManagerUtil.putString('language', 'ar'):SessionManagerUtil.putString('language', 'en');
                          Provider.of<AppProvider>(context, listen: false)
                            ..toggleNavOpen()
                            ..toggleLanguage();
                        },
                ),
              Divider(),
              Visibility(
                visible: _appProvider.getBoolIsLoggedIn,
                child: AppDrawerTile(
                  icon: AayanIcons.icon_open_account_logout,
                  text: '${AppLocalizations.of(context).logout}',
                  isSelected: false,
                  onPressed: () {
                    Provider.of<AppProvider>(context, listen: false)
                      ..toggleNavOpen();
                    Provider.of<AppProvider>(context, listen: false).reset();
                    final snackBar = SnackBar(
                        content: Text(
                          '${AppLocalizations.of(context).loggedOut}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Theme.of(context).primaryColor);

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    /*Navigator.of(context).pushNamedAndRemoveUntil(
                        OnBoardingScreen.routeName, ModalRoute.withName('/'));*/
                    SessionManagerUtil.clearAll();
                    SessionManagerUtil.putBoolean('firstTime', true);
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
