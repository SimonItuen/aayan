import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/home/HomeScreen.dart';
import 'package:Aayan/screens/parent/AppDrawer.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParentScreen extends StatefulWidget {
  static final String routeName = '/parent';

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    if (Provider.of<AppProvider>(context, listen: false).getIsNavOpen) {
      Provider.of<AppProvider>(context, listen: false).toggleNavOpen();
      return false;
    } else {
      return true;
    }
    // return
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Row(
        children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 150),
              constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: _appProvider.getIsNavOpen
                      ? MediaQuery.of(context).size.width * 0.75
                      : 0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  GestureDetector(
                      onPanUpdate: (details) {
                        if (_appProvider.getIsEnglish) {
                          if (details.delta.dx < 0) {
                            if (_appProvider.getIsNavOpen) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .toggleNavOpen();
                            }
                          }
                        } else if (!_appProvider.getIsEnglish) {
                          if (details.delta.dx > 0) {
                            if (_appProvider.getIsNavOpen) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .toggleNavOpen();
                            }
                          }
                        }
                      },
                      child: AppDrawer()),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: -5,
                          blurRadius: 5,
                          // changes position of shadow
                        )
                      ]),
                    ),
                  )
                ],
              )),
          Expanded(
            flex: _appProvider.getIsNavOpen ? 25 : 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      iconTheme: IconThemeData(color: Colors.black),
                      leading: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Provider.of<AppProvider>(context, listen: false)
                                .toggleNavOpen();
                          }),
                      actions: [
                        IconButton(
                            icon: Icon(
                              Icons.stars_rounded,
                              color: Color(0xFFF9A602),
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                    body: GestureDetector(
                        onTap: () {
                          if (_appProvider.getIsNavOpen) {
                            Provider.of<AppProvider>(context, listen: false)
                                .toggleNavOpen();
                          }
                        },
                        onPanUpdate: (details) {
                          if (_appProvider.getIsEnglish) {
                            if (details.delta.dx < 0) {
                              if (_appProvider.getIsNavOpen) {
                                Provider.of<AppProvider>(context, listen: false)
                                    .toggleNavOpen();
                              }
                            }
                          } else if (!_appProvider.getIsEnglish) {
                            if (details.delta.dx > 0) {
                              if (_appProvider.getIsNavOpen) {
                                Provider.of<AppProvider>(context, listen: false)
                                    .toggleNavOpen();
                              }
                            }
                          }
                        },
                        child: AbsorbPointer(
                            absorbing: _appProvider.getIsNavOpen,
                            child: HomeScreen()))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
