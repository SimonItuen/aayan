import 'dart:async';
import 'dart:io';

import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/change_password/ChangePasswordScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/otp/OTPScreen.dart';
import 'package:Aayan/screens/otp/RegisterOTPScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:Aayan/util/session_manager_util.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HttpService {
  static final String baseUrl = "https://laravel.gowebbidemo.com/122320/public/api/v1";

  static HttpService _httpService;

  static Future<HttpService> getInstance() async {
    if (_httpService == null) {
      // keep local instance till it is fully initialized.
      _httpService = HttpService._();
    }
    return _httpService;
  }

  HttpService._();

  static Future<bool> login(
    BuildContext context, {
    String mobile,
    String password,
  }) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/login';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    var map = Map<String, dynamic>();
    map['mobile'] = mobile;
    map['password'] = password;
    print(map);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: null, body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        if (jsonResponse['data']['original']['access_token'].toString() != 'null') {
          Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(true);
          SessionManagerUtil.putString(
              'accessToken', jsonResponse['data']['original']['access_token'].toString());

          ;
          /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
          Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(true);
          _navigateRoute(context, ParentScreen.routeName);
        } else {
          Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(false);
          /*Provider.of<AppProvider>(context, listen: false).setAccessToken('');*/
        }
        _showResponseSnackBar(
            context,
            jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', ''));
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /* Provider.of<AppProvider>(context, listen: false)
            .setUserModel(model);
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context, 'Couldn\'t Connect, please try again');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(context, 'No Internet connection');
    } on SocketException catch (e) {
      _showResponseSnackBar(context, 'No Connection with server');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(context, 'Something went wrong');
    }

    return false;
  }

  static Future<bool> register(
    BuildContext context, {
    String name,
    String mobile,
    String email,
    String password,
  }) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/register';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['password'] = password;
    print(map);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: null, body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
        Provider.of<AppProvider>(context, listen: false)
            .setTempMobileNumber(mobile);
        _navigateRoute(context, RegisterOTPScreen.routeName);
        _showResponseSnackBar(context, 'Otp Sent');
        print(jsonResponse);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /* Provider.of<AppProvider>(context, listen: false)
            .setUserModel(model);
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context, 'Couldn\'t Connect, please try again');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(context, 'No Internet connection');
    } on SocketException catch (e) {
      _showResponseSnackBar(context, 'No Connection with server');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(context, 'Something went wrong');
    }

    return false;
  }

  static Future<bool> forgetPassword(
    BuildContext context, {
    String mobile,
  }) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/forget-password';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    var map = Map<String, dynamic>();
    map['mobile'] = mobile;
    print(map);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: null, body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
        Provider.of<AppProvider>(context, listen: false)
            .setTempMobileNumber(mobile);
        _navigateRoute(context, OTPScreen.routeName);
        _showResponseSnackBar(context, 'Otp sent');
        print(jsonResponse);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /* Provider.of<AppProvider>(context, listen: false)
            .setUserModel(model);
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context, 'Couldn\'t Connect, please try again');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(context, 'No Internet connection');
    } on SocketException catch (e) {
      _showResponseSnackBar(context, 'No Connection with server');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(context, 'Something went wrong');
    }

    return false;
  }

  static Future<bool> otpVerifyPasswordChange(BuildContext context,
      {String mobile, String otp}) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/otp-verify-password-change';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    var map = Map<String, dynamic>();
    map['mobile'] = mobile;
    map['otp'] = otp;
    print(map);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: null, body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
        Provider.of<AppProvider>(context, listen: false)
            .setTempMobileNumber(mobile);
        _navigateRoute(context, ChangePasswordScreen.routeName);
        _showResponseSnackBar(context, 'Otp Valid');
        print(jsonResponse);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /* Provider.of<AppProvider>(context, listen: false)
            .setUserModel(model);
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context, 'Couldn\'t Connect, please try again');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(context, 'No Internet connection');
    } on SocketException catch (e) {
      _showResponseSnackBar(context, 'No Connection with server');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(context, 'Something went wrong');
    }

    return false;
  }

  static Future<bool> passwordChange(BuildContext context,
      {String mobile, String password}) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/password-change';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    var map = Map<String, dynamic>();
    map['mobile'] = mobile;
    map['password'] = password;
    print(map);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: null, body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
        Provider.of<AppProvider>(context, listen: false)
            .setTempMobileNumber(mobile);
        _navigateRoute(context, LoginScreen.routeName);
        _showResponseSnackBar(context, 'Password Updated');
        print(jsonResponse);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /* Provider.of<AppProvider>(context, listen: false)
            .setUserModel(model);
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context, 'Couldn\'t Connect, please try again');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(context, 'No Internet connection');
    } on SocketException catch (e) {
      _showResponseSnackBar(context, 'No Connection with server');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(context, 'Something went wrong');
    }

    return false;
  }

  static Future<bool> otpVerifyRegister(BuildContext context,
      {String mobile, String otp}) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/otp-verify-register';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    var map = Map<String, dynamic>();
    map['mobile'] = mobile;
    map['otp'] = otp;
    print(map);
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: null, body: map);
      print(response.statusCode.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
        Provider.of<AppProvider>(context, listen: false)
            .setTempMobileNumber(mobile);
        _navigateRoute(context, ParentScreen.routeName);
        _showResponseSnackBar(
            context,
            jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', ''));
        print(jsonResponse);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /* Provider.of<AppProvider>(context, listen: false)
            .setUserModel(model);
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context, 'Couldn\'t Connect, please try again');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(context, 'No Internet connection');
    } on SocketException catch (e) {
      _showResponseSnackBar(context, 'No Connection with server');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(context, 'Something went wrong');
    }

    return false;
  }

  static void _showResponseSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(
          '$message',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).cardColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).primaryColor);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void _navigateRoute(BuildContext context, String route) {
    /**This Navigates push Replacement thus popping the current screen off the navigation stack*/
    Navigator.of(context).pushReplacementNamed(route);
  }
}
