import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/on_boarding/OnBoardingScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/util/session_manager_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () {
      _checkToken();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
  _checkToken() async {
    await SessionManagerUtil.getInstance();
    if (SessionManagerUtil.getString('accessToken') == null ||
        SessionManagerUtil.getString('accessToken').trim().isEmpty) {
      if (SessionManagerUtil.getBoolean('firstTime') == false) {
        SessionManagerUtil.putBoolean('firstTime', true);
        Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(false);
        Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
      }else{
        Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(false);
        Navigator.of(context).pushReplacementNamed(ParentScreen.routeName);
      }

    } else
      receiverProcessesJwt(SessionManagerUtil.getString('accessToken'));
  }

  void receiverProcessesJwt(String token) {
    if (JwtDecoder.isExpired(token)) {
      Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(false);
      Navigator.of(context).pushReplacementNamed(ParentScreen.routeName);
    }  else {
      Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(true);
      Navigator.of(context).pushReplacementNamed(ParentScreen.routeName);
    }
  }
}
