import 'dart:async';
import 'dart:io';

import 'package:Aayan/models/AboutUsModel.dart';
import 'package:Aayan/models/BannerModel.dart';
import 'package:Aayan/models/BrandModel.dart';
import 'package:Aayan/models/FeaturedVehicleModel.dart';
import 'package:Aayan/models/FilterVehicleModel.dart';
import 'package:Aayan/models/LeaseAddonItemModel.dart';
import 'package:Aayan/models/LeaseAddonModel.dart';
import 'package:Aayan/models/ModelModel.dart';
import 'package:Aayan/models/PageInfoModel.dart';
import 'package:Aayan/models/SubModelModel.dart';
import 'package:Aayan/models/VehicleDetailModel.dart';
import 'package:Aayan/models/NotificationModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/models/UserModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/about_us/AboutUsScreen.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HttpService {
  static final String baseUrl = "https://aayan.creativity.com.kw/api/v1";

  static HttpService _httpService;

  static Future<HttpService> getInstance() async {
    if (_httpService == null) {
      // keep local instance till it is fully initialized.
      _httpService = HttpService._();
      await SessionManagerUtil.getInstance();
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
        if (jsonResponse['data']['original']['access_token'].toString() !=
            'null') {
          Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(true);
          SessionManagerUtil.putString('accessToken',
              jsonResponse['data']['original']['access_token'].toString());

          /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
          Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(true);
          await myDetails(context);
          if (Provider.of<AppProvider>(context, listen: false)
              .getIsFreshLoggingIn) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                ParentScreen.routeName, (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pop();
          }
        } else {
          Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(false);
          /*Provider.of<AppProvider>(context, listen: false).setAccessToken('');*/
        }
        Provider.of<AppProvider>(context, listen: false).getIsEnglish
            ? _showResponseSnackBar(
                context,
                jsonResponse['message']['en']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''))
            : _showResponseSnackBar(
                context,
                jsonResponse['message']['ar']
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
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
        _showResponseSnackBar(
            context, '${AppLocalizations.of(context).otpSent}');
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
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
        _showResponseSnackBar(
            context, '${AppLocalizations.of(context).otpSent}');
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
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
        _showResponseSnackBar(
            context, '${AppLocalizations.of(context).otpValid}');
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
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
        _showResponseSnackBar(
            context, '${AppLocalizations.of(context).passwordUpdated}');
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
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
        SessionManagerUtil.putString('accessToken',
            jsonResponse['data']['original']['access_token'].toString());
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/
        Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(true);
        Provider.of<AppProvider>(context, listen: false)
            .setTempMobileNumber(mobile);
        await myDetails(context);
        if (Provider.of<AppProvider>(context, listen: false)
            .getIsFreshLoggingIn) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              ParentScreen.routeName, (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pop();
        }
        Provider.of<AppProvider>(context, listen: false).getIsEnglish
            ? _showResponseSnackBar(
                context,
                jsonResponse['message']['en']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''))
            : _showResponseSnackBar(
                context,
                jsonResponse['message']['ar']
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> myDetails(BuildContext context) async {
    String url = baseUrl + '/me';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);

    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    print(url);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
          body: null);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        UserModel model = UserModel.fromJson(jsonResponse['data']);
        Provider.of<AppProvider>(context, listen: false).setUserModel(model);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> passwordUpdate(BuildContext context,
      {String oldPassword, String newPassword}) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/update-password';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    print(url);
    var map = Map<String, dynamic>();
    map['old_password'] = oldPassword;
    map['new_password'] = newPassword;
    print(map);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
          body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/

        _showResponseSnackBar(
            context, '${AppLocalizations.of(context).passwordUpdated}');
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> profileUpdate(BuildContext context,
      {String name, String mobile, String email}) async {
    await SessionManagerUtil.getInstance();
    String url = baseUrl + '/update-profile';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    print(url);
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    print(map);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
          body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        myDetails(context);
        /*Provider.of<AppProvider>(context, listen: false)
              .setAccessToken(jsonResponse['token'].toString());
          SessionManagerUtil.putString(
              'token', jsonResponse['token'].toString());
          await getProfile(context);*/

        Provider.of<AppProvider>(context, listen: false).getIsEnglish
            ? _showResponseSnackBar(
                context,
                jsonResponse['message']['en']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''))
            : _showResponseSnackBar(
                context,
                jsonResponse['message']['ar']
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
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getBanners(BuildContext context) async {
    String url = baseUrl + '/banners';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<BannerModel> bannerList = [];
        for (Map i in jsonResponse['data']) {
          bannerList.add(BannerModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setBannerList(bannerList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeaseFeaturedVehicles(BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/featured-vehicles?vehicle_type=lease_cars';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<FeaturedVehicleModel> featuredVehicleList = [];
        for (Map i in jsonResponse['data']) {
          featuredVehicleList.add(FeaturedVehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setLeaseFeaturedVehicleList(featuredVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedFeaturedVehicles(BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/featured-vehicles?vehicle_type=used_cars';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<FeaturedVehicleModel> featuredVehicleList = [];
        for (Map i in jsonResponse['data']) {
          featuredVehicleList.add(FeaturedVehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setUsedFeaturedVehicleList(featuredVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeaseVehicles(BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/lease-vehicle?filter_by_brand=&per_page=5&page=1';
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setHomeLeaseVehicleList(leaseVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeaseVehiclesWithFilter(
      BuildContext context, FilterVehicleModel model) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/filter-lease-vehicles?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&brand_name=${model.brand ?? ''}&model_name=${model.model?.model ?? ''}&sub_model=${model.subModel ?? ''}&year=${model.year ?? ''}&period=${model.leasePeriod ?? ''}&min_price=${model.minPrice ?? ''}&max_price=${model.maxPrice ?? ''}&per_page=5&page=${_accountProvider.leaseScreenPageInfo.currentPage}';
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        PageInfoModel leasePageInfo =
            PageInfoModel.fromJson(jsonResponse['data']);
        Provider.of<AppProvider>(context, listen: false)
            .setLeasePageInfo(leasePageInfo);
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        if (Provider.of<AppProvider>(context, listen: false)
                .leaseScreenPageInfo
                .currentPage ==
            1) {
          Provider.of<AppProvider>(context, listen: false)
              .setLeaseVehicleList(leaseVehicleList);
        } else {
          Provider.of<AppProvider>(context, listen: false).setLeaseVehicleList(
              List.from(Provider.of<AppProvider>(context, listen: false)
                  .getLeaseVehicleList())
                ..addAll(leaseVehicleList));
        }
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeaseVehiclesByFilter(BuildContext context,
      {List<String> ids}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/lease-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&filter_by_brand=${ids.toString().replaceAll('[', '').replaceAll(']', '')}&per_page=5&page=${_accountProvider.leaseScreenPageInfo.currentPage}';
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        PageInfoModel leasePageInfo =
            PageInfoModel.fromJson(jsonResponse['data']);
        Provider.of<AppProvider>(context, listen: false)
            .setLeasePageInfo(leasePageInfo);
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        if (Provider.of<AppProvider>(context, listen: false)
                .leaseScreenPageInfo
                .currentPage ==
            1) {
          Provider.of<AppProvider>(context, listen: false)
              .setLeaseVehicleList(leaseVehicleList);
        } else {
          Provider.of<AppProvider>(context, listen: false).setLeaseVehicleList(
              List.from(Provider.of<AppProvider>(context, listen: false)
                  .getLeaseVehicleList())
                ..addAll(leaseVehicleList));
        }

        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeaseVehiclesBySearch(BuildContext context,
      {String key}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/lease-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&search=$key&per_page=5&page=${_accountProvider.leaseScreenPageInfo.currentPage}';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        PageInfoModel leasePageInfo =
            PageInfoModel.fromJson(jsonResponse['data']);
        Provider.of<AppProvider>(context, listen: false)
            .setLeasePageInfo(leasePageInfo);
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        if (Provider.of<AppProvider>(context, listen: false)
                .leaseScreenPageInfo
                .currentPage ==
            1) {
          Provider.of<AppProvider>(context, listen: false)
              .setLeaseVehicleList(leaseVehicleList);
        } else {
          Provider.of<AppProvider>(context, listen: false).setLeaseVehicleList(
              List.from(Provider.of<AppProvider>(context, listen: false)
                  .getLeaseVehicleList())
                ..addAll(leaseVehicleList));
        }
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getAboutUs(BuildContext context) async {
    String url = baseUrl + '/static-content/about-us';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        AboutUsModel model = AboutUsModel.fromJson(jsonResponse['data']);

        Provider.of<AppProvider>(context, listen: false).setAboutUsModel(model);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getContactUs(BuildContext context) async {
    String url = baseUrl + '/static-content/contact-us';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        String contact = '';
        contact = jsonResponse['data']['contact_no'];

        Provider.of<AppProvider>(context, listen: false)
            .setContactUsNumber(contact);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getAddLeaseVehiclesByFilter(BuildContext context,
      {List<String> ids}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/lease-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&filter_by_brand=${ids.toString().replaceAll('[', '').replaceAll(']', '')}&per_page=5&page=1';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setAddLeaseVehicleList(leaseVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getAddLeaseVehiclesBySearch(BuildContext context,
      {String key}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/lease-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&search=$key&per_page=5&page=1';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setAddLeaseVehicleList(leaseVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getMostSearchedLeaseVehicles(BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/most-search-vehicle/1';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setMostSearchedLeaseVehicleList(leaseVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getMostRecentSearchedLeaseVehicles(
      BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/most-recent-search/1?';

    print(url);
    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> leaseVehicleList = [];
        for (Map i in jsonResponse['data']) {
          leaseVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setMostRecentSearchedLeaseVehicleList(leaseVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedVehicles(BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/used-vehicle?filter_by_brand=&per_page=5&page=1';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setHomeUsedVehicleList(usedVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedVehiclesWithFilter(
      BuildContext context, FilterVehicleModel model) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/filter-used-vehicles?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&brand_name=${model.brand ?? ''}&model_name=${model.model?.model ?? ''}&sub_model=${model.subModel ?? ''}&year=${model.year ?? ''}&min_price=${model.minPrice ?? ''}&max_price=${model.maxPrice ?? ''}&per_page=5&page=${_accountProvider.usedScreenPageInfo.currentPage}';
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        PageInfoModel usedPageInfo =
            PageInfoModel.fromJson(jsonResponse['data']);
        Provider.of<AppProvider>(context, listen: false)
            .setUsedPageInfo(usedPageInfo);
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }
        if (Provider.of<AppProvider>(context, listen: false)
                .usedScreenPageInfo
                .currentPage ==
            1) {
          Provider.of<AppProvider>(context, listen: false)
              .setUsedVehicleList(usedVehicleList);
        } else {
          List.from(Provider.of<AppProvider>(context, listen: false)
              .getUsedVehicleList())
            ..addAll(usedVehicleList);
        }
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedVehiclesByFilter(BuildContext context,
      {List<String> ids}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/used-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&filter_by_brand=${ids.toString().replaceAll('[', '').replaceAll(']', '')}&per_page=5&page=${_accountProvider.usedScreenPageInfo.currentPage}';
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        PageInfoModel usedPageInfo =
            PageInfoModel.fromJson(jsonResponse['data']);
        Provider.of<AppProvider>(context, listen: false)
            .setUsedPageInfo(usedPageInfo);
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }

        if (Provider.of<AppProvider>(context, listen: false)
                .usedScreenPageInfo
                .currentPage ==
            1) {
          Provider.of<AppProvider>(context, listen: false)
              .setUsedVehicleList(usedVehicleList);
        } else {
          Provider.of<AppProvider>(context, listen: false).setUsedVehicleList(
              List.from(Provider.of<AppProvider>(context, listen: false)
                  .getUsedVehicleList())
                ..addAll(usedVehicleList));
        }
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedVehiclesBySearch(BuildContext context,
      {String key}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/used-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&search=$key&per_page=5&page=${_accountProvider.usedScreenPageInfo.currentPage}';
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        PageInfoModel usedPageInfo =
            PageInfoModel.fromJson(jsonResponse['data']);
        Provider.of<AppProvider>(context, listen: false)
            .setUsedPageInfo(usedPageInfo);
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }
        if (Provider.of<AppProvider>(context, listen: false)
                .usedScreenPageInfo
                .currentPage ==
            1) {
          Provider.of<AppProvider>(context, listen: false)
              .setUsedVehicleList(usedVehicleList);
        } else {
          Provider.of<AppProvider>(context, listen: false).setUsedVehicleList(
              List.from(Provider.of<AppProvider>(context, listen: false)
                  .getUsedVehicleList())
                ..addAll(usedVehicleList));
        }
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getAddUsedVehiclesByFilter(BuildContext context,
      {List<String> ids}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/used-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&filter_by_brand=${ids.toString().replaceAll('[', '').replaceAll(']', '')}&per_page=5&page=1';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setAddUsedVehicleList(usedVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getAddUsedVehiclesBySearch(BuildContext context,
      {String key}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/used-vehicle?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}&search=$key&per_page=5&page=1';
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setAddUsedVehicleList(usedVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getMostSearchedUsedVehicles(BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/most-search-vehicle/2';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setMostSearchedUsedVehicleList(usedVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getMostRecentSearchedUsedVehicles(
      BuildContext context) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/most-recent-search/2?';

    print(url);
    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<VehicleModel> usedVehicleList = [];
        for (Map i in jsonResponse['data']) {
          usedVehicleList.add(VehicleModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setMostRecentSearchedUsedVehicleList(usedVehicleList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getHomeNotifications(BuildContext context) async {
    String url = baseUrl + '/onesignal-notification?home_page=true';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<NotificationModel> notificationList = [];
        for (Map i in jsonResponse['data']) {
          notificationList.add(NotificationModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setHomeNotificationList(notificationList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getNotifications(BuildContext context) async {
    String url = baseUrl + '/onesignal-notification';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<NotificationModel> notificationList = [];
        for (Map i in jsonResponse['data']) {
          notificationList.add(NotificationModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setNotificationList(notificationList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getNotificationDetails(BuildContext context,
      {String notificationId}) async {
    String url = baseUrl + '/onesignal-notification/$notificationId';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        Provider.of<AppProvider>(context, listen: false)
            .setTempNotificationModel(
                NotificationModel.fromJson(jsonResponse['data']));
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getBrands(BuildContext context) async {
    String url = baseUrl + '/brands';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<BrandModel> brandList = [];
        for (Map i in jsonResponse['data']) {
          brandList.add(BrandModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setBrandList(brandList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedBrands(BuildContext context) async {
    String url = baseUrl + '/used-car-brands';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<BrandModel> usedBrandList = [];
        for (Map i in jsonResponse['data']) {
          usedBrandList.add(BrandModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setUsedBrandList(usedBrandList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getTopBrands(BuildContext context) async {
    String url = baseUrl + '/brands?top_brands=8';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<BrandModel> brandList = [];
        for (Map i in jsonResponse['data']) {
          brandList.add(BrandModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setTopBrandList(brandList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getTopUsedBrands(BuildContext context) async {
    String url = baseUrl + '/used-car-brands?top_brands=8';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<BrandModel> usedBrandList = [];
        for (Map i in jsonResponse['data']) {
          usedBrandList.add(BrandModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setTopUsedBrandList(usedBrandList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeaseVehiclePriceRange(BuildContext context) async {
    String url = baseUrl + '/price-range/lease_car';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        double min;
        double max;
        min = double.tryParse(jsonResponse['data']['min'].toString()) ?? 0.0;
        max = double.tryParse(jsonResponse['data']['max'].toString()) ?? 0.0;

        Provider.of<AppProvider>(context, listen: false)
            .setLeaseCarPriceRange(RangeValues(min, max));
        print(
            '${Provider.of<AppProvider>(context, listen: false).getLeaseCarPriceRange}');
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedVehiclePriceRange(BuildContext context) async {
    String url = baseUrl + '/price-range/used_car';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        double min;
        double max;
        min = double.tryParse(jsonResponse['data']['min'].toString()) ?? 0.0;
        max = double.tryParse(jsonResponse['data']['max'].toString()) ?? 0.0;

        Provider.of<AppProvider>(context, listen: false)
            .setUsedCarPriceRange(RangeValues(min, max));
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getBrandModels(
      BuildContext context, String brandName) async {
    String url = baseUrl + '/filter-model?brand_name=$brandName';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<ModelModel> modelList = [];
        for (Map i in jsonResponse['data']) {
          modelList.add(ModelModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setTempModelList(modelList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getSubModels(BuildContext context, String modelId) async {
    String url = baseUrl + '/filter-sub-model?model_id=$modelId';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<SubModelModel> subModelList = [];
        for (Map i in jsonResponse['data']) {
          subModelList.add(SubModelModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setTempSubModelList(subModelList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getYear(
      {BuildContext context,
      String brandName,
      String modelName,
      String subModel}) async {
    String url = baseUrl +
        '/filter-year?brand_name=$brandName&model_name=$modelName&sub_model=$subModel';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<String> yearList = [];
        for (Map i in jsonResponse['data']) {
          yearList.add(i['year'].toString());
        }
        Provider.of<AppProvider>(context, listen: false)
            .setTempYearList(yearList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeasePeriod(
      {BuildContext context,
      String brandName,
      String modelName,
      String subModel,
      String year}) async {
    String url = baseUrl +
        '/filter-lease-period?brand_name=$brandName&model_name=$modelName&sub_model=$subModel&year=$year';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<String> leasePeriodList = [];
        for (Map i in jsonResponse['data']) {
          leasePeriodList.add(i['period'].toString());
        }

        Provider.of<AppProvider>(context, listen: false)
            .setTempLeasePeriodList(leasePeriodList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedBrandModels(
      BuildContext context, String brandName) async {
    String url = baseUrl + '/used-filter-model?brand_name=$brandName';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<ModelModel> modelList = [];
        for (Map i in jsonResponse['data']) {
          modelList.add(ModelModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setTempUsedModelList(modelList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedSubModels(
      BuildContext context, String modelId) async {
    String url = baseUrl + '/used-filter-sub-model?model_id=$modelId';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<SubModelModel> subModelList = [];
        for (Map i in jsonResponse['data']) {
          subModelList.add(SubModelModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setTempUsedSubModelList(subModelList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getUsedYear(
      {BuildContext context,
      String brandName,
      String modelName,
      String subModel}) async {
    String url = baseUrl +
        '/used-filter-year?brand_name=$brandName&model_name=$modelName&sub_model=$subModel';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<String> yearList = [];
        for (Map i in jsonResponse['data']) {
          yearList.add(i['year'].toString());
        }
        Provider.of<AppProvider>(context, listen: false)
            .setTempUsedYearList(yearList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getSingleLeaseVehicles(BuildContext context,
      {String id}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/lease-vehicle/$id?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}';
    print(url);
    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: _accountProvider.getBoolIsLoggedIn
            ? {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}
            : null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        Provider.of<AppProvider>(context, listen: false)
            .setTempLeaseVehicleDetail(
                VehicleDetailModel.fromJson(jsonResponse['data']));
        if (_accountProvider.getBoolIsLoggedIn) {
          await getMostRecentSearchedLeaseVehicles(context);
        }
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getSingleUsedVehicles(BuildContext context,
      {String id}) async {
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl +
        '/used-vehicle/$id?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}';
    print(url);
    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: _accountProvider.getBoolIsLoggedIn
            ? {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}
            : null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        Provider.of<AppProvider>(context, listen: false)
            .setTempUsedVehicleDetail(
                VehicleDetailModel.fromJson(jsonResponse['data']));
        if (_accountProvider.getBoolIsLoggedIn) {
          await getMostRecentSearchedUsedVehicles(context);
        }
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getLeaseAddOns(BuildContext context) async {
    AppProvider _accountProvider =
  Provider.of<AppProvider>(context, listen: false);
    String url = baseUrl + '/leasing-addons?language=${_accountProvider.getIsEnglish ? 'en' : 'ar'}';

    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        List<LeaseAddonModel> leaseAddonList = [];
        for (Map i in jsonResponse['data']) {
          leaseAddonList.add(LeaseAddonModel.fromJson(i));
        }
        Provider.of<AppProvider>(context, listen: false)
            .setLeaseAddonList(leaseAddonList);

        List<LeaseAddonItemModel> valueLeaseAddonList = [];
        for (Map i in jsonResponse['data'][0]['get_items']) {
          valueLeaseAddonList.add(LeaseAddonItemModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setValueLeaseAddonList(valueLeaseAddonList);
        List<LeaseAddonItemModel> valuePlusLeaseAddonList = [];

        for (Map i in jsonResponse['data'][1]['get_items']) {
          valuePlusLeaseAddonList.add(LeaseAddonItemModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .setValuePlusLeaseAddonList(valuePlusLeaseAddonList);
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> postRequestLeaseVehicle(BuildContext context,
      {String vehicleId, String packageId, String addOnId}) async {
    String url = baseUrl + '/lease-vehicle-user-request';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);

    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    print(url);
    var map = Map<String, dynamic>();
    map['lease_vehicle_id'] = vehicleId;
    map['package_id'] = packageId;
    map['addon_id'] = addOnId;
    print(map);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
          body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        Navigator.of(context)
            .popUntil(ModalRoute.withName(ParentScreen.routeName));
        Provider.of<AppProvider>(context, listen: false).getIsEnglish
            ? _showResponseSnackBar(
                context,
                jsonResponse['message']['en']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''))
            : _showResponseSnackBar(
                context,
                jsonResponse['message']['ar']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''));
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> postCheckAndPurchaseLeaseVehicle(BuildContext context,
      {String vehicleId}) async {
    String url = baseUrl + '/used-vehicle-user-request';
    AppProvider _accountProvider =
        Provider.of<AppProvider>(context, listen: false);

    await SessionManagerUtil.getInstance();
    String accessToken = await SessionManagerUtil.getString('accessToken');
    print(url);
    var map = Map<String, dynamic>();
    map['used_vehicle_id'] = vehicleId;
    print(map);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
          body: map);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'].toString() == 'true') {
        Navigator.of(context)
            .popUntil(ModalRoute.withName(ParentScreen.routeName));
        Provider.of<AppProvider>(context, listen: false).getIsEnglish
            ? _showResponseSnackBar(
                context,
                jsonResponse['message']['en']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''))
            : _showResponseSnackBar(
                context,
                jsonResponse['message']['ar']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', ''));
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? _showResponseSnackBar(
                  context,
                  jsonResponse['message']['en']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''))
              : _showResponseSnackBar(
                  context,
                  jsonResponse['message']['ar']
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '')
                      .replaceAll('[', '')
                      .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context).couldntConnectPleaseTryAgain}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context).somethingWentWrong}');
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
              fontFamily: 'Poppins'),
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
