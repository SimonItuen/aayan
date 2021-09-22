import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeVehicleNormalTile extends StatelessWidget {
  final String name;
  final String year;
  final String brand;
  final String model;
  final String price;
  final String imageUrl;
  final Function() onPressed;

  HomeVehicleNormalTile(
      {this.onPressed,
      this.name,
      this.year,
      this.brand,
      this.model,
      this.price,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: MediaQuery.of(context).size.width*0.547222,
              height: MediaQuery.of(context).size.width*0.547222 *1.1167,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: imageUrl.startsWith('http')?CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return SpinKitDoubleBounce(
                        size: 16,
                        color: Theme.of(context).primaryColor.withOpacity(0.6),
                      );
                    },
                    imageUrl: '$imageUrl',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ):Image.asset('assets/images/default_car_image.png')),
                  Text(
                    '$name',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
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
                            fontSize: 12,
                            color: Color(0xFF535353)),
                      ),
                      Text(
                        '$price',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
