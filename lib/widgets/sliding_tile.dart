import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SlidingTile extends StatelessWidget {
  final bool isActive;

  SlidingTile({this.isActive=false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 5,
      width: 15,
      decoration: BoxDecoration(
        color: isActive?Theme.of(context).primaryColor: Color(0xFFC2D1F3),
        borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}
