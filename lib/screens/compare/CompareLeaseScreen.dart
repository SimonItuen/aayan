import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareLeaseDetailsScreen.dart';
import 'package:Aayan/screens/lease_vehicle/AddLeaseVehicleScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class CompareLeaseVehicleScreen extends StatefulWidget {
  static final String routeName = '/compare-lease-vehicle';

  @override
  _CompareLeaseVehicleScreenState createState() => _CompareLeaseVehicleScreenState();
}

class _CompareLeaseVehicleScreenState extends State<CompareLeaseVehicleScreen> {

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
            onTap: (){
              _appProvider.compareLeaseVehicleList.clear();
              setState(() {

              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right:8.0),
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
                clipBehavior: Clip.none,
                padding: EdgeInsets.only(top: 24, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for(int i=0; i<_appProvider.compareLeaseVehicleList.length; i++)
                    CompareVehicleTile(
                      id: '${_appProvider.compareLeaseVehicleList[i].id}',
                      imageUrl: '${_appProvider.compareLeaseVehicleList[i].imageName}',
                      name: '${_appProvider.compareLeaseVehicleList[i].carName}',
                      year: '${_appProvider.compareLeaseVehicleList[i].year}',
                      brand: '${_appProvider.compareLeaseVehicleList[i].brand}',
                      model: '${_appProvider.compareLeaseVehicleList[i].model}',
                      price: 'KD ${_appProvider.compareLeaseVehicleList[i].price}',
                      onRemovePressed: (){
                        _appProvider.getCompareLeaseVehicleList().removeAt(i);
                        Provider.of<AppProvider>(context, listen:false).setCompareLeaseVehicleList(_appProvider.getCompareLeaseVehicleList());
                      },
                    ),
                    Visibility(
                      visible: _appProvider.getCompareLeaseVehicleList().length<4,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(AddLeaseVehicleScreen.routeName);
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.9111111) - 32,
                          height: MediaQuery.of(context).size.width * 0.9111111 * 0.341463,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0XFFEEEEEE))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add_circle_rounded, color: Color(0xFF9E9E9E),), Text('${AppLocalizations.of(context).aDDCAR}', style: TextStyle(color: Color(0xFF9E9E9E), fontWeight: FontWeight.w400, fontSize: 12),)],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _appProvider.getCompareLeaseVehicleList().length>1,
              child: Padding(
                padding: EdgeInsets.only(top: 0, right: 8, left: 8),
                child: AppFilledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CompareLeaseDetailsScreen.routeName);
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
