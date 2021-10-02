import 'package:Aayan/models/FilterVehicleModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareUsedDetailsScreen.dart';
import 'package:Aayan/screens/filter/BrandUsedVehicleScreen.dart';
import 'package:Aayan/screens/filter/ModelUsedVehicleScreen.dart';
import 'package:Aayan/screens/filter/SubModelUsedVehicleScreen.dart';
import 'package:Aayan/screens/filter/YearUsedVehicleScreen.dart';
import 'package:Aayan/screens/used_vehicle/AddUsedVehicleScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/notifications/NotificationDetailsScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/util/aayan_icons.dart';
import 'package:Aayan/widgets/CircleThumbShape.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:Aayan/widgets/home_notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class FilterUsedVehicleScreen extends StatefulWidget {
  static final String routeName = '/filter-used-vehicle';

  @override
  _FilterUsedVehicleScreenState createState() =>
      _FilterUsedVehicleScreenState();
}

class _FilterUsedVehicleScreenState extends State<FilterUsedVehicleScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController brandEditingController = TextEditingController();
  TextEditingController modelEditingController = TextEditingController();
  TextEditingController subModelEditingController = TextEditingController();
  TextEditingController yearEditingController = TextEditingController();
  RangeValues _currentRangeValues;
  bool isError = false;
  bool isButtonPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentRangeValues =
        Provider.of<AppProvider>(context, listen: false).getUsedCarPriceRange;
    print(_currentRangeValues.toString());
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
      if (Provider.of<AppProvider>(context, listen: false)
              .getUsedFilterVehicleModel
              .minPrice !=
          null) {
        _currentRangeValues = RangeValues(
            double.tryParse(Provider.of<AppProvider>(context, listen: false)
                    .getUsedFilterVehicleModel
                    .minPrice) ??
                Provider.of<AppProvider>(context, listen: false)
                    .getUsedCarPriceRange
                    .start,
            double.tryParse(Provider.of<AppProvider>(context, listen: false)
                    .getUsedFilterVehicleModel
                    .maxPrice) ??
                Provider.of<AppProvider>(context, listen: false)
                    .getUsedCarPriceRange
                    .end);
      } else {
        _currentRangeValues = RangeValues(
            int.tryParse(
                    '${Provider.of<AppProvider>(context, listen: false).getUsedFilterVehicleModel.minPrice}') ??
                Provider.of<AppProvider>(context, listen: false)
                    .getUsedCarPriceRange
                    .start,
            int.tryParse(
                    '${Provider.of<AppProvider>(context, listen: false).getUsedFilterVehicleModel.maxPrice}') ??
                Provider.of<AppProvider>(context, listen: false)
                    .getUsedCarPriceRange
                    .end);
      }
      Provider.of<AppProvider>(context, listen: false)
          .getUsedFilterVehicleModel
          .minPrice = _currentRangeValues.start.round().toString();
      Provider.of<AppProvider>(context, listen: false)
          .getUsedFilterVehicleModel
          .maxPrice = _currentRangeValues.end.round().toString();
      brandEditingController.text =
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? Provider.of<AppProvider>(context, listen: false)
                  .getUsedFilterVehicleModel
                  .brand
              : Provider.of<AppProvider>(context, listen: false)
                  .getUsedFilterVehicleModel
                  .arBrand;
      modelEditingController.text =
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? Provider.of<AppProvider>(context, listen: false)
                  .getUsedFilterVehicleModel
                  .model
                  ?.model
              : Provider.of<AppProvider>(context, listen: false)
                  .getUsedFilterVehicleModel
                  .model
                  ?.altModel;
      subModelEditingController.text =
          Provider.of<AppProvider>(context, listen: false).getIsEnglish
              ? Provider.of<AppProvider>(context, listen: false)
                  .getUsedFilterVehicleModel
                  .subModel
              : Provider.of<AppProvider>(context, listen: false)
                  .getUsedFilterVehicleModel
                  .subModel;
      yearEditingController.text =
          Provider.of<AppProvider>(context, listen: false)
              .getUsedFilterVehicleModel
              .year;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          '${AppLocalizations.of(context).filter.capitalize()}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).brand}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                    keyboardType: TextInputType.text,
                    controller: brandEditingController,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await Navigator.of(context)
                          .pushNamed(BrandUsedVehicleScreen.routeName);
                      brandEditingController.text = _appProvider.getIsEnglish
                          ? _appProvider.getUsedFilterVehicleModel.brand
                          : _appProvider.getUsedFilterVehicleModel.arBrand;
                      modelEditingController.text = '';
                      subModelEditingController.text = '';
                      yearEditingController.text = '';
                      setState(() {});
                    },
                    onChanged: (val) {
                      isButtonPressed = false;
                      if (isError) {
                        formKey.currentState.validate();
                      }
                    },
                    validator: (val) {
                      if (!isButtonPressed) {
                        return null;
                      }
                      isError = true;
                      if (val.isEmpty) {
                        return '${AppLocalizations.of(context).brand.capitalize()} ${AppLocalizations.of(context).cannotBeEmpty}';
                      }
                      isError = false;
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      hintText:
                          '${AppLocalizations.of(context).select.capitalize()}',
                      hintStyle: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      fillColor: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).model}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                    keyboardType: TextInputType.text,
                    controller: modelEditingController,
                    showCursor: false,
                    enabled: _appProvider.getUsedFilterVehicleModel.brand
                            .toString() !=
                        null.toString(),
                    enableInteractiveSelection: false,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await Navigator.of(context)
                          .pushNamed(ModelUsedVehicleScreen.routeName);
                      modelEditingController.text = _appProvider.getIsEnglish
                          ?
                          _appProvider.getUsedFilterVehicleModel.model.model:_appProvider.getUsedFilterVehicleModel.model.altModel;
                      _appProvider.getUsedFilterVehicleModel.subModel = null;
                      _appProvider.getUsedFilterVehicleModel.year = null;
                      subModelEditingController.text = '';
                      yearEditingController.text = '';
                      setState(() {});
                    },
                    onChanged: (val) {
                      isButtonPressed = false;
                      if (isError) {
                        formKey.currentState.validate();
                      }
                    },
                    validator: (val) {
                      if (!isButtonPressed) {
                        return null;
                      }
                      isError = true;
                      if (val.isEmpty) {
                        return '${AppLocalizations.of(context).model.capitalize()} ${AppLocalizations.of(context).cannotBeEmpty}';
                      }
                      isError = false;
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      hintText:
                          '${AppLocalizations.of(context).select.capitalize()}',
                      hintStyle: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      fillColor: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).subCategory.capitalize()}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                    keyboardType: TextInputType.text,
                    controller: subModelEditingController,
                    enabled: _appProvider.getUsedFilterVehicleModel.model
                            .toString() !=
                        null.toString(),
                    showCursor: false,
                    enableInteractiveSelection: false,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await Navigator.of(context)
                          .pushNamed(SubModelUsedVehicleScreen.routeName);
                      subModelEditingController.text =
                          _appProvider.getUsedFilterVehicleModel.subModel;
                      _appProvider.getUsedFilterVehicleModel.year = null;
                      yearEditingController.text = '';
                      setState(() {});
                    },
                    onChanged: (val) {
                      isButtonPressed = false;
                      if (isError) {
                        formKey.currentState.validate();
                      }
                    },
                    validator: (val) {
                      if (!isButtonPressed) {
                        return null;
                      }
                      isError = true;
                      if (val.isEmpty) {
                        return '${AppLocalizations.of(context).model.capitalize()} ${AppLocalizations.of(context).cannotBeEmpty}';
                      }
                      isError = false;
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      hintText:
                          '${AppLocalizations.of(context).select.capitalize()}',
                      hintStyle: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      fillColor: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).year}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                    keyboardType: TextInputType.text,
                    controller: yearEditingController,
                    enabled: _appProvider.getUsedFilterVehicleModel.subModel
                            .toString() !=
                        null.toString(),
                    showCursor: false,
                    enableInteractiveSelection: false,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await Navigator.of(context)
                          .pushNamed(YearUsedVehicleScreen.routeName);
                      yearEditingController.text =
                          _appProvider.getUsedFilterVehicleModel.year;
                      setState(() {});
                    },
                    onChanged: (val) {
                      isButtonPressed = false;
                      if (isError) {
                        formKey.currentState.validate();
                      }
                    },
                    validator: (val) {
                      if (!isButtonPressed) {
                        return null;
                      }
                      isError = true;
                      if (val.isEmpty) {
                        return '${AppLocalizations.of(context).year.capitalize()} ${AppLocalizations.of(context).cannotBeEmpty}';
                      }
                      isError = false;
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      hintText:
                          '${AppLocalizations.of(context).select.capitalize()}',
                      hintStyle: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFC2D1F3), width: 1)),
                      fillColor: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Padding(padding: EdgeInsets.all(8)),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      '${AppLocalizations.of(context).price.capitalize()}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: Theme.of(context).primaryColor,
                      trackHeight: 4,
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 1),
                      rangeThumbShape: CircleThumbShape(thumbRadius: 6),
                    ),
                    child: RangeSlider(
                      values: _currentRangeValues,
                      min: Provider.of<AppProvider>(context, listen: false)
                          .getUsedCarPriceRange
                          .start,
                      max: Provider.of<AppProvider>(context, listen: false)
                          .getUsedCarPriceRange
                          .end,
                      divisions: (Provider.of<AppProvider>(context,
                                      listen: false)
                                  .getUsedCarPriceRange
                                  .end
                                  .round() -
                              Provider.of<AppProvider>(context, listen: false)
                                  .getUsedCarPriceRange
                                  .start
                                  .round()) ~/
                          10,
                      labels: RangeLabels(
                        '${_currentRangeValues.start.round().toString()} KD',
                        '${_currentRangeValues.end.round().toString()} KD',
                      ),
                      onChanged: (RangeValues values) {
                        Provider.of<AppProvider>(context, listen: false)
                            .getUsedFilterVehicleModel
                            .minPrice = values.start.round().toString();
                        Provider.of<AppProvider>(context, listen: false)
                            .getUsedFilterVehicleModel
                            .maxPrice = values.end.round().toString();
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: [
                        Text(
                          '${Provider.of<AppProvider>(context, listen: false).getUsedCarPriceRange.start.toInt()}KD',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          '${Provider.of<AppProvider>(context, listen: false).getUsedCarPriceRange.end.toInt()}KD',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  AppFilledButton(
                    onPressed: () async {
                      isButtonPressed = true;
                      Provider.of<AppProvider>(context, listen: false)
                          .getUsedPageInfoModel
                          .currentPage = 1;
                      setState(() {
                        isLoading = true;
                      });
                      isLoading = await HttpService.getUsedVehiclesWithFilter(
                          context,
                          Provider.of<AppProvider>(context, listen: false)
                              .getUsedFilterVehicleModel);
                      setState(() {});

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '${AppLocalizations.of(context).filter.capitalize()}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
              child: Visibility(
                  visible: isLoading,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(child: CircularProgressIndicator()),
                  )))
        ],
      ),
    );
  }
}
