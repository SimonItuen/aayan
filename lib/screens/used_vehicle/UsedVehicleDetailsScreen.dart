import 'package:Aayan/models/FeaturedVehicleModel.dart';
import 'package:Aayan/models/PackageModel.dart';
import 'package:Aayan/models/VehicleDetailModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareUsedScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedImageSliderScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
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
import 'package:html/dom.dart' as dom;
import 'package:Aayan/extensions/app_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsedVehicleDetailsScreen extends StatefulWidget {
  static final String routeName = '/used-vehicle-details';

  @override
  _UsedVehicleDetailsScreenState createState() =>
      _UsedVehicleDetailsScreenState();
}

class _UsedVehicleDetailsScreenState extends State<UsedVehicleDetailsScreen> {
  List<String> selectedPackageIds = [];
  int groupValue = 0;
  int valueValue = 0;
  int valuePlusValue = 0;
  bool isLoading = true;
  List<VehicleDetailModel> previousDetails = [];
  PageController imagePageController = PageController();

  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getSingleUsedVehicles(context,
          id: Provider.of<AppProvider>(context, listen: false)
              .tempUsedVehicleDetail
              .id);
    });
    setState(() {});
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    if (previousDetails.isNotEmpty) {
      Provider.of<AppProvider>(context, listen: false)
          .setTempUsedVehicleDetail(previousDetails.last);
      Provider.of<AppProvider>(context, listen: false)
          .setTempUsedVehicle(VehicleModel(
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
            .getTempUsedVehicleDetail();
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
                                          onTap:(){
                                        Provider.of<AppProvider>(context, listen: false).setTempImagePageControllerIndex(imagePageController.page.toInt());
                                        Navigator.of(context).pushNamed(UsedImageSliderScreen.routeName);
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
                                  '${AppLocalizations.of(context).brand.capitalize()}',
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
                                    .setTempUsedVehicle(VehicleModel(
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
                                    .setTempUsedVehicleDetail(
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
                                isLoading =
                                    await HttpService.getSingleUsedVehicles(
                                        context,
                                        id: Provider.of<AppProvider>(context,
                                                listen: false)
                                            .tempUsedVehicleDetail
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
                                      .getCompareUsedVehicleList()
                                      .clear();
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .getCompareUsedVehicleList()
                                      .add(Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getTempUsedVehicle());
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .setCompareUsedVehicleList(_appProvider
                                          .getCompareUsedVehicleList());
                                  print(
                                      '${Provider.of<AppProvider>(context, listen: false).getCompareUsedVehicleList()}');
                                  Navigator.of(context).pushNamed(
                                      CompareUsedVehicleScreen.routeName);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: Row(
            children: [
              Expanded(
                child: AppTransparentButton(
                  onPressed: () {},
                  isExpanded: false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'KD ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                  text: '${vehicleDetails.price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: '.000',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: AppFilledButton(
                  onPressed: _appProvider.getBoolIsLoggedIn
                      ? () async {
                          setState(() {
                            isLoading = true;
                          });
                          isLoading = await HttpService
                              .postCheckAndPurchaseLeaseVehicle(context,
                                  vehicleId: vehicleDetails.id);
                          setState(() {});
                        }
                      : () async {
                          Provider.of<AppProvider>(context, listen: false)
                              .setIsFreshLoggingIn(false);
                          await Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                  isExpanded: false,
                  child: Text(
                    '${AppLocalizations.of(context).request.capitalize()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
