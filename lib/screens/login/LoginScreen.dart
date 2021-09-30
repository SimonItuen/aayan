import 'dart:ui';

import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/forgot_password/ForgotPasswordScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/screens/register/RegisterScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool visibility = false;
  bool isLoading = false;
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isError = false;
  bool isButtonPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_backdrop.png',
              fit: BoxFit.fitHeight,
              alignment: Alignment(-0.47, 0),
            ),
          ),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          )),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.only(top: 48.0, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.arrow_back_sharp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      AppTransparentButton(
                        isExpanded: false,
                        onPressed: () {
                          Provider.of<AppProvider>(context, listen: false)
                              .setIsLoggedIn(false);
                          Navigator.of(context).pushNamedAndRemoveUntil(ParentScreen.routeName, (Route<dynamic> route) => false);
                        },
                        child: Text(
                          '${AppLocalizations.of(context).skip}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 28, bottom: 32, left: 8.0, right: 8.0),
                    child: Text(
                      '${AppLocalizations.of(context).login}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.phone,
                            controller: mobileController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                            onChanged: (val){
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val.isEmpty) {
                                return '${AppLocalizations.of(context).mobileNumber} ${AppLocalizations.of(context).cannotBeEmpty}';
                              } else if (val.length != 8) {
                                return '${AppLocalizations.of(context).mobileNumber} ${AppLocalizations.of(context).isInvalid}';
                              }
                              isError = false;
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '${AppLocalizations.of(context).mobileNumber}',
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                fillColor: Colors.black.withOpacity(0.3),
                                prefixIcon: Icon(
                                  Icons.phone_rounded,
                                  color: Colors.white.withOpacity(0.6),
                                )),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          TextFormField(
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            obscureText: !visibility,
                            onChanged: (val){
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val.isEmpty) {
                                return '${AppLocalizations.of(context).password} ${AppLocalizations.of(context).cannotBeEmpty}';
                              }
                              isError = false;
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '${AppLocalizations.of(context).password}',
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        visibility = !visibility;
                                      });
                                    },
                                    child: !visibility
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Colors.white,
                                          )
                                        : Icon(Icons.visibility,
                                            color: Colors.white)),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                fillColor: Colors.black.withOpacity(0.3),
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: Colors.white.withOpacity(0.6),
                                )),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ForgotPasswordScreen.routeName);
                              },
                              child: Text(
                                '${AppLocalizations.of(context).forgotPasswordMark}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          AppFilledButton(
                            onPressed: () async {
                              isButtonPressed = true;
                              if (formKey.currentState.validate()) {

                                setState(() {
                                  isLoading = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                isLoading = await HttpService.login(context,
                                    mobile: mobileController.text,
                                    password: passwordController.text);
                                setState(() {});
                              }

                            },
                            child: Text(
                              '${AppLocalizations.of(context).login}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${AppLocalizations.of(context).or}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(16)),
                          AppFilledButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  RegisterScreen.routeName);
                            },
                            fillColor: Color(0xFFB21F28),
                            child: Text(
                              '${AppLocalizations.of(context).register}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ],
              ),
            ),
          )),
          Positioned.fill(
              child: Visibility(
                  visible: isLoading,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(child: CircularProgressIndicator()),
                  ))),
        ],
      ),
    );
  }
}
