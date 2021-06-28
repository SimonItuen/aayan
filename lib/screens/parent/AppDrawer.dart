import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/on_boarding/OnBoardingScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/util/aayan_icons.dart';
import 'package:Aayan/util/session_manager_util.dart';
import 'package:Aayan/widgets/app_drawer_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<String> titles = [
    'Home',
    'My Leased Vehicles',
    'My Purchased Vehicles',
    'My Servicings',
    'My Emergency Requests',
    'About Us',
    'Contact Us',
    'العربية'
  ];
  List<IconData> icons = [
    AayanIcons.home,
    AayanIcons.lease,
    AayanIcons.purchase,
    AayanIcons.servicing,
    Icons.warning_amber_rounded,
    Icons.info,
    AayanIcons.contact_us,
    AayanIcons.translate
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Drawer(
        child: SingleChildScrollView(
          padding:  Provider.of<AppProvider>(context, listen: true).isEnglish?EdgeInsets.only(left: 24, right: 0):EdgeInsets.only(left: 0, right: 24),
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, John',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            color: Color(0xFFF9A602),
                          ),
                          Text(
                            '2000',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFF9A602),
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      )
                    ],
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.settings_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {})
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              for (int i = 0; i < titles.length; i++)
                AppDrawerTile(
                  icon: icons[i],
                  text: titles[i],
                  isSelected: i==Provider.of<AppProvider>(context, listen: true)
                    .getCurrentPage,
                  onPressed:icons[i]!= AayanIcons.translate? () {
                    Provider.of<AppProvider>(context, listen: false)
                      ..setCurrentPage(i)
                      ..toggleNavOpen();
                  }:(){
                    Provider.of<AppProvider>(context, listen: false)..toggleNavOpen()..toggleLanguage();
                  },
                ),
              Divider(),
              AppDrawerTile(
                icon: AayanIcons.icon_open_account_logout,
                text: 'Logout',
                isSelected: false,
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false)
                    .toggleNavOpen();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      OnBoardingScreen.routeName,
                      ModalRoute.withName('/'));
                  SessionManagerUtil.clearAll();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
