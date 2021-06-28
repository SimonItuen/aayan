import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CompareDetailsScreen extends StatefulWidget {
  static final String routeName = '/CompareDetails';

  @override
  _CompareDetailsScreenState createState() => _CompareDetailsScreenState();
}

class _CompareDetailsScreenState extends State<CompareDetailsScreen> {
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
                onPressed: (){
                  Navigator.of(context).pop();
                },
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
            Container(
              height: MediaQuery.of(context).size.width * 0.455556 * 1.07926,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1))),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: Icon(
                                  Icons.edit_rounded,
                                  color: Color(0xFF535353),
                                  size: 24,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })),
                        Container(
                            margin: EdgeInsets.only(right: 16),
                            child:
                                Image.asset('assets/images/dummy/car-3.png')),
                        Spacer(),
                        Padding(
                          padding:  EdgeInsets.only(bottom:8.0, right: 4, left: 4),
                          child: Text(
                            'Mercedes-Benz A-Class',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: Icon(
                                  Icons.edit_rounded,
                                  color: Color(0xFF535353),
                                  size: 24,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })),
                        Container(
                            margin: EdgeInsets.only(right: 16),
                            child:
                            Image.asset('assets/images/dummy/car-4.png')),
                        Spacer(),
                        Padding(
                          padding:EdgeInsets.only(bottom:8.0, left: 4, right: 4),
                          child: Text(
                            'Mercedes-Benz A-Class',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:4.0),
                  child: Text('Brand', style: TextStyle(fontSize: 14, color: Color(0xFF535353), fontWeight: FontWeight.w400),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Volkswagen', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
                    Text('Lexus', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFEEEEEE),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:4.0),
                  child: Text('Model', style: TextStyle(fontSize: 14, color: Color(0xFF535353), fontWeight: FontWeight.w400),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Arteon', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
                    Text('RC', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFEEEEEE),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:4.0),
                  child: Text('Year', style: TextStyle(fontSize: 14, color: Color(0xFF535353), fontWeight: FontWeight.w400),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('2021', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
                    Text('2020', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFEEEEEE),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
