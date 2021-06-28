import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppFilledButton extends StatelessWidget {
  final bool isActive;
  final Widget child;
  final bool isExpanded;
  final Color fillColor;
  final Function() onPressed;

  AppFilledButton({this.isActive=false, this.child, this.fillColor, this.onPressed, this.isExpanded=true});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 48,
        width: isExpanded?double.infinity:null,
        decoration: BoxDecoration(
          color: fillColor??Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: child),
      ),
    );
  }
}
