import 'package:Aayan/models/BrandModel.dart';
import 'package:Aayan/models/FilterVehicleModel.dart';
import 'package:Aayan/models/ModelModel.dart';
import 'package:Aayan/models/SubModelModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareLeaseDetailsScreen.dart';
import 'package:Aayan/screens/lease_vehicle/AddLeaseVehicleScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/notifications/NotificationDetailsScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/util/aayan_icons.dart';
import 'package:Aayan/widgets/CircleThumbShape.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:Aayan/widgets/filter_brand_tile.dart';
import 'package:Aayan/widgets/home_notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Aayan/extensions/app_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class SubModelLeaseVehicleScreen extends StatefulWidget {
  static final String routeName = '/sub-model-lease-vehicle';

  @override
  _SubModelLeaseVehicleScreenState createState() =>
      _SubModelLeaseVehicleScreenState();
}

class _SubModelLeaseVehicleScreenState
    extends State<SubModelLeaseVehicleScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;
  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getSubModels(
          context,
          Provider.of<AppProvider>(context, listen: false)
              .getLeaseFilterVehicleModel
              .model
              .id);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    List<SubModelModel> subModelList = _appProvider.getTempSubModelList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          '${AppLocalizations.of(context).subCategory.capitalize()}s',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          :subModelList.isEmpty
          ? Center(
            child: Text('${AppLocalizations.of(context).noResults}'),)
          :  SingleChildScrollView(
              padding:
                  EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                    keyboardType: TextInputType.visiblePassword,
                    controller: searchEditingController,
                    textInputAction: TextInputAction.search,
                    autofocus: false,
                    onFieldSubmitted: (val) {},
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      hintText:
                          '${AppLocalizations.of(context).search.capitalize()} ${AppLocalizations.of(context).model}s',
                      hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1)),
                      fillColor: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  if (subModelList.isNotEmpty)
                    for (int j = 0; j < subModelList.length; j++)
                      FilterBrandTile(
                        noImage: true,
                        imageUrl: subModelList[j].image,
                        name: _appProvider.getIsEnglish
                            ?subModelList[j].subModel:subModelList[j].altSubModel,
                        isChecked: false,
                        onPressed: () {
                          Provider.of<AppProvider>(context, listen: false)
                              .getLeaseFilterVehicleModel
                              .subModel =  _appProvider.getIsEnglish
                              ?subModelList[j].subModel:subModelList[j].altSubModel;
                          Navigator.of(context).pop();
                        },
                      ),
                ],
              ),
            ),
    );
  }
}
