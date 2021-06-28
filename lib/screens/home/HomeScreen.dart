import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/home_brand_tile.dart';
import 'package:Aayan/widgets/home_notification_tile.dart';
import 'package:Aayan/widgets/home_owned_vehicle_tile.dart';
import 'package:Aayan/widgets/home_request_tile.dart';
import 'package:Aayan/widgets/home_slide_tile.dart';
import 'package:Aayan/widgets/home_vehicle_normal_tile.dart';
import 'package:Aayan/widgets/sliding_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  int currentCarsPage = 0;
  List<String> dummyBillboards = [
    'assets/images/dummy/billboard_1.png',
    'assets/images/dummy/billboard_2.png',
    'assets/images/dummy/billboard_1.png',
    'assets/images/dummy/billboard_2.png',
    'assets/images/dummy/billboard_1.png'
  ];

  void onPageChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                  onPageChanged: onPageChange,
                  itemCount: dummyBillboards.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      dummyBillboards[index],
                      fit: BoxFit.fitWidth,
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
                        for (int i = 0; i < dummyBillboards.length; i++)
                          SlidingTile(
                            isActive: i == currentIndex,
                          )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _appProvider.isLoggedIn,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16),
                          child: Text(
                            'Owned Vehicles',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              HomeOwnedVehicleTile(
                                imageUrl: 'assets/images/dummy/car-6.png',
                                name: 'Mercedes-Benz A-Class',
                                year: '2021',
                                brand: 'Mercedes',
                                model: 'Benz A-Class',
                                price: 'KD 5000',
                              ),
                              HomeOwnedVehicleTile(
                                imageUrl: 'assets/images/dummy/car-6.png',
                                name: 'Mercedes-Benz A-Class',
                                year: '2021',
                                brand: 'Mercedes',
                                model: 'Benz A-Class',
                                price: 'KD 5000',
                              ),
                              HomeOwnedVehicleTile(
                                imageUrl: 'assets/images/dummy/car-6.png',
                                name: 'Mercedes-Benz A-Class',
                                year: '2021',
                                brand: 'Mercedes',
                                model: 'Benz A-Class',
                                price: 'KD 5000',
                              ),
                              HomeOwnedVehicleTile(
                                imageUrl: 'assets/images/dummy/car-6.png',
                                name: 'Mercedes-Benz A-Class',
                                year: '2021',
                                brand: 'Mercedes',
                                model: 'Benz A-Class',
                                price: 'KD 5000',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeRequestTile(
                                icon: Icons.warning_amber_rounded,
                                imageUrl:
                                    'assets/images/emergency_backdrop.png',
                                title: 'Emergency Request',
                              ),
                              HomeRequestTile(
                                icon: Icons.build_rounded,
                                imageUrl:
                                    'assets/images/servicing_backdrop.png',
                                title: 'Servicing Request',
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    width: MediaQuery.of(context).size.width * 0.9111,
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Expanded(
                            child: HomeSlideTile(
                          text: 'Lease Cars',
                          isActive: currentCarsPage == 0,
                          onPressed: () {
                            setState(() {
                              currentCarsPage = 0;
                            });
                          },
                        )),
                        Expanded(
                            child: HomeSlideTile(
                          text: 'Used Cars',
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
                    child: Text(
                      'Featured',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-1.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-2.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-3.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-4.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentCarsPage == 0
                              ? 'Get A Lease Car'
                              : 'Buy A Used Vehicle',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                            onTap: currentCarsPage == 0
                                ? () {
                                    Navigator.of(context).pushNamed(
                                        LeaseVehicleScreen.routeName);
                                  }
                                : () {
                                    Navigator.of(context)
                                        .pushNamed(UsedVehicleScreen.routeName);
                                  },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 3, bottom: 3, left: 3),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 18,
                              ),
                            ))
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-3.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-4.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-1.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-2.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    child: Text(
                      'Top Brands',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/toyota.png',
                        ),
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/jeep.png',
                        ),
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/gmc.png',
                        ),
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/dodge.png',
                        ),
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/chevrolet.png',
                        ),
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/ford.png',
                        ),
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/volkswagen.png',
                        ),
                        HomeBrandTile(
                          imageUrl: 'assets/images/dummy/chrysler.png',
                        ),
                      ],
                    ),
                  ),
                  Padding(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BOOK ON YOUR CONVENIENCE',
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
                                          (MediaQuery.of(context).size.width *
                                              0.24166)),
                                  child: AppFilledButton(
                                    isExpanded: false,
                                    child: Container(
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.white,
                                            ),
                                            Padding(padding: EdgeInsets.all(4)),
                                            Text(
                                              'BOOK APPOINTMENT',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    child: Text(
                      'Most searched Vehicles',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-1.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-2.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-3.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-4.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    child: Text(
                      'Most Recent searches',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-3.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-4.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-1.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                        HomeVehicleNormalTile(
                          imageUrl: 'assets/images/dummy/car-2.png',
                          name: 'Mercedes-Benz A-Class',
                          year: '2021',
                          brand: 'Mercedes',
                          model: 'Benz A-Class',
                          price: 'KD 5000',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    child: Text(
                      'My Notifications',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HomeNotificationTile(
                          title: 'Processing Fees',
                          time: '10 mins ago',
                          imageUrl: 'assets/images/dummy/car-5.png',
                          details: 'Your contract has been approved by admin.',
                        ),
                        HomeNotificationTile(
                          title: 'Processing Fees',
                          time: '24/02/2020 11:00 PM',
                          details: 'Your contract has been approved by admin.',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        child: Text(
                          'View More',
                          style: TextStyle(
                              color: Color(0xFF535353),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                            color: Color(0xFFCCCCCC),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
