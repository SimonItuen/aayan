import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:Aayan/widgets/my_vehicle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class MyPurchasedVehicleScreen extends StatefulWidget {
  static final String routeName = '/my-purchased-vehicle';

  @override
  _MyPurchasedVehicleScreenState createState() => _MyPurchasedVehicleScreenState();
}

class _MyPurchasedVehicleScreenState extends State<MyPurchasedVehicleScreen> {

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
                    for(int i=0; i<_appProvider.getUsedOwnedVehicleList().length; i++)
                      MyVehicleTile(
                        id: '${_appProvider.getUsedOwnedVehicleList()[i].id}',
                        imageUrl: '${_appProvider.getUsedOwnedVehicleList()[i].imageName}',
                        name: '${_appProvider.getIsEnglish?_appProvider.getUsedOwnedVehicleList()[i].carName:_appProvider.getUsedOwnedVehicleList()[i].altCarName}',
                        year: '${_appProvider.getUsedOwnedVehicleList()[i].year}',
                        brand: '${_appProvider.getIsEnglish?_appProvider.getUsedOwnedVehicleList()[i].brand:_appProvider.getUsedOwnedVehicleList()[i].altBrand}',
                        model: '${_appProvider.getIsEnglish?_appProvider.getUsedOwnedVehicleList()[i].model:_appProvider.getUsedOwnedVehicleList()[i].altModel}',
                        price: 'KD ${_appProvider.getUsedOwnedVehicleList()[i].price}',
                        status: '${_appProvider.getUsedOwnedVehicleList()[i].status}',
                        isUsed: i%2==1,
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
