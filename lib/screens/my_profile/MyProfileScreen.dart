import 'package:Aayan/models/UserModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Aayan/extensions/app_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProfileScreen extends StatefulWidget {
  static final String routeName = '/my-profile';

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  bool isError = false;
  bool isButtonPressed = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () {
      UserModel currentUser =
          Provider.of<AppProvider>(context, listen: false).getCurrentUser();
      nameEditingController.text = currentUser.name;
      mobileEditingController.text = currentUser.mobile;
      emailEditingController.text = currentUser.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${AppLocalizations.of(context).myProfile.capitalize()}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
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
                      keyboardType: TextInputType.name,
                      controller: nameEditingController,
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
                          return '${AppLocalizations.of(context).name.capitalize()} ${AppLocalizations.of(context).cannotBeEmpty}';
                        }
                        isError = false;
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelText: '${AppLocalizations.of(context).name.capitalize()}',
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
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
                      keyboardType: TextInputType.phone,
                      controller: mobileEditingController,
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
                          return '${AppLocalizations.of(context).mobileNumber.capitalize()} ${AppLocalizations.of(context).cannotBeEmpty}';
                        } else if (!(val.startsWith('5') ||
                            val.startsWith('6') ||
                            val.startsWith('9'))) {
                          return '${AppLocalizations.of(context).mobileNumber.capitalize()} ${AppLocalizations.of(context).isInvalid}';
                        } else if (val.length != 8) {
                          return '${AppLocalizations.of(context).mobileNumber.capitalize()} ${AppLocalizations.of(context).isInvalid}';
                        }
                        isError = false;
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelText: '${AppLocalizations.of(context).mobile.capitalize()}',
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailEditingController,
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
                          return '${AppLocalizations.of(context).email.capitalize()} ${AppLocalizations.of(context).cannotBeEmpty}';
                        }
                        isError = false;
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelText: '${AppLocalizations.of(context).email.capitalize()}',
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
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
                            isLoading = await HttpService.profileUpdate(context, name: nameEditingController.text, mobile: mobileEditingController.text, email: emailEditingController.text);
                            setState(() {});
                          }
                        },
                        child: Text(
                          'Save',
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
