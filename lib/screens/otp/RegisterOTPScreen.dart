import 'dart:async';
import 'dart:ui';

import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/change_password/ChangePasswordScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:Aayan/extensions/app_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterOTPScreen extends StatefulWidget {
  static final String routeName = '/register-otp';

  @override
  _RegisterOTPScreenState createState() => _RegisterOTPScreenState();
}

class _RegisterOTPScreenState extends State<RegisterOTPScreen> {
  final formKey = GlobalKey<FormState>();
  bool visibility = false;
  bool isLoading = false;
  TextEditingController pinEditingController =
      TextEditingController(text: '----');
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 28, bottom: 32, left: 8.0, right: 8.0),
                    child: Text(
                      '${AppLocalizations.of(context).oTP}',
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
                          Text(
                            '${AppLocalizations.of(context).enterTheDigitCodeYouHaveReceivedViaSMSOnYourMobileNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          PinCodeTextField(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            length: 4,
                            textCapitalization: TextCapitalization.characters,
                            textInputType: TextInputType.number,
                            obsecureText: false,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            animationType: AnimationType.fade,
                            backgroundColor: Colors.transparent,
                            controller: pinEditingController,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              activeColor: Colors.white.withOpacity(0.6),
                              selectedColor: Colors.white.withOpacity(0.6),
                              selectedFillColor: Colors.black.withOpacity(0.3),
                              activeFillColor: Colors.black.withOpacity(0.3),
                              inactiveColor: Colors.white.withOpacity(0.6),
                              inactiveFillColor: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(6),
                              fieldHeight: 48,
                              fieldWidth: 48,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            enableActiveFill: true,
                            autoFocus: true,
                            errorTextSpace: 24,
                            validator: (val) {
                              if (val.isEmpty) {
                                return '${AppLocalizations.of(context).code} ${AppLocalizations.of(context).cannotBeEmpty}';
                              }else if(val.length !=4){
                                return '${AppLocalizations.of(context).incompleteCode.capitalize()}';
                              }
                              return null;
                            },
                            errorAnimationController: errorController,
                            onCompleted: (v) {
                              /*enterCode = v;*/
                              setState(() {});
                            },
                            autoDismissKeyboard: false,
                            onChanged: (value) {
                              if (value.length == 4 && value == '----') {
                                pinEditingController.clear();
                              }
                              setState(() {});
                              print(value);
                            },
                            beforeTextPaste: (text) {
                              print("${AppLocalizations.of(context).allowingToPaste} $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Text(
                            '${AppLocalizations.of(context).weSentACodeOn} ${_appProvider.getTempMobileNumber()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(padding: EdgeInsets.all(16)),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 64.0, left: 16, right: 16),
                    child: AppFilledButton(
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                          isLoading = await HttpService.otpVerifyRegister(context,
                              mobile: _appProvider.getTempMobileNumber(),
                             otp: pinEditingController.text);
                          setState(() {});
                        }else{
                          errorController.add(ErrorAnimationType.shake);
                        }
                      },
                      child: Text(
                        '${AppLocalizations.of(context).next}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
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
                  )))
        ],
      ),
    );
  }
}
