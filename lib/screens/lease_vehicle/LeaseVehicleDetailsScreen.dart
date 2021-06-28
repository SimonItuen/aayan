import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/home_vehicle_normal_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaseVehicleDetailsScreen extends StatefulWidget {
  static final String routeName = '/lease-vehicle-details';

  @override
  _LeaseVehicleDetailsScreenState createState() =>
      _LeaseVehicleDetailsScreenState();
}

class _LeaseVehicleDetailsScreenState extends State<LeaseVehicleDetailsScreen> {
  List<int> selectedCars = [];
  int groupValue = 0;
  int valueValue = 0;
  int valuePlusValue = 0;

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
        padding: EdgeInsets.only(top: 32, bottom: 64, left: 16, right: 16),
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
              width: (MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111) - 32,
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                'Packages',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            Container(
              width: (MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111) - 32,
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111 * 0.25,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0XFFEEEEEE))),
              child: Row(
                children: [
                  Radio(
                      value: 0,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      }),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  Padding(padding: EdgeInsets.only(right: 16)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duration',
                        style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        '12 months',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mileage',
                        style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        '6000km',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Installment',
                        style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        'KD 500.00',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(4)),
            Container(
              width: (MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111) - 32,
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111 * 0.25,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0XFFEEEEEE))),
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      }),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  Padding(padding: EdgeInsets.only(right: 16)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duration',
                        style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        '12 months',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mileage',
                        style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        '6000km',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Installment',
                        style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        'KD 500.00',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                'Addons',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            Container(
              width: (MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111) - 32,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0XFFEEEEEE))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Value',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'KD 50.00',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                              value: 1,
                              groupValue: valueValue,
                              onChanged: (value) {
                                setState(() {
                                  valueValue = value;
                                });
                              }),
                          VerticalDivider(
                            width: 1,
                            thickness: 1,
                            color: Color(0xFFEEEEEE),
                          ),
                          Padding(padding: EdgeInsets.only(right: 16)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\u2022 Free Servicing',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Text(
                                '\u2022 Emergency Requests',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Text(
                                '\u2022 Door to Door Services',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
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
              width: (MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111) - 32,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0XFFEEEEEE))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Color(0xFFB21F28),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Value Plus',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'KD 50.00',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                              value: 1,
                              groupValue: valuePlusValue,
                              onChanged: (value) {
                                setState(() {
                                  valuePlusValue = value;
                                });
                              }),
                          VerticalDivider(
                            width: 1,
                            thickness: 1,
                            color: Color(0xFFEEEEEE),
                          ),
                          Padding(padding: EdgeInsets.only(right: 16)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\u2022 Free Servicing',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Text(
                                '\u2022 Emergency Requests',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Text(
                                '\u2022 Door to Door Services',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Text(
                                '\u2022 Subsidiary Vehicle',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Text(
                'Features',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            Container(
              width: (MediaQuery
                  .of(context)
                  .size
                  .width * 0.9111111) - 32,
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
                        height: MediaQuery
                            .of(context)
                            .size
                            .width *
                            0.9111111 *
                            0.341463,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child:Image.asset('assets/images/dummy/car-6.png'),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(2)),
                    Expanded(
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .width *
                            0.9111111 *
                            0.341463,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),),
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
                  width: MediaQuery.of(context).size.width *0.06667,
                  height: MediaQuery.of(context).size.width *0.06667,
                  child: Center(
                    child: Text(
                      'VS',style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800
                      ),

                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppFilledButton(
        onPressed: () {

        },
        child: Text(
          'Request',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
