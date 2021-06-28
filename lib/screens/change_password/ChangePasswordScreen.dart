import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static final String routeName = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  bool newPasswordVisibility = false;
  bool confirmPasswordVisibility = false;
  bool isLoading = false;
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Change Password',
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
                      obscureText: !newPasswordVisibility,
                      controller: newPasswordEditingController,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'New Password Cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelText: 'New Password',
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintText: '********',
                        hintStyle: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                newPasswordVisibility = !newPasswordVisibility;
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
                    TextFormField(
                      style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !confirmPasswordVisibility,
                      controller: confirmPasswordEditingController,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Confirm Password Cannot be empty';
                        } else if (val != newPasswordEditingController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintText: '********',
                        hintStyle: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                confirmPasswordVisibility =
                                    !confirmPasswordVisibility;
                              });
                            },
                            child: !confirmPasswordVisibility
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
                          if (formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                            isLoading = await HttpService.passwordChange(context,
                                mobile: _appProvider.getTempMobileNumber(),
                                password: newPasswordEditingController.text);
                            setState(() {});
                          }
                        },
                        child: Text(
                          'Change',
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
