import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareLeaseDetailsScreen.dart';
import 'package:Aayan/screens/compare/CompareUsedDetailsScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/used_vehicle/AddUsedVehicleScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class CompareUsedVehicleScreen extends StatefulWidget {
  static final String routeName = '/compare-used-vehicle';

  @override
  _CompareUsedVehicleScreenState createState() =>
      _CompareUsedVehicleScreenState();
}

class _CompareUsedVehicleScreenState extends State<CompareUsedVehicleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${AppLocalizations.of(context).compare.capitalize()}',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              _appProvider.compareUsedVehicleList.clear();
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: AppTransparentButton(
                  isExpanded: false,
                  child: Text(
                    '${AppLocalizations.of(context).reset}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 24, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0;
                        i < _appProvider.compareUsedVehicleList.length;
                        i++)
                      CompareVehicleTile(
                        id: '${_appProvider.compareUsedVehicleList[i].id}',
                        imageUrl:
                            '${_appProvider.compareUsedVehicleList[i].imageName}',
                        name:
                            '${_appProvider.compareUsedVehicleList[i].carName}',
                        year: '${_appProvider.compareUsedVehicleList[i].year}',
                        brand:
                            '${_appProvider.compareUsedVehicleList[i].brand}',
                        model:
                            '${_appProvider.compareUsedVehicleList[i].model}',
                        price:
                            'KD ${_appProvider.compareUsedVehicleList[i].price}',
                        onRemovePressed: () {
                          _appProvider.getCompareUsedVehicleList().removeAt(i);
                          setState(() {});
                        },
                      ),
                    Visibility(
                      visible:
                          _appProvider.getCompareUsedVehicleList().length < 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AddUsedVehicleScreen.routeName);
                        },
                        child: Container(
                          width:
                              (MediaQuery.of(context).size.width * 0.9111111) -
                                  32,
                          height: MediaQuery.of(context).size.width *
                              0.9111111 *
                              0.341463,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0XFFEEEEEE))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_rounded,
                                color: Color(0xFF9E9E9E),
                              ),
                              Text(
                                '${AppLocalizations.of(context).aDDCAR}',
                                style: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _appProvider.getCompareUsedVehicleList().length > 1,
              child: Padding(
                padding: EdgeInsets.only(top: 0, right: 8, left: 8),
                child: AppFilledButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CompareUsedDetailsScreen.routeName);
                  },
                  child: Text(
                    '${AppLocalizations.of(context).compare.capitalize()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
