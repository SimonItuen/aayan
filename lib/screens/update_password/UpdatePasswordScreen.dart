import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static final String routeName = '/update-password';

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  bool oldPasswordVisibility = false;
  bool newPasswordVisibility = false;
  bool isLoading = false;
  bool isError = false;
  bool isButtonPressed = false;
  TextEditingController oldPasswordEditingController = TextEditingController();
  TextEditingController newPasswordEditingController =
  TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${AppLocalizations.of(context).changePassword}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding:
              EdgeInsets.only(top: 24, bottom: 16, left: 16, right: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !oldPasswordVisibility,
                      controller: oldPasswordEditingController,
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
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelText: '${AppLocalizations.of(context).password}',
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                oldPasswordVisibility = !oldPasswordVisibility;
                              });
                            },
                            child: !oldPasswordVisibility
                                ? Icon(
                              Icons.visibility_off,
                              color: Color(0xFFC2D1F3),
                            )
                                : Icon(
                              Icons.visibility,
                              color: Color(0xFFC2D1F3),
                            )),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                        fillColor: Colors.white,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    TextFormField(
                      style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !newPasswordVisibility,
                      controller: newPasswordEditingController,
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
                          return '${AppLocalizations.of(context).newPassword} ${AppLocalizations.of(context).cannotBeEmpty}';
                        }
                        isError = false;
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: '${AppLocalizations.of(context).newPassword}',
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                newPasswordVisibility =
                                !newPasswordVisibility;
                              });
                            },
                            child: !newPasswordVisibility
                                ? Icon(
                              Icons.visibility_off,
                              color: Color(0xFFC2D1F3),
                            )
                                : Icon(
                              Icons.visibility,
                              color: Color(0xFFC2D1F3),
                            )),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                            BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                        fillColor: Colors.white,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 0, right: 8, left: 8),
                      child: AppFilledButton(
                        onPressed: () async {
                          isButtonPressed = true;
                          if (formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                            isLoading = await HttpService.passwordUpdate(context,
                                oldPassword: oldPasswordEditingController.text,
                                newPassword: newPasswordEditingController.text);
                            setState(() {});
                          }
                        },
                        child: Text(
                          '${AppLocalizations.of(context).change}',
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
