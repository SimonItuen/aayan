import 'package:Aayan/screens/on_boarding/OnBoardingScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/util/session_manager_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
    } else
      receiverProcessesJwt(SessionManagerUtil.getString('accessToken'));
  }

  void receiverProcessesJwt(String token) {
    if (JwtDecoder.isExpired(token)) {
      Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
    }  else {
      Navigator.of(context).pushReplacementNamed(ParentScreen.routeName);
    }
  }
}
