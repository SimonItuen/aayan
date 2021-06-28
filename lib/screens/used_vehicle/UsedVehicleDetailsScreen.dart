import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/home_vehicle_normal_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsedVehicleDetailsScreen extends StatefulWidget {
  static final String routeName = '/used-vehicle-details';

  @override
  _UsedVehicleDetailsScreenState createState() =>
      _UsedVehicleDetailsScreenState();
}

class _UsedVehicleDetailsScreenState extends State<UsedVehicleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Mercedes Benz A-Class 2021',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 32, bottom: 96, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                InkWell(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                      child: Icon(Icons.arrow_back_ios_rounded),
                    ),
                    onTap: () {}),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Image.asset('assets/images/dummy/car-6.png')),
                ),
                InkWell(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 8, bottom: 8),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    onTap: () {}),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                'Details',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9111111) - 32,
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
                          'Brand',
                          style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Text(
                          'Mercedes',
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
                          'Model',
                          style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Text(
                          'Benz A-Class',
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
                          'Year',
                          style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Text(
                          '2021',
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
            Padding(padding: EdgeInsets.all(4)),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                'Features',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9111111) - 32,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0XFFEEEEEE))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• 43.2 Cm (17-Inch) 5-Twin-Spoke\n\nLight-Alloy Wheels\n\n• 4-Way Lumbar Support\n\n• 7G-DCT\n\n• Active Brake Assist\n\n• Active Parking Assist With PARKTRONIC\n\n- All-Digital Instrument Display',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                'Similar Vehicles',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 0),
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
                    imageUrl: 'assets/images/dummy/car-1.png',
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
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                'Compare Vehicle',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
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
                          child: Image.asset('assets/images/dummy/car-6.png'),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(2)),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.width *
                            0.9111111 *
                            0.341463,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_rounded,
                              color: Color(0xFF9E9E9E),
                            ),
                            Text(
                              'ADD CAR',
                              style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            )
                          ],
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
                      'VS',
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
                                    fontWeight:
                                    FontWeight.w400,
                                )),
                            TextSpan(
                                text: '5000',
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,)),
                            TextSpan(
                                text: '.000',
                                style: TextStyle(
                                  fontSize: 12,
                                    fontWeight:
                                    FontWeight.bold,)),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AppFilledButton(
                onPressed: () {},
                isExpanded: false,
                child: Text(
                  'Check and Purchase',
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
    );
  }
}
