import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/change_password/ChangePasswordScreen.dart';
import 'package:Aayan/screens/compare/CompareDetailsScreen.dart';
import 'package:Aayan/screens/compare/CompareScreen.dart';
import 'package:Aayan/screens/forgot_password/ForgotPasswordScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleDetailsScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleSearchScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/on_boarding/OnBoardingScreen.dart';
import 'package:Aayan/screens/otp/OTPScreen.dart';
import 'package:Aayan/screens/otp/RegisterOTPScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/screens/register/RegisterScreen.dart';
import 'package:Aayan/screens/home/HomeScreen.dart';
import 'package:Aayan/screens/start_up/StartUpScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleDetailsScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleSearchScreen.dart';
import 'package:Aayan/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', 'AE'),
        const Locale('en', ''),
      ],
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
        fontFamily: 'Poppins',
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
        ParentScreen.routeName: (_) => ParentScreen(),
        LeaseVehicleScreen.routeName: (_) => LeaseVehicleScreen(),
        LeaseVehicleSearchScreen.routeName: (_) => LeaseVehicleSearchScreen(),
        LeaseVehicleDetailsScreen.routeName: (_) => LeaseVehicleDetailsScreen(),
        UsedVehicleScreen.routeName: (_) => UsedVehicleScreen(),
        UsedVehicleSearchScreen.routeName: (_) => UsedVehicleSearchScreen(),
        UsedVehicleDetailsScreen.routeName: (_) => UsedVehicleDetailsScreen(),
        CompareScreen.routeName: (_) => CompareScreen(),
        CompareDetailsScreen.routeName: (_) => CompareDetailsScreen(),
      },
    );
  }
}
