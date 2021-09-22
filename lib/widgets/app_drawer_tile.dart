import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/util/aayan_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppDrawerTile extends StatelessWidget {
  final bool isSelected;
  final String text;
  final IconData icon;
  final Function() onPressed;

  AppDrawerTile(
      {this.isSelected = false, this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Align(
        alignment: Provider.of<AppProvider>(context, listen: true).isEnglish? Alignment.centerLeft: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).primaryColor : null,
              borderRadius: BorderRadius.circular(28)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             icon==AayanIcons.icon_open_account_logout? RotatedBox(
               quarterTurns:  Provider.of<AppProvider>(context, listen: false).isEnglish?0:2,
               child: Icon(
                  icon,
                  size: 18,
                  color: isSelected ? Colors.white : Color(0XFF535353),
                ),
             ):Icon(
               icon,
               size: 18,
               color: isSelected ? Colors.white : Color(0XFF535353),
             ),
              Padding(padding: EdgeInsets.all(6)),
              Text(
                '$text',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: text=='Translate'?'Poppins':'Almarai',
                    fontWeight: FontWeight.w400,
                    color: isSelected ? Colors.white : Color(0xFF212121)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
