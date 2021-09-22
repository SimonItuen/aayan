import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingsTile extends StatelessWidget {
  final Widget title;
  final Widget trailing;
  final Function() onPressed;

  SettingsTile({this.onPressed, this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: [
            Expanded(child: title),
            trailing
          ],
        ),
      ),
    );
  }
}
