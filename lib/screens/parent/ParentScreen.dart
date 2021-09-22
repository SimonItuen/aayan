import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/about_us/AboutUsScreen.dart';
import 'package:Aayan/screens/home/HomeScreen.dart';
import 'package:Aayan/screens/notifications/NotificationsScreen.dart';
import 'package:Aayan/screens/parent/AppDrawer.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ParentScreen extends StatefulWidget {
  static final String routeName = '/parent';

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    if (Provider.of<AppProvider>(context, listen: false).getIsNavOpen) {
      Provider.of<AppProvider>(context, listen: false).toggleNavOpen();
      return false;
    } else {
      return true;
    }
    // return
  }

  List<Widget> children = [
    HomeScreen(),
    AboutUsScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    OneSignal.shared.setAppId("7fa1cdba-e211-4ce1-962c-8a77e915b31f");


// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
      print('How ccan ${result.notification.additionalData.toString()}');
      Navigator.of(context).pushNamed(NotificationsScreen.routeName);
    });
    OneSignal.shared.setInAppMessageClickedHandler((OSInAppMessageAction action) {
      // Will be called whenever a notification is opened/button pressed.
      print('How cane ${action.jsonRepresentation().replaceAll("\\n", "\n")}');
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    /*if (Provider.of<AppProvider>(context, listen: false).getBoolIsLoggedIn) {
      HttpService.myDetails(context);
      HttpService.getMostRecentSearchedLeaseVehicles(context);
      HttpService.getMostRecentSearchedUsedVehicles(context);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Row(
        children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 150),
              constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: _appProvider.getIsNavOpen
                      ? MediaQuery.of(context).size.width * 0.75
                      : 0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  GestureDetector(
                      onPanUpdate: (details) {
                        if (_appProvider.getIsEnglish) {
                          if (details.delta.dx < 0) {
                            if (_appProvider.getIsNavOpen) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .toggleNavOpen();
                            }
                          }
                        } else if (!_appProvider.getIsEnglish) {
                          if (details.delta.dx > 0) {
                            if (_appProvider.getIsNavOpen) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .toggleNavOpen();
                            }
                          }
                        }
                      },
                      child: AppDrawer()),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: -5,
                          blurRadius: 5,
                          // changes position of shadow
                        )
                      ]),
                    ),
                  )
                ],
              )),
          Expanded(
            flex: _appProvider.getIsNavOpen ? 25 : 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                    appBar: AppBar(
                      title: _appProvider.getCurrentPage==1? Text('${AppLocalizations.of(context).aboutUs}', style: TextStyle(color: Colors.black),):Container(),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      iconTheme: IconThemeData(color: Colors.black),
                      leading: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Provider.of<AppProvider>(context, listen: false)
                                .toggleNavOpen();
                          }),
                      actions: [
                        /*IconButton(
                            icon: Icon(
                              Icons.stars_rounded,
                              color: Color(0xFFF9A602),
                            ),
                            onPressed: () {}),*/
                      ],
                    ),
                    body: GestureDetector(
                        onTap: () {
                          if (_appProvider.getIsNavOpen) {
                            Provider.of<AppProvider>(context, listen: false)
                                .toggleNavOpen();
                          }
                        },
                        onPanUpdate: (details) {
                          if (_appProvider.getIsEnglish) {
                            if (details.delta.dx < 0) {
                              if (_appProvider.getIsNavOpen) {
                                Provider.of<AppProvider>(context, listen: false)
                                    .toggleNavOpen();
                              }
                            }
                          } else if (!_appProvider.getIsEnglish) {
                            if (details.delta.dx > 0) {
                              if (_appProvider.getIsNavOpen) {
                                Provider.of<AppProvider>(context, listen: false)
                                    .toggleNavOpen();
                              }
                            }
                          }
                        },
                        child: AbsorbPointer(
                            absorbing: _appProvider.getIsNavOpen,
                            child: children[_appProvider.getCurrentPage]))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
