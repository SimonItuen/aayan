import 'package:Aayan/screens/compare/CompareScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleDetailsScreen.dart';
import 'package:Aayan/screens/used_vehicle/UsedVehicleSearchScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/filter_brand_tile.dart';
import 'package:Aayan/widgets/vehicle_full_width_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class UsedVehicleScreen extends StatefulWidget {
  static final String routeName = '/used-vehicle';

  @override
  _UsedVehicleScreenState createState() => _UsedVehicleScreenState();
}

class _UsedVehicleScreenState extends State<UsedVehicleScreen> {
  List<int> selectedCars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Used Vehicle',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.compare_arrows_rounded,size: 28,),
              onPressed: () {
                Navigator.of(context).pushNamed(CompareScreen.routeName);
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(UsedVehicleSearchScreen.routeName);
              }),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 64),
              children: [
                VehicleFullWidthTile(
                  imageUrl: 'assets/images/dummy/car-3.png',
                  name: 'Mercedes-Benz A-Class',
                  year: '2021',
                  brand: 'Mercedes',
                  model: 'Benz A-Class',
                  price: 'KD 5000',
                  isUsed: true,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(UsedVehicleDetailsScreen.routeName);
                  },
                ),
                VehicleFullWidthTile(
                  imageUrl: 'assets/images/dummy/car-1.png',
                  name: 'Mercedes-Benz A-Class',
                  year: '2021',
                  brand: 'Mercedes',
                  model: 'Benz A-Class',
                  price: 'KD 5000',
                  isUsed: true,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(UsedVehicleDetailsScreen.routeName);
                  },
                ),
                VehicleFullWidthTile(
                  imageUrl: 'assets/images/dummy/car-2.png',
                  name: 'Mercedes-Benz A-Class',
                  year: '2021',
                  brand: 'Mercedes',
                  model: 'Benz A-Class',
                  price: 'KD 5000',
                  isUsed: true,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(UsedVehicleScreen.routeName);
                  },
                ),
                VehicleFullWidthTile(
                  imageUrl: 'assets/images/dummy/car-4.png',
                  name: 'Mercedes-Benz A-Class',
                  year: '2021',
                  brand: 'Mercedes',
                  model: 'Benz A-Class',
                  price: 'KD 5000',
                  isUsed: true,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(UsedVehicleDetailsScreen.routeName);
                  },
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showFilterSheet();
        },
        label: Text('Filter'),
        icon: Icon(Icons.filter_list),
      ),
    );
  }

  void _showFilterSheet() async {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.only(
                    top: 24,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    right: 16,
                    left: 16),
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: MediaQuery.of(context).size.height * 0.575,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 3,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FilterBrandTile(
                              imageUrl: 'assets/images/dummy/toyota.png',
                              name: 'Toyota',
                              isChecked: selectedCars.contains(0),
                              onPressed: selectedCars.contains(0)
                                  ? () {
                                      selectedCars.remove(0);
                                      setState(() {});
                                    }
                                  : () {
                                      selectedCars.add(0);
                                      setState(() {});
                                    },
                            ),
                            FilterBrandTile(
                              imageUrl: 'assets/images/dummy/jeep.png',
                              name: 'Jeep',
                              isChecked: selectedCars.contains(1),
                              onPressed: selectedCars.contains(1)
                                  ? () {
                                      selectedCars.remove(1);
                                      setState(() {});
                                    }
                                  : () {
                                      selectedCars.add(1);
                                      setState(() {});
                                    },
                            ),
                            FilterBrandTile(
                              imageUrl: 'assets/images/dummy/gmc.png',
                              name: 'GMC',
                              isChecked: selectedCars.contains(2),
                              onPressed: selectedCars.contains(2)
                                  ? () {
                                      selectedCars.remove(2);
                                      setState(() {});
                                    }
                                  : () {
                                      selectedCars.add(2);
                                      setState(() {});
                                    },
                            ),
                            FilterBrandTile(
                              imageUrl: 'assets/images/dummy/dodge.png',
                              name: "Dodge",
                              isChecked: selectedCars.contains(3),
                              onPressed: selectedCars.contains(3)
                                  ? () {
                                      selectedCars.remove(3);
                                      setState(() {});
                                    }
                                  : () {
                                      selectedCars.add(3);
                                      setState(() {});
                                    },
                            ),
                            FilterBrandTile(
                              imageUrl: 'assets/images/dummy/chevrolet.png',
                              name: 'Chevrolet',
                              isChecked: selectedCars.contains(4),
                              onPressed: selectedCars.contains(4)
                                  ? () {
                                      selectedCars.remove(4);
                                      setState(() {});
                                    }
                                  : () {
                                      selectedCars.add(4);
                                      setState(() {});
                                    },
                            ),
                            FilterBrandTile(
                              imageUrl: 'assets/images/dummy/ford.png',
                              name: 'Ford',
                              isChecked: selectedCars.contains(5),
                              onPressed: selectedCars.contains(5)
                                  ? () {
                                      selectedCars.remove(5);
                                      setState(() {});
                                    }
                                  : () {
                                      selectedCars.add(5);
                                      setState(() {});
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTransparentButton(
                              onPressed: () {
                                selectedCars.clear();
                                setState(() {});
                              },
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            child: AppFilledButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              fillColor: Theme.of(context).primaryColor,
                              child: Text(
                                'Filter',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
