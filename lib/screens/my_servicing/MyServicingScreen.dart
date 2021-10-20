import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:Aayan/widgets/home_slide_tile.dart';
import 'package:Aayan/widgets/my_vehicle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class MyServicingScreen extends StatefulWidget {
  static final String routeName = '/my-servicing-vehicle';

  @override
  _MyServicingScreenState createState() => _MyServicingScreenState();
}

class _MyServicingScreenState extends State<MyServicingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  int currentPage =0;

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(
                  vertical: 16, horizontal: 16),
              width: MediaQuery.of(context).size.width * 0.9111,
              decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(
                      child: HomeSlideTile(
                        text:
                        'Pending',/*${AppLocalizations.of(context).leaseCars}'*/
                        isActive: currentPage == 0,
                        onPressed: () {
                          setState(() {
                            currentPage = 0;
                          });
                        },
                      )),
                  Expanded(
                      child: HomeSlideTile(
                        text:
                        'Completed',
                        isActive: currentPage == 1,
                        onPressed: () {
                          setState(() {
                            currentPage = 1;
                          });
                        },
                      )),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                padding: EdgeInsets.only(top: 0, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0;
                        i < _appProvider.getUsedOwnedVehicleList().length;
                        i++)
                      MyVehicleTile(
                        id: '${_appProvider.getUsedOwnedVehicleList()[i].id}',
                        imageUrl:
                            '${_appProvider.getUsedOwnedVehicleList()[i].imageName}',
                        name:
                            '${_appProvider.getIsEnglish ? _appProvider.getUsedOwnedVehicleList()[i].carName : _appProvider.getUsedOwnedVehicleList()[i].altCarName}',
                        year:
                            '${_appProvider.getUsedOwnedVehicleList()[i].year}',
                        brand:
                            '${_appProvider.getIsEnglish ? _appProvider.getUsedOwnedVehicleList()[i].brand : _appProvider.getUsedOwnedVehicleList()[i].altBrand}',
                        model:
                            '${_appProvider.getIsEnglish ? _appProvider.getUsedOwnedVehicleList()[i].model : _appProvider.getUsedOwnedVehicleList()[i].altModel}',
                        price:
                            'KD ${_appProvider.getUsedOwnedVehicleList()[i].price}',
                        status:
                            '${_appProvider.getUsedOwnedVehicleList()[i].status}',
                        isUsed: true,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
