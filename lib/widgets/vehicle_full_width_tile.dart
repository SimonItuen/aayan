import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class VehicleFullWidthTile extends StatelessWidget {
  final String name;
  final String year;
  final String brand;
  final String model;
  final String price;
  final String imageUrl;
  final bool isUsed;
  final Function() onPressed;

  VehicleFullWidthTile(
      {this.onPressed,
      this.name,
      this.year,
      this.brand,
      this.model,
      this.price,
      this.imageUrl,
      this.isUsed = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.547222 * 1.1167,
              color: Color(0xFFFCFCFC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Container( color: Colors.white, padding: EdgeInsets.only(top: 16),child: Image.asset('$imageUrl'))),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '$name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Text(
                          '$year',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Color(0xFF9E9E9E)),
                        ),
                        Text(
                          '$brand',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF535353)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$model',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFF535353)),
                            ),
                            isUsed
                                ? Text(
                              '$price',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            )
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '$price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  'per month',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xFF9E9E9E)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

                ],
              ),
            )),
      ),
    );
  }
}
