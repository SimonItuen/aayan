import 'package:Aayan/l10n/l10n.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/change_password/ChangePasswordScreen.dart';
import 'package:Aayan/screens/compare/CompareLeaseDetailsScreen.dart';
import 'package:Aayan/screens/compare/CompareLeaseScreen.dart';
import 'package:Aayan/screens/compare/CompareUsedDetailsScreen.dart';
import 'package:Aayan/screens/compare/CompareUsedScreen.dart';
import 'package:Aayan/screens/filter/BrandLeaseVehicleScreen.dart';
import 'package:Aayan/screens/filter/BrandUsedVehicleScreen.dart';
import 'package:Aayan/screens/filter/FilterLeaseVehicleScreen.dart';
import 'package:Aayan/screens/filter/FilterUsedVehicleScreen.dart';
import 'package:Aayan/screens/filter/LeasePeriodLeaseVehicleScreen.dart';
import 'package:Aayan/screens/filter/ModelLeaseVehicleScreen.dart';
import 'package:Aayan/screens/filter/ModelUsedVehicleScreen.dart';
import 'package:Aayan/screens/filter/SubModelLeaseVehicleScreen.dart';
import 'package:Aayan/screens/filter/SubModelUsedVehicleScreen.dart';
import 'package:Aayan/screens/filter/YearLeaseVehicleScreen.dart';
import 'package:Aayan/screens/filter/YearUsedVehicleScreen.dart';
import 'package:Aayan/screens/forgot_password/ForgotPasswordScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseImageSliderScreen.dart';
import 'package:Aayan/screens/lease_vehicle/AddLeaseVehicleScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleDetailsScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleSearchScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/my_profile/MyProfileScreen.dart';
import 'package:Aayan/screens/notifications/NotificationDetailsScreen.dart';
import 'package:Aayan/screens/notifications/NotificationsScreen.dart';
import 'package:Aayan/screens/on_boarding/OnBoardingScreen.dart';
import 'package:Aayan/screens/otp/OTPScreen.dart';
import 'package:Aayan/screens/otp/RegisterOTPScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/screens/register/RegisterScreen.dart';
import 'package:Aayan/screens/home/HomeScreen.dart';
import 'package:Aayan/screens/settings/SettingsScreen.dart';
import 'package:Aayan/screens/start_up/StartUpScreen.dart';
import 'package:Aayan/screens/update_password/UpdatePasswordScreen.dart';
import 'package:Aayan/screens/used_vehicle/AddUsedVehicleScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedImageSliderScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleDetailsScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleSearchScreen.dart';
import 'package:Aayan/util/colors_util.dart';
import 'package:Aayan/util/session_manager_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> getLanguage(BuildContext context) async {
  String currentLanguage;

  ///SI:Initialize a String theme;
  await SessionManagerUtil.getInstance();

  ///SI:This instantiates the session manager--this is local storage
  if (SessionManagerUtil.getString('language') == null ||
      SessionManagerUtil.getString('language').toString().trim().isEmpty) {
    currentLanguage = 'en';
    SessionManagerUtil.putString('language', currentLanguage);

    ///SI:if there was no initialTheme set in the local storage, it sets it to light them, so by default the app is automatically on light theme
  } else {
    ///SI:If there is a theme in the local storage we use that.
    currentLanguage = SessionManagerUtil.getString('language');
  }

  ///SI:Initialize this theme as the current theme

  ///SI:Set the theme mode variable in the AppViewModel
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //Remove this method to stop OneSignal Debugging
  /*OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("7fa1cdba-e211-4ce1-962c-8a77e915b31f");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  print("Accepted permission: $accepted");
  });*/
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      ///SI:Future builder to help parse the value of the getDefaultTheme method
      future: getLanguage(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            locale: Provider.of<AppProvider>(context, listen: true).getIsEnglish
                ? Locale('en', '')
                : Locale('ar', 'AE'),
            title: 'Aayan',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: ColorsUtil.primaryColor,
              fontFamily:
                  Provider.of<AppProvider>(context, listen: true).getIsEnglish
                      ? 'Poppins'
                      : 'Almarai',
            ),
            routes: {
              '/': (_) => StartUpScreen(),
              OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
              LoginScreen.routeName: (_) => LoginScreen(),
              RegisterScreen.routeName: (_) => RegisterScreen(),
              ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
              OTPScreen.routeName: (_) => OTPScreen(),
              RegisterOTPScreen.routeName: (_) => RegisterOTPScreen(),
              ChangePasswordScreen.routeName: (_) => ChangePasswordScreen(),
              UpdatePasswordScreen.routeName: (_) => UpdatePasswordScreen(),
              ParentScreen.routeName: (_) => ParentScreen(),
              NotificationsScreen.routeName: (_) => NotificationsScreen(),
              NotificationDetailsScreen.routeName: (_) =>
                  NotificationDetailsScreen(),
              LeaseVehicleScreen.routeName: (_) => LeaseVehicleScreen(),
              LeaseImageSliderScreen.routeName: (_) => LeaseImageSliderScreen(),
              AddLeaseVehicleScreen.routeName: (_) => AddLeaseVehicleScreen(),
              LeaseVehicleSearchScreen.routeName: (_) =>
                  LeaseVehicleSearchScreen(),
              LeaseVehicleDetailsScreen.routeName: (_) =>
                  LeaseVehicleDetailsScreen(),
              UsedVehicleScreen.routeName: (_) => UsedVehicleScreen(),
              UsedImageSliderScreen.routeName: (_) => UsedImageSliderScreen(),
              AddUsedVehicleScreen.routeName: (_) => AddUsedVehicleScreen(),
              UsedVehicleSearchScreen.routeName: (_) =>
                  UsedVehicleSearchScreen(),
              UsedVehicleDetailsScreen.routeName: (_) =>
                  UsedVehicleDetailsScreen(),
              CompareLeaseVehicleScreen.routeName: (_) =>
                  CompareLeaseVehicleScreen(),
              CompareUsedVehicleScreen.routeName: (_) =>
                  CompareUsedVehicleScreen(),
              FilterLeaseVehicleScreen.routeName: (_) =>
                  FilterLeaseVehicleScreen(),
              BrandLeaseVehicleScreen.routeName: (_) =>
                  BrandLeaseVehicleScreen(),
              ModelLeaseVehicleScreen.routeName: (_) =>
                  ModelLeaseVehicleScreen(),
              SubModelLeaseVehicleScreen.routeName: (_) =>
                  SubModelLeaseVehicleScreen(),
              YearLeaseVehicleScreen.routeName: (_) => YearLeaseVehicleScreen(),
              LeasePeriodLeaseVehicleScreen.routeName: (_) =>
                  LeasePeriodLeaseVehicleScreen(),
              FilterUsedVehicleScreen.routeName: (_) =>
                  FilterUsedVehicleScreen(),
              BrandUsedVehicleScreen.routeName: (_) => BrandUsedVehicleScreen(),
              ModelUsedVehicleScreen.routeName: (_) => ModelUsedVehicleScreen(),
              SubModelUsedVehicleScreen.routeName: (_) =>
                  SubModelUsedVehicleScreen(),
              YearUsedVehicleScreen.routeName: (_) => YearUsedVehicleScreen(),
              CompareLeaseDetailsScreen.routeName: (_) =>
                  CompareLeaseDetailsScreen(),
              CompareUsedDetailsScreen.routeName: (_) =>
                  CompareUsedDetailsScreen(),
              SettingsScreen.routeName: (_) => SettingsScreen(),
              MyProfileScreen.routeName: (_) => MyProfileScreen(),
            },
          );

          ///SI:Once future is done, we display the material app
        } else {
          return Container();
        }
      },
    );
  }
}
