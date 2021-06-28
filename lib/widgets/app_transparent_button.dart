import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTransparentButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final bool isExpanded;

  AppTransparentButton({this.child, this.onPressed, this.isExpanded=true});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 48,
        width: isExpanded?double.infinity:null,
        child: Center(child: child),
      ),
    );
  }
}
