import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/vehicle_full_width_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class UsedVehicleSearchScreen extends StatefulWidget {
  static final String routeName = '/used-search-vehicle';

  @override
  _UsedVehicleSearchScreenState createState() =>
      _UsedVehicleSearchScreenState();
}

class _UsedVehicleSearchScreenState extends State<UsedVehicleSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Container(
            child: TextFormField(
              style: TextStyle(color: Color(0xFF212121), fontSize: 14),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                hintText: 'Search Used Vehicles',
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
                        color: Theme.of(context).primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }
}
