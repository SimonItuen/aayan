import 'package:Aayan/screens/compare/CompareDetailsScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CompareScreen extends StatefulWidget {
  static final String routeName = '/compare';

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Compare',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: AppTransparentButton(
                isExpanded: false,
                child: Text(
                  'Reset',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 24, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CompareVehicleTile(
              imageUrl: 'assets/images/dummy/car-4.png',
              name: 'Mercedes-Benz A-Class',
              year: '2021',
              brand: 'Mercedes',
              model: 'Benz A-Class',
              price: 'KD 5000',
            ),
            CompareVehicleTile(
              imageUrl: 'assets/images/dummy/car-3.png',
              name: 'Mercedes-Benz A-Class',
              year: '2021',
              brand: 'Mercedes',
              model: 'Benz A-Class',
              price: 'KD 5000',
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9111111) - 32,
              height: MediaQuery.of(context).size.width * 0.9111111 * 0.341463,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0XFFEEEEEE))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add_circle_rounded, color: Color(0xFF9E9E9E),), Text('ADD CAR', style: TextStyle(color: Color(0xFF9E9E9E), fontWeight: FontWeight.w400, fontSize: 12),)],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 0, right: 8, left: 8),
              child: AppFilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CompareDetailsScreen.routeName);
                },
                child: Text(
                  'Compare',
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
