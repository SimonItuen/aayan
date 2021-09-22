import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class CompareUsedDetailsScreen extends StatefulWidget {
  static final String routeName = '/compare-used-details';

  @override
  _CompareUsedDetailsScreenState createState() =>
      _CompareUsedDetailsScreenState();
}

class _CompareUsedDetailsScreenState extends State<CompareUsedDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppProvider>(context, listen: false)
                .getCompareUsedVehicleList()
                .length <
            3
        ? SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        : SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            '${AppLocalizations.of(context).compare.capitalize()}',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.edit_rounded,
                  color: Color(0xFF535353),
                  size: 24,
                ),
                onPressed: () {
                  Navigator.of(context).maybePop();
                }),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: AppTransparentButton(
                  isExpanded: false,
                  onPressed: () {
                    _appProvider.getCompareUsedVehicleList().clear();
                    Provider.of<AppProvider>(context, listen: false)
                        .setCompareUsedVehicleList(
                            _appProvider.getCompareUsedVehicleList());
                    Navigator.of(context).maybePop();
                  },
                  child: Text(
                    '${AppLocalizations.of(context).reset}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 24, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: _appProvider.getCompareUsedVehicleList().length < 3
                    ? MediaQuery.of(context).size.width * 0.455556 * 1.07926
                    : (MediaQuery.of(context).size.height *
                            0.455556 *
                            1.07926) +
                        12,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFEEEEEE), width: 1))),
                child: Row(
                  children: [
                    for (int i = 0;
                        i < _appProvider.getCompareUsedVehicleList().length;
                        i++)
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: _appProvider
                                          .getCompareUsedVehicleList()[i]
                                          .imageName
                                          .toString()
                                          .startsWith('http')
                                          ? CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url,
                                            downloadProgress) {
                                          return SpinKitDoubleBounce(
                                            size: 16,
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.6),
                                          );
                                        },
                                        imageUrl:
                                        '${_appProvider.getCompareUsedVehicleList()[i].imageName}',
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                      )
                                          : Image.asset(
                                          'assets/images/default_car_image.png')),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: _appProvider
                                                    .getCompareUsedVehicleList()
                                                    .length <
                                                3
                                            ? 8
                                            : 4.0,
                                        right: 4,
                                        left: 4),
                                    child: Text(
                                      '${_appProvider.getCompareUsedVehicleList()[i].carName}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: i <
                                  _appProvider
                                          .getCompareUsedVehicleList()
                                          .length -
                                      1,
                              child: VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Color(0xFFEEEEEE),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).brand}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0;
                          i < _appProvider.getCompareUsedVehicleList().length;
                          i++)
                        Expanded(
                            child: Text(
                          '${_appProvider.getCompareUsedVehicleList()[i].brand}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).model}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0;
                          i < _appProvider.getCompareUsedVehicleList().length;
                          i++)
                        Expanded(
                            child: Text(
                          '${_appProvider.getCompareUsedVehicleList()[i].model}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).year}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0;
                          i < _appProvider.getCompareUsedVehicleList().length;
                          i++)
                        Expanded(
                            child: Text(
                          '${_appProvider.getCompareUsedVehicleList()[i].year}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
