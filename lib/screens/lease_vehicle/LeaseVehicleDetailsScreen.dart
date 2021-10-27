import 'package:Aayan/models/FeaturedVehicleModel.dart';
import 'package:Aayan/models/LeaseAddonItemModel.dart';
import 'package:Aayan/models/PackageModel.dart';
import 'package:Aayan/models/VehicleDetailModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareLeaseScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseImageSliderScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/home_vehicle_normal_tile.dart';
import 'package:Aayan/widgets/vehicle_package_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class LeaseVehicleDetailsScreen extends StatefulWidget {
  static final String routeName = '/lease-vehicle-details';

  @override
  _LeaseVehicleDetailsScreenState createState() =>
      _LeaseVehicleDetailsScreenState();
}

class _LeaseVehicleDetailsScreenState extends State<LeaseVehicleDetailsScreen> {
  List<String> selectedPackageIds = [];
  int groupValue = 0;
  int addOnValue = null;
  bool isLoading = true;
  List<VehicleDetailModel> previousDetails = [];
  PageController imagePageController = PageController();

  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
      await HttpService.getLeaseAddOns(context);
      isLoading = await HttpService.getSingleLeaseVehicles(context,
          id: Provider.of<AppProvider>(context, listen: false)
              .tempLeaseVehicleDetail
              .id);
    });
    setState(() {});
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    if (previousDetails.isNotEmpty) {
      Provider.of<AppProvider>(context, listen: false)
          .setTempLeaseVehicleDetail(previousDetails.last);
      Provider.of<AppProvider>(context, listen: false)
          .setTempLeaseVehicle(VehicleModel(
        id: previousDetails.last.id,
        brand: previousDetails.last.brand,
        model: previousDetails.last.model,
        imageName: previousDetails.last.imageName,
        carName: previousDetails.last.carName,
        price: previousDetails.last.price,
        year: previousDetails.last.year,
        feature: previousDetails.last.feature,
        createdAt: previousDetails.last.createdAt,
        deletedAt: previousDetails.last.deletedAt,
        updatedAt: previousDetails.last.updatedAt,
        mileage: previousDetails.last.mileage,
        status: previousDetails.last.status,
      ));
      previousDetails.removeAt(previousDetails.length - 1);
      setState(() {});
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    VehicleDetailModel vehicleDetails =
        Provider.of<AppProvider>(context, listen: true)
            .getTempLeaseVehicleDetail();
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Color(0xFFF7F9FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            '${vehicleDetails.carName}',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding:
                    EdgeInsets.only(top: 32, bottom: 64, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (vehicleDetails.imageList.isNotEmpty)
                      Row(
                        children: [
                          InkWell(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8, bottom: 8),
                                child: Icon(Icons.arrow_back_ios_rounded),
                              ),
                              onTap: () {
                                imagePageController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              }),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: PageView.builder(
                                onPageChanged: (index) {
                                },
                                controller: imagePageController,
                                itemCount: vehicleDetails.imageList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      Provider.of<AppProvider>(context, listen: false).setTempImagePageControllerIndex(imagePageController.page.toInt());
                                      Navigator.of(context).pushNamed(LeaseImageSliderScreen.routeName);
                                    },
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) {
                                        return SpinKitFadingCube(
                                          size: 16,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.6),
                                        );
                                      },
                                      imageUrl:
                                          '${vehicleDetails.imageList[index]}',
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.center,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          InkWell(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8, bottom: 8),
                                child: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                              onTap: () {
                                imagePageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              }),
                        ],
                      ),
                    if (vehicleDetails.imageList.isEmpty)
                      Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child:
                            Image.asset('assets/images/default_car_image.png'),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        '${AppLocalizations.of(context).details.capitalize()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    Container(
                      width:
                          (MediaQuery.of(context).size.width * 0.9111111) - 32,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0XFFEEEEEE))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.all(2)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context).packages.capitalize()}',
                                  style: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                Text(
                                  '${vehicleDetails.brand}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context).model.capitalize()}',
                                  style: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                Text(
                                  '${vehicleDetails.model}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context).year.capitalize()}',
                                  style: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                Text(
                                  '${vehicleDetails.year}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        '${AppLocalizations.of(context).packages.capitalize()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (PackageModel package in vehicleDetails.packageList)
                          VehiclePackageModelTile(
                            duration: package.duration,
                            mileage: package.mileage,
                            installment: package.installment,
                            value: int.parse(package.id),
                            isSelected: selectedPackageIds.contains(package.id),
                            onPressed: () {
                              if (selectedPackageIds.contains(package.id)) {
                                selectedPackageIds.remove(package.id);
                                setState(() {});
                              } else {
                                selectedPackageIds.clear();
                                selectedPackageIds.add(package.id);
                                setState(() {});
                              }
                            },
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        '${AppLocalizations.of(context).addons.capitalize()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    Container(
                      width:
                          (MediaQuery.of(context).size.width * 0.9111111) - 32,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0XFFEEEEEE))),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${_appProvider.getLeaseAddonList()[0].addon}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'KD ${_appProvider.getLeaseAddonList()[1].price}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Radio(
                                      value: int.tryParse(_appProvider
                                              .getLeaseAddonList()[0]
                                              .id) ??
                                          1,
                                      groupValue: addOnValue,
                                      toggleable: true,
                                      onChanged: (value) {
                                        setState(() {
                                          addOnValue = value;
                                        });
                                      }),
                                  VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (LeaseAddonItemModel model
                                          in _appProvider
                                              .getValueLeaseAddonList())
                                        Column(
                                          children: [
                                            Text(
                                              '\u2022 ${model.item}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            Padding(padding: EdgeInsets.all(4)),
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(4)),
                    Container(
                      width:
                          (MediaQuery.of(context).size.width * 0.9111111) - 32,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0XFFEEEEEE))),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Color(0xFFB21F28),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${_appProvider.getLeaseAddonList()[1].addon}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'KD ${_appProvider.getLeaseAddonList()[1].price}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Radio(
                                      value: int.tryParse(_appProvider
                                              .getLeaseAddonList()[1]
                                              .id) ??
                                          2,
                                      groupValue: addOnValue,
                                      toggleable: true,
                                      onChanged: (value) {
                                        setState(() {
                                          addOnValue = value;
                                        });
                                      }),
                                  VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (LeaseAddonItemModel model
                                          in _appProvider
                                              .getValuePlusLeaseAddonList())
                                        Column(
                                          children: [
                                            Text(
                                              '\u2022 ${model.item}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            Padding(padding: EdgeInsets.all(4)),
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if(vehicleDetails.feature.trim().isNotEmpty)Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        '${AppLocalizations.of(context).features.capitalize()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    if(vehicleDetails.feature.trim().isNotEmpty)Container(
                      width:
                          (MediaQuery.of(context).size.width * 0.9111111) - 32,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0XFFEEEEEE))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                              data:
                                  '${htmlParser.parse(vehicleDetails.feature).outerHtml}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        '${AppLocalizations.of(context).similarVehicles.capitalize()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          for (VehicleModel vehicle
                              in vehicleDetails.similarVehicleList)
                            HomeVehicleNormalTile(
                              imageUrl: vehicle.imageName,
                              name: vehicle.carName,
                              year: vehicle.year,
                              brand: vehicle.brand,
                              model: vehicle.model,
                              price: 'KD ${vehicle.price}',
                              onPressed: () async {
                                previousDetails.add(vehicleDetails);
                                setState(() {
                                  isLoading = true;
                                });
                                Provider.of<AppProvider>(context, listen: false)
                                    .setTempLeaseVehicle(VehicleModel(
                                  id: vehicle.id,
                                  brand: vehicle.brand,
                                  model: vehicle.model,
                                  imageName: vehicle.imageName,
                                  carName: vehicle.carName,
                                  price: vehicle.price,
                                  year: vehicle.year,
                                  feature: vehicle.feature,
                                  createdAt: vehicle.createdAt,
                                  deletedAt: vehicle.deletedAt,
                                  updatedAt: vehicle.updatedAt,
                                  mileage: vehicle.mileage,
                                  status: vehicle.status,
                                ));
                                Provider.of<AppProvider>(context, listen: false)
                                    .setTempLeaseVehicleDetail(
                                        VehicleDetailModel(
                                  id: vehicle.id,
                                  brand: vehicle.brand,
                                  model: vehicle.model,
                                  imageName: vehicle.imageName,
                                  carName: vehicle.carName,
                                  price: vehicle.price,
                                  year: vehicle.year,
                                  feature: vehicle.feature,
                                  mileage: vehicle.mileage,
                                  createdAt: vehicle.createdAt,
                                  deletedAt: vehicle.deletedAt,
                                  updatedAt: vehicle.updatedAt,
                                  status: vehicle.status,
                                ));

                                await HttpService.getLeaseAddOns(context);
                                isLoading =
                                    await HttpService.getSingleLeaseVehicles(
                                        context,
                                        id: Provider.of<AppProvider>(context,
                                                listen: false)
                                            .tempLeaseVehicleDetail
                                            .id);
                                setState(() {});
                              },
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        '${AppLocalizations.of(context).compareVehicle.capitalize()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.width *
                                    0.9111111 *
                                    0.341463,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: vehicleDetails.imageList.isNotEmpty
                                      ? CachedNetworkImage(
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) {
                                            return SpinKitDoubleBounce(
                                              size: 16,
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.6),
                                            );
                                          },
                                          imageUrl:
                                              '${vehicleDetails.imageList[0]}',
                                          fit: BoxFit.contain,
                                          alignment: Alignment.center,
                                        )
                                      : Image.asset(
                                          'assets/images/default_car_image.png'),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(2)),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .getCompareLeaseVehicleList()
                                      .clear();
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .getCompareLeaseVehicleList()
                                      .add(Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getTempLeaseVehicle());
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .setCompareLeaseVehicleList(_appProvider
                                          .getCompareLeaseVehicleList());
                                  Navigator.of(context).pushNamed(
                                      CompareLeaseVehicleScreen.routeName);
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.width *
                                      0.9111111 *
                                      0.341463,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle_rounded,
                                        color: Color(0xFF9E9E9E),
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context).aDDCAR.toUpperCase()}',
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.06667,
                          height: MediaQuery.of(context).size.width * 0.06667,
                          child: Center(
                            child: Text(
                              '${AppLocalizations.of(context).vs.toUpperCase()}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AppFilledButton(
          onPressed: (selectedPackageIds.isNotEmpty /*&& addOnValue != null*/)
              ? _appProvider.getBoolIsLoggedIn
                  ? () async {
                      setState(() {
                        isLoading = true;
                      });
                      isLoading = await HttpService.postRequestLeaseVehicle(
                          context,
                          vehicleId: vehicleDetails.id,
                          packageId: selectedPackageIds.isNotEmpty
                              ? selectedPackageIds[0]
                              : '',
                          addOnId: '${addOnValue ?? 1}');
                      setState(() {});
                    }
                  : () async {
                      Provider.of<AppProvider>(context, listen: false)
                          .setIsFreshLoggingIn(false);
                      await Navigator.of(context)
                          .pushNamed(LoginScreen.routeName);
                    }
              : () {
                  final snackBar = SnackBar(
                      content: Text(
                        '${AppLocalizations.of(context).pleaseSelectAPackageAndAnAddon}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Theme.of(context).primaryColor);

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
          child: Text(
            '${AppLocalizations.of(context).request.capitalize()}',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
