import 'package:Aayan/models/BrandModel.dart';
import 'package:Aayan/models/FilterVehicleModel.dart';
import 'package:Aayan/models/ModelModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareUsedDetailsScreen.dart';
import 'package:Aayan/screens/used_vehicle/AddUsedVehicleScreen.dart';
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

class YearUsedVehicleScreen extends StatefulWidget {
  static final String routeName = '/year-used-vehicle';

  @override
  _YearUsedVehicleScreenState createState() => _YearUsedVehicleScreenState();
}

class _YearUsedVehicleScreenState extends State<YearUsedVehicleScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;
  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getUsedYear(
          context: context,
          brandName: Provider.of<AppProvider>(context, listen: false)
              .getUsedFilterVehicleModel
              .brand,
          modelName: Provider.of<AppProvider>(context, listen: false)
              .getUsedFilterVehicleModel
              .model
              .model,
          subModel: Provider.of<AppProvider>(context, listen: false)
              .getUsedFilterVehicleModel
              .subModel);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    List<String> yearList = _appProvider.getTempUsedYearList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          '${AppLocalizations.of(context).year.capitalize()}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : yearList.isEmpty
              ? Center(
                  child: Text('${AppLocalizations.of(context).noResults}'),
                )
              : SingleChildScrollView(
                  padding:
                      EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
                  child: Column(
                    children: [
                      TextFormField(
                        style:
                            TextStyle(color: Color(0xFF212121), fontSize: 14),
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
                                  color: Theme.of(context).primaryColor,
                                  width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1)),
                          fillColor: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(4)),
                      if (yearList.isNotEmpty)
                        for (int j = 0; j < yearList.length; j++)
                          FilterBrandTile(
                            imageUrl: '',
                            name: yearList[j],
                            isChecked: false,
                            onPressed: () {
                              Provider.of<AppProvider>(context, listen: false)
                                  .getUsedFilterVehicleModel
                                  .year = yearList[j];
                              Navigator.of(context).pop();
                            },
                          ),
                    ],
                  ),
                ),
    );
  }
}
