import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeSlideTile extends StatelessWidget {
  final bool isActive;
  final String text;
  final Function() onPressed;

  HomeSlideTile({this.isActive=false, this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: Container(
            decoration: BoxDecoration(
                color: isActive?Theme.of(context).primaryColor:Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
                  '$text',
                  style: TextStyle(color: isActive?Colors.white:Color(0xFF9E9E9E), fontSize: 14, fontWeight: FontWeight.w500),
                ))),
      ),
    );
  }
}
