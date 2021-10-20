import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeOwnedVehicleTile extends StatelessWidget {
  final String name;
  final String year;
  final String brand;
  final String model;
  final String price;
  final String imageUrl;
  final Function() onPressed;

  HomeOwnedVehicleTile(
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
              width: MediaQuery.of(context).size.width * 0.8194444,
              height: MediaQuery.of(context).size.width * 0.819444 * 0.50169,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                children: [
                  Container(
                    width:
                        MediaQuery.of(context).size.width * 0.8194444 * 0.33898,
                    margin: EdgeInsets.only(right:8, left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imageUrl.startsWith('http')?CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, downloadProgress) {
                            return SpinKitDoubleBounce(
                              size: 16,
                              color: Theme.of(context).primaryColor.withOpacity(0.6),
                            );
                          },
                          imageUrl: '$imageUrl',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ):Image.asset('assets/images/default_car_image.png'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Color(0xFFB21F28),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.warning_amber_rounded, color:Colors.white ,),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.credit_card, color:Colors.white ,),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
                        Text(
                          '$model',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF535353)),
                        ),
                        Text(
                          '$price',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFFB21F28)),
                        ),
                        Text(
                          'Remaining Amount',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF9E9E9E)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
