import 'dart:async';

import 'package:Aayan/models/BrandModel.dart';
import 'package:Aayan/models/CarDetailModel.dart';
import 'package:Aayan/models/FeaturedVehicleModel.dart';
import 'package:Aayan/models/FilterVehicleModel.dart';
import 'package:Aayan/models/NotificationModel.dart';
import 'package:Aayan/models/VehicleDetailModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleDetailsScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleScreen.dart';
import 'package:Aayan/screens/notifications/NotificationDetailsScreen.dart';
import 'package:Aayan/screens/notifications/NotificationsScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleDetailsScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/home_brand_tile.dart';
import 'package:Aayan/widgets/home_notification_tile.dart';
import 'package:Aayan/widgets/home_owned_vehicle_tile.dart';
import 'package:Aayan/widgets/home_request_tile.dart';
import 'package:Aayan/widgets/home_slide_tile.dart';
import 'package:Aayan/widgets/home_vehicle_normal_tile.dart';
import 'package:Aayan/widgets/sliding_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  int currentCarsPage = 0;
  bool isLoading = true;
  Timer timer;

  void onPageChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Future.delayed(Duration.zero, () async {
      timer = Timer.periodic(Duration(minutes: 1), (Timer timer) async {
        await HttpService.getHomeNotifications(context);
      });
      Provider.of<AppProvider>(context, listen: false).getBoolIsLoggedIn
          ? await Future.wait([
              HttpService.getBanners(context),
              HttpService.getLeaseFeaturedVehicles(context),
              HttpService.getUsedFeaturedVehicles(context),
              HttpService.getLeaseVehicles(context),
              HttpService.getUsedVehicles(context),
              HttpService.getMostSearchedLeaseVehicles(context),
              HttpService.getMostSearchedUsedVehicles(context),
              HttpService.getBrands(context),
              HttpService.getUsedBrands(context),
              HttpService.getLeaseVehiclePriceRange(context),
              HttpService.getUsedVehiclePriceRange(context),
              HttpService.getUsedBrands(context),
              HttpService.getAboutUs(context),
              HttpService.getContactUs(context),
              HttpService.getTopBrands(context),
              HttpService.getTopUsedBrands(context),
              HttpService.myDetails(context),
              HttpService.getHomeNotifications(context),
              HttpService.getMostRecentSearchedLeaseVehicles(context),
              HttpService.getMostRecentSearchedUsedVehicles(context),
              HttpService.getOwnedLeaseVehicle(context),
              HttpService.getOwnedUsedVehicle(context),
            ])
          : await Future.wait([
              HttpService.getBanners(context),
              HttpService.getLeaseFeaturedVehicles(context),
              HttpService.getUsedFeaturedVehicles(context),
              HttpService.getLeaseVehicles(context),
              HttpService.getUsedVehicles(context),
              HttpService.getMostSearchedLeaseVehicles(context),
              HttpService.getMostSearchedUsedVehicles(context),
              HttpService.getBrands(context),
              HttpService.getUsedBrands(context),
              HttpService.getTopBrands(context),
              HttpService.getTopUsedBrands(context),
              HttpService.getLeaseVehiclePriceRange(context),
              HttpService.getUsedVehiclePriceRange(context),
              HttpService.getHomeNotifications(context),
              HttpService.getAboutUs(context),
              HttpService.getContactUs(context),
            ]);

      isLoading = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                Provider.of<AppProvider>(context, listen: false)
                        .getBoolIsLoggedIn
                    ? await Future.wait([
                        HttpService.getBanners(context),
                        HttpService.getLeaseFeaturedVehicles(context),
                        HttpService.getUsedFeaturedVehicles(context),
                        HttpService.getLeaseVehicles(context),
                        HttpService.getUsedVehicles(context),
                        HttpService.getMostSearchedLeaseVehicles(context),
                        HttpService.getMostSearchedUsedVehicles(context),
                        HttpService.getBrands(context),
                        HttpService.getUsedBrands(context),
                        HttpService.myDetails(context),
                        HttpService.getHomeNotifications(context),
                        HttpService.getMostRecentSearchedLeaseVehicles(context),
                        HttpService.getMostRecentSearchedUsedVehicles(context),
                        HttpService.getOwnedLeaseVehicle(context),
                        HttpService.getOwnedUsedVehicle(context),
                      ])
                    : await Future.wait([
                        HttpService.getBanners(context),
                        HttpService.getLeaseFeaturedVehicles(context),
                        HttpService.getUsedFeaturedVehicles(context),
                        HttpService.getLeaseVehicles(context),
                        HttpService.getUsedVehicles(context),
                        HttpService.getUsedBrands(context),
                        HttpService.getMostSearchedLeaseVehicles(context),
                        HttpService.getMostSearchedUsedVehicles(context),
                        HttpService.getHomeNotifications(context),
                        HttpService.getBrands(context),
                      ]);
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                          onPageChanged: onPageChange,
                          itemCount: _appProvider.getBannerList().length,
                          controller: pageController,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: _appProvider
                                          .getBannerList()[index]
                                          .linkType ==
                                      'External'
                                  ? () async {
                                      await canLaunch(_appProvider
                                              .getBannerList()[index]
                                              .externalLink)
                                          ? await launch(_appProvider
                                              .getBannerList()[index]
                                              .externalLink)
                                          : ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                    'Could not launch ${_appProvider.getBannerList()[index].externalLink}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor));
                                    }
                                  : _appProvider
                                              .getBannerList()[index]
                                              .linkType ==
                                          'Lease Car'
                                      ? () {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .setTempLeaseVehicle(VehicleModel(
                                                  id: _appProvider
                                                      .getBannerList()[index]
                                                      .leaseCar,
                                                  carName: '',
                                                  price: '0'));
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .setTempLeaseVehicleDetail(
                                                  VehicleDetailModel(
                                                      id: _appProvider
                                                          .getBannerList()[
                                                              index]
                                                          .leaseCar,
                                                      carName: '',
                                                      price: '0'));
                                          Navigator.of(context).pushNamed(
                                              LeaseVehicleDetailsScreen
                                                  .routeName);
                                        }
                                      : () {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .setTempUsedVehicle(VehicleModel(
                                                  id: _appProvider
                                                      .getBannerList()[index]
                                                      .usedCar,
                                                  carName: '',
                                                  price: '0'));
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .setTempUsedVehicleDetail(
                                                  VehicleDetailModel(
                                                      id: _appProvider
                                                          .getBannerList()[
                                                              index]
                                                          .usedCar,
                                                      carName: '',
                                                      price: '0'));
                                          Navigator.of(context).pushNamed(
                                              UsedVehicleDetailsScreen
                                                  .routeName);
                                        },
                              child: CachedNetworkImage(
                                imageUrl: _appProvider
                                    .getBannerList()[index]
                                    .bannerImage,
                                fit: BoxFit.fitWidth,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return SpinKitDoubleBounce(
                                    size: 16,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.6),
                                  );
                                },
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < _appProvider.getBannerList().length;
                                    i++)
                                  SlidingTile(
                                    isActive: i == currentIndex,
                                  )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _appProvider.isLoggedIn&&
                                (currentCarsPage == 0
                                    ? _appProvider
                                    .getLeaseOwnedVehicleList()
                                    .isNotEmpty
                                    : _appProvider
                                    .getUsedOwnedVehicleList()
                                    .isNotEmpty),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 16),
                                  child: Text(
                                    '${AppLocalizations.of(context).ownedVehicles}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child:currentCarsPage == 0
                                      ? Row(
                                    children: [
                                      for (int i = 0;
                                      i <
                                          _appProvider
                                              .getLeaseOwnedVehicleList()
                                              .length;
                                      i++)
                                        HomeOwnedVehicleTile(
                                          imageUrl: _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .imageName,
                                          name: _appProvider.getIsEnglish
                                              ? _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .carName
                                              : _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .altCarName,
                                          year: _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .year,
                                          brand: _appProvider.getIsEnglish
                                              ? _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .brand
                                              : _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .model
                                              : _appProvider
                                              .getLeaseOwnedVehicleList()[i]
                                              .altModel,
                                          price:
                                          'KD ${_appProvider.getLeaseOwnedVehicleList()[i].price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                listen: false)
                                                .setTempLeaseVehicle(
                                                VehicleModel(
                                                  id: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .id,
                                                  brand: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .brand
                                                      : _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .altBrand,
                                                  model: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .model
                                                      : _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .altModel,
                                                  imageName: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .imageName,
                                                  carName: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .carName
                                                      : _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .altCarName,
                                                  price: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .price,
                                                  year: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .year,
                                                  status: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .status,
                                                ));
                                            Provider.of<AppProvider>(context,
                                                listen: false)
                                                .setTempLeaseVehicleDetail(
                                                VehicleDetailModel(
                                                  id: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .id,
                                                  brand: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .brand
                                                      : _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .altBrand,
                                                  model: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .model
                                                      : _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .altModel,
                                                  imageName: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .imageName,
                                                  carName: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .carName
                                                      : _appProvider
                                                      .getLeaseOwnedVehicleList()[
                                                  i]
                                                      .altCarName,
                                                  price: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .price,
                                                  year: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .year,
                                                  status: _appProvider
                                                      .getLeaseOwnedVehicleList()[i]
                                                      .status,
                                                ));
                                            Navigator.of(context).pushNamed(
                                                LeaseVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      for (int i = 0;
                                      i <
                                          _appProvider
                                              .getUsedOwnedVehicleList()
                                              .length;
                                      i++)
                                        HomeOwnedVehicleTile(
                                          imageUrl: _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .imageName,
                                          name: _appProvider.getIsEnglish
                                              ? _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .carName
                                              : _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .altCarName,
                                          year: _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .year,
                                          brand: _appProvider.getIsEnglish
                                              ? _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .brand
                                              : _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .model
                                              : _appProvider
                                              .getUsedOwnedVehicleList()[i]
                                              .altModel,
                                          price:
                                          'KD ${_appProvider.getUsedOwnedVehicleList()[i].price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                listen: false)
                                                .setTempUsedVehicle(
                                                VehicleModel(
                                                  id: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .id,
                                                  brand: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .brand
                                                      : _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .altBrand,
                                                  model: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .model
                                                      : _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .altModel,
                                                  imageName: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .imageName,
                                                  carName: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .carName
                                                      : _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .altCarName,
                                                  price: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .price,
                                                  year: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .year,
                                                  status: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .status,
                                                ));
                                            Provider.of<AppProvider>(context,
                                                listen: false)
                                                .setTempUsedVehicleDetail(
                                                VehicleDetailModel(
                                                  id: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .id,
                                                  brand: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .brand
                                                      : _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .altBrand,
                                                  model: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .model
                                                      : _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .altModel,
                                                  imageName: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .imageName,
                                                  carName: _appProvider.getIsEnglish
                                                      ? _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .carName
                                                      : _appProvider
                                                      .getUsedOwnedVehicleList()[
                                                  i]
                                                      .altCarName,
                                                  price: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .price,
                                                  year: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .year,
                                                  status: _appProvider
                                                      .getUsedOwnedVehicleList()[i]
                                                      .status,
                                                ));
                                            Navigator.of(context).pushNamed(
                                                UsedVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HomeRequestTile(
                                        icon: Icons.warning_amber_rounded,
                                        imageUrl:
                                            'assets/images/emergency_backdrop.png',
                                        title:
                                            '${AppLocalizations.of(context).emergencyRequest}',
                                        onPressed:(){
                                          Provider.of<AppProvider>(context, listen: false)
                                              .setCurrentPage(4);
                                        }
                                      ),
                                      HomeRequestTile(
                                        icon: Icons.build_rounded,
                                        imageUrl:
                                            'assets/images/servicing_backdrop.png',
                                        title:
                                            '${AppLocalizations.of(context).servicingRequest}',
                                          onPressed:(){
                                            Provider.of<AppProvider>(context, listen: false)
                                                .setCurrentPage(3);
                                          }
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.9111,
                            decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Expanded(
                                    child: HomeSlideTile(
                                  text:
                                      '${AppLocalizations.of(context).leaseCars}',
                                  isActive: currentCarsPage == 0,
                                  onPressed: () {
                                    setState(() {
                                      currentCarsPage = 0;
                                    });
                                  },
                                )),
                                Expanded(
                                    child: HomeSlideTile(
                                  text:
                                      '${AppLocalizations.of(context).usedCars}',
                                  isActive: currentCarsPage == 1,
                                  onPressed: () {
                                    setState(() {
                                      currentCarsPage = 1;
                                    });
                                  },
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                            child: InkWell(
                              onTap: currentCarsPage == 0
                                  ? () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getLeaseVehicleList()
                                          .clear();
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getCompareLeaseVehicleList()
                                          .clear();
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .setLeaseVehicleSelectedIds([]);
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .setLeaseFilterVehicleModel(
                                              FilterVehicleModel());
                                      Navigator.of(context).pushNamed(
                                          LeaseVehicleScreen.routeName);
                                    }
                                  : () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getUsedVehicleList()
                                          .clear();
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getCompareUsedVehicleList()
                                          .clear();
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .setUsedVehicleSelectedIds([]);
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .setUsedFilterVehicleModel(
                                              FilterVehicleModel());
                                      Navigator.of(context).pushNamed(
                                          UsedVehicleScreen.routeName);
                                    },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currentCarsPage == 0
                                        ? '${AppLocalizations.of(context).getALeaseCar}'
                                        : '${AppLocalizations.of(context).buyAUsedVehicle}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 3, bottom: 3, left: 3),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Theme.of(context).primaryColor,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: currentCarsPage == 0
                                ? Row(
                                    children: [
                                      for (int i = 0;
                                          i <
                                              _appProvider
                                                  .getHomeLeaseVehicleList()
                                                  .length;
                                          i++)
                                        HomeVehicleNormalTile(
                                          imageUrl: _appProvider
                                              .getHomeLeaseVehicleList()[i]
                                              .imageName,
                                          name: _appProvider.getIsEnglish
                                              ? _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .carName
                                              : _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .altCarName,
                                          year: _appProvider
                                              .getHomeLeaseVehicleList()[i]
                                              .year,
                                          brand: _appProvider.getIsEnglish
                                              ? _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .brand
                                              : _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .model
                                              : _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .altModel,
                                          price:
                                              'KD ${_appProvider.getHomeLeaseVehicleList()[i].price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempLeaseVehicle(
                                                    VehicleModel(
                                              id: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .id,
                                              brand: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .brand
                                                  : _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .model
                                                  : _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .altModel,
                                              imageName: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .carName
                                                  : _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .altCarName,
                                              price: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .price,
                                              year: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .year,
                                              feature: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .feature,
                                              createdAt: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .createdAt,
                                              deletedAt: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .deletedAt,
                                              updatedAt: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .updatedAt,
                                              mileage: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .mileage,
                                              status: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .status,
                                            ));
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempLeaseVehicleDetail(
                                                    VehicleDetailModel(
                                              id: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .id,
                                              brand: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .brand
                                                  : _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .model
                                                  : _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .altModel,
                                              imageName: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .carName
                                                  : _appProvider
                                                      .getHomeLeaseVehicleList()[
                                                          i]
                                                      .altCarName,
                                              price: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .price,
                                              year: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .year,
                                              feature: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .feature,
                                              mileage: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .mileage,
                                              createdAt: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .createdAt,
                                              deletedAt: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .deletedAt,
                                              updatedAt: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .updatedAt,
                                              status: _appProvider
                                                  .getHomeLeaseVehicleList()[i]
                                                  .status,
                                            ));
                                            Navigator.of(context).pushNamed(
                                                LeaseVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      for (int i = 0;
                                          i <
                                              Math.min(
                                                  _appProvider
                                                      .getHomeUsedVehicleList()
                                                      .length,
                                                  3);
                                          i++)
                                        HomeVehicleNormalTile(
                                          imageUrl: _appProvider
                                              .getHomeUsedVehicleList()[i]
                                              .imageName,
                                          name: _appProvider.getIsEnglish
                                              ? _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .carName
                                              : _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .altCarName,
                                          year: _appProvider
                                              .getHomeUsedVehicleList()[i]
                                              .year,
                                          brand: _appProvider.getIsEnglish
                                              ? _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .brand
                                              : _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .model
                                              : _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .altModel,
                                          price:
                                              'KD ${_appProvider.getHomeUsedVehicleList()[i].price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempUsedVehicle(
                                                    VehicleModel(
                                              id: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .id,
                                              brand: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .brand
                                                  : _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .model
                                                  : _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .altModel,
                                              imageName: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .carName
                                                  : _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .altCarName,
                                              price: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .price,
                                              year: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .year,
                                              feature: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .feature,
                                              createdAt: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .createdAt,
                                              deletedAt: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .deletedAt,
                                              updatedAt: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .updatedAt,
                                              mileage: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .mileage,
                                              status: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .status,
                                            ));
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempUsedVehicleDetail(
                                                    VehicleDetailModel(
                                              id: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .id,
                                              brand: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .brand
                                                  : _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .model
                                                  : _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .altModel,
                                              imageName: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .carName
                                                  : _appProvider
                                                      .getHomeUsedVehicleList()[
                                                          i]
                                                      .altCarName,
                                              price: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .price,
                                              year: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .year,
                                              feature: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .feature,
                                              mileage: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .mileage,
                                              createdAt: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .createdAt,
                                              deletedAt: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .deletedAt,
                                              updatedAt: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .updatedAt,
                                              status: _appProvider
                                                  .getHomeUsedVehicleList()[i]
                                                  .status,
                                            ));
                                            Navigator.of(context).pushNamed(
                                                UsedVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                            child: Text(
                              '${AppLocalizations.of(context).featured}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: currentCarsPage == 0
                                ? Row(
                                    children: [
                                      for (FeaturedVehicleModel vehicle
                                          in _appProvider
                                              .getLeaseFeaturedVehicleList())
                                        HomeVehicleNormalTile(
                                          imageUrl: vehicle.imageName,
                                          name: _appProvider.getIsEnglish
                                              ? vehicle.carName
                                              : vehicle.altCarName,
                                          year: vehicle.year,
                                          brand: _appProvider.getIsEnglish
                                              ? vehicle.brand
                                              : vehicle.altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? vehicle.model
                                              : vehicle.altModel,
                                          price: 'KD ${vehicle.price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempLeaseVehicle(
                                                    VehicleModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.model,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                            ));
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempLeaseVehicleDetail(
                                                    VehicleDetailModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.model,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                            ));
                                            Navigator.of(context).pushNamed(
                                                LeaseVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      for (FeaturedVehicleModel vehicle
                                          in _appProvider
                                              .getUsedFeaturedVehicleList())
                                        HomeVehicleNormalTile(
                                          imageUrl: vehicle.imageName,
                                          name: _appProvider.getIsEnglish
                                              ? vehicle.carName
                                              : vehicle.altCarName,
                                          year: vehicle.year,
                                          brand: _appProvider.getIsEnglish
                                              ? vehicle.brand
                                              : vehicle.altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? vehicle.model
                                              : vehicle.altModel,
                                          price: 'KD ${vehicle.price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempUsedVehicle(
                                                    VehicleModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.model,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                            ));
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempUsedVehicleDetail(
                                                    VehicleDetailModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.model,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                            ));
                                            Navigator.of(context).pushNamed(
                                                UsedVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                            child: Text(
                              '${AppLocalizations.of(context).topBrands}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  if (currentCarsPage == 0)
                                    for (BrandModel brand
                                        in _appProvider.getTopBrandList())
                                      HomeBrandTile(
                                          imageUrl: brand.image,
                                          onPressed: currentCarsPage == 0
                                              ? () {
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .getLeaseVehicleList()
                                                      .clear();
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .setLeaseVehicleSelectedIds(
                                                          [brand.title]);
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          LeaseVehicleScreen
                                                              .routeName);
                                                }
                                              : () {
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .getUsedVehicleList()
                                                      .clear();
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .setUsedVehicleSelectedIds(
                                                          [brand.title]);
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          UsedVehicleScreen
                                                              .routeName);
                                                }),
                                  if (currentCarsPage == 1)
                                    for (BrandModel brand
                                        in _appProvider.getTopUsedBrandList())
                                      HomeBrandTile(
                                          imageUrl: brand.image,
                                          onPressed: currentCarsPage == 0
                                              ? () {
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .getLeaseVehicleList()
                                                      .clear();
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .setLeaseVehicleSelectedIds(
                                                          [brand.title]);
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          LeaseVehicleScreen
                                                              .routeName);
                                                }
                                              : () {
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .getUsedVehicleList()
                                                      .clear();
                                                  Provider.of<AppProvider>(
                                                          context,
                                                          listen: false)
                                                      .setUsedVehicleSelectedIds(
                                                          [brand.title]);
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          UsedVehicleScreen
                                                              .routeName);
                                                }),
                                ],
                              ),
                            ),
                          ),
                          /*Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.5,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                        child: Image.asset(
                                            'assets/images/home_backdrop.png')),
                                    Positioned.fill(
                                        child: Container(
                                      color: Colors.black.withOpacity(0.6),
                                    )),
                                    Positioned.fill(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context).bOOKONYOURCONVENIENCE}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.24166)),
                                          child: AppFilledButton(
                                            isExpanded: false,
                                            child: Container(
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(4)),
                                                    Text(
                                                      '${AppLocalizations.of(context).bOOKAPPOINTMENT}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                )),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                            child: Text(
                              '${AppLocalizations.of(context).mostSearchedVehicles}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: currentCarsPage == 0
                                ? Row(
                                    children: [
                                      for (VehicleModel vehicle in _appProvider
                                          .getMostSearchedLeaseVehicleList())
                                        HomeVehicleNormalTile(
                                          imageUrl: vehicle.imageName,
                                          name: _appProvider.getIsEnglish
                                              ? vehicle.carName
                                              : vehicle.altCarName,
                                          year: vehicle.year,
                                          brand: _appProvider.getIsEnglish
                                              ? vehicle.brand
                                              : vehicle.altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? vehicle.model
                                              : vehicle.altModel,
                                          price: 'KD ${vehicle.price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempLeaseVehicle(
                                                    VehicleModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.altModel,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              feature: vehicle.feature,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                              mileage: vehicle.mileage,
                                              status: vehicle.status,
                                            ));
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempLeaseVehicleDetail(
                                                    VehicleDetailModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.altModel,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              feature: vehicle.feature,
                                              mileage: vehicle.mileage,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                              status: vehicle.status,
                                            ));
                                            Navigator.of(context).pushNamed(
                                                LeaseVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      for (VehicleModel vehicle in _appProvider
                                          .getMostSearchedUsedVehicleList())
                                        HomeVehicleNormalTile(
                                          imageUrl: vehicle.imageName,
                                          name: _appProvider.getIsEnglish
                                              ? vehicle.carName
                                              : vehicle.altCarName,
                                          year: vehicle.year,
                                          brand: _appProvider.getIsEnglish
                                              ? vehicle.brand
                                              : vehicle.altBrand,
                                          model: _appProvider.getIsEnglish
                                              ? vehicle.model
                                              : vehicle.altModel,
                                          price: 'KD ${vehicle.price}',
                                          onPressed: () {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempUsedVehicle(
                                                    VehicleModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.altModel,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              feature: vehicle.feature,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                              mileage: vehicle.mileage,
                                              status: vehicle.status,
                                            ));
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .setTempUsedVehicleDetail(
                                                    VehicleDetailModel(
                                              id: vehicle.id,
                                              brand: _appProvider.getIsEnglish
                                                  ? vehicle.brand
                                                  : vehicle.altBrand,
                                              model: _appProvider.getIsEnglish
                                                  ? vehicle.model
                                                  : vehicle.altModel,
                                              imageName: vehicle.imageName,
                                              carName: _appProvider.getIsEnglish
                                                  ? vehicle.carName
                                                  : vehicle.altCarName,
                                              price: vehicle.price,
                                              year: vehicle.year,
                                              feature: vehicle.feature,
                                              mileage: vehicle.mileage,
                                              createdAt: vehicle.createdAt,
                                              deletedAt: vehicle.deletedAt,
                                              updatedAt: vehicle.updatedAt,
                                              status: vehicle.status,
                                            ));
                                            Navigator.of(context).pushNamed(
                                                UsedVehicleDetailsScreen
                                                    .routeName);
                                          },
                                        )
                                    ],
                                  ),
                          ),
                          Visibility(
                            visible: _appProvider.isLoggedIn &&
                                (currentCarsPage == 0
                                    ? _appProvider
                                        .getMostRecentSearchedLeaseVehicleList()
                                        .isNotEmpty
                                    : _appProvider
                                        .getMostRecentSearchedUsedVehicleList()
                                        .isNotEmpty),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16),
                              child: Text(
                                '${AppLocalizations.of(context).mostRecentSearches}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _appProvider.isLoggedIn,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: currentCarsPage == 0
                                  ? Row(
                                      children: [
                                        for (VehicleModel vehicle in _appProvider
                                            .getMostRecentSearchedLeaseVehicleList())
                                          HomeVehicleNormalTile(
                                            imageUrl: vehicle.imageName,
                                            name: _appProvider.getIsEnglish
                                                ? vehicle.carName
                                                : vehicle.altCarName,
                                            year: vehicle.year,
                                            brand: _appProvider.getIsEnglish
                                                ? vehicle.brand
                                                : vehicle.altBrand,
                                            model: _appProvider.getIsEnglish
                                                ? vehicle.model
                                                : vehicle.altModel,
                                            price: 'KD ${vehicle.price}',
                                            onPressed: () {
                                              Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .setTempLeaseVehicle(
                                                      VehicleModel(
                                                id: vehicle.id,
                                                brand: _appProvider.getIsEnglish
                                                    ? vehicle.brand
                                                    : vehicle.altBrand,
                                                model: _appProvider.getIsEnglish
                                                    ? vehicle.model
                                                    : vehicle.altModel,
                                                imageName: vehicle.imageName,
                                                carName:
                                                    _appProvider.getIsEnglish
                                                        ? vehicle.carName
                                                        : vehicle.altCarName,
                                                price: vehicle.price,
                                                year: vehicle.year,
                                                feature: vehicle.feature,
                                                createdAt: vehicle.createdAt,
                                                deletedAt: vehicle.deletedAt,
                                                updatedAt: vehicle.updatedAt,
                                                mileage: vehicle.mileage,
                                                status: vehicle.status,
                                              ));
                                              Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .setTempLeaseVehicleDetail(
                                                      VehicleDetailModel(
                                                id: vehicle.id,
                                                brand: _appProvider.getIsEnglish
                                                    ? vehicle.brand
                                                    : vehicle.altBrand,
                                                model: _appProvider.getIsEnglish
                                                    ? vehicle.model
                                                    : vehicle.altModel,
                                                imageName: vehicle.imageName,
                                                carName:
                                                    _appProvider.getIsEnglish
                                                        ? vehicle.carName
                                                        : vehicle.altCarName,
                                                price: vehicle.price,
                                                year: vehicle.year,
                                                feature: vehicle.feature,
                                                mileage: vehicle.mileage,
                                                createdAt: vehicle.createdAt,
                                                deletedAt: vehicle.deletedAt,
                                                updatedAt: vehicle.updatedAt,
                                                status: vehicle.status,
                                              ));
                                              Navigator.of(context).pushNamed(
                                                  LeaseVehicleDetailsScreen
                                                      .routeName);
                                            },
                                          )
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        for (VehicleModel vehicle in _appProvider
                                            .getMostRecentSearchedUsedVehicleList())
                                          HomeVehicleNormalTile(
                                            imageUrl: vehicle.imageName,
                                            name: _appProvider.getIsEnglish
                                                ? vehicle.carName
                                                : vehicle.altCarName,
                                            year: vehicle.year,
                                            brand: _appProvider.getIsEnglish
                                                ? vehicle.brand
                                                : vehicle.altBrand,
                                            model: _appProvider.getIsEnglish
                                                ? vehicle.model
                                                : vehicle.altModel,
                                            price: 'KD ${vehicle.price}',
                                            onPressed: () {
                                              Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .setTempUsedVehicle(
                                                      VehicleModel(
                                                id: vehicle.id,
                                                brand: _appProvider.getIsEnglish
                                                    ? vehicle.brand
                                                    : vehicle.altBrand,
                                                model: _appProvider.getIsEnglish
                                                    ? vehicle.model
                                                    : vehicle.altModel,
                                                imageName: vehicle.imageName,
                                                carName:
                                                    _appProvider.getIsEnglish
                                                        ? vehicle.carName
                                                        : vehicle.altCarName,
                                                price: vehicle.price,
                                                year: vehicle.year,
                                                feature: vehicle.feature,
                                                createdAt: vehicle.createdAt,
                                                deletedAt: vehicle.deletedAt,
                                                updatedAt: vehicle.updatedAt,
                                                mileage: vehicle.mileage,
                                                status: vehicle.status,
                                              ));
                                              Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .setTempUsedVehicleDetail(
                                                      VehicleDetailModel(
                                                id: vehicle.id,
                                                brand: _appProvider.getIsEnglish
                                                    ? vehicle.brand
                                                    : vehicle.altBrand,
                                                model: _appProvider.getIsEnglish
                                                    ? vehicle.model
                                                    : vehicle.altModel,
                                                imageName: vehicle.imageName,
                                                carName:
                                                    _appProvider.getIsEnglish
                                                        ? vehicle.carName
                                                        : vehicle.altCarName,
                                                price: vehicle.price,
                                                year: vehicle.year,
                                                feature: vehicle.feature,
                                                mileage: vehicle.mileage,
                                                createdAt: vehicle.createdAt,
                                                deletedAt: vehicle.deletedAt,
                                                updatedAt: vehicle.updatedAt,
                                                status: vehicle.status,
                                              ));
                                              Navigator.of(context).pushNamed(
                                                  UsedVehicleDetailsScreen
                                                      .routeName);
                                            },
                                          )
                                      ],
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                            child: Text(
                              '${AppLocalizations.of(context).myNotifications}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                for (NotificationModel notification
                                    in _appProvider.getHomeNotificationList())
                                  HomeNotificationTile(
                                    onPressed: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .setTempNotificationId(
                                              notification.id);
                                      Navigator.of(context).pushNamed(
                                          NotificationDetailsScreen.routeName);
                                    },
                                    title: '${notification.title}',
                                    time: '${notification.timeDiff}',
                                    imageUrl: '${notification.imageUrl}',
                                    details: '${notification.description}',
                                  ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(NotificationsScreen.routeName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  child: Text(
                                    '${AppLocalizations.of(context).viewMore}',
                                    style: TextStyle(
                                        color: Color(0xFF535353),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFCCCCCC),
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
