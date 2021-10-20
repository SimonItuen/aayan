import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class MyVehicleTile extends StatelessWidget {
  final String name;
  final String year;
  final String brand;
  final String model;
  final String price;
  final String id;
  final String imageUrl;
  final bool isUsed;
  final String status;

  MyVehicleTile(
      {this.name,
      this.year,
      this.brand,
      this.id,
      this.model,
      this.price,
      this.imageUrl,
      this.status,
      this.isUsed = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.9111111) - 32,
      height: MediaQuery.of(context).size.width * 0.9111111 * 0.341463,
      margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0XFFEEEEEE))),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width *
                          0.9111111 *
                          0.292682,
                      height: MediaQuery.of(context).size.width *
                          0.9111111 *
                          0.292682,
                      margin: EdgeInsets.only(right: 16),
                      child: imageUrl.startsWith('http')
                          ? CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                return SpinKitDoubleBounce(
                                  size: 16,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.6),
                                );
                              },
                              imageUrl: '$imageUrl',
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            )
                          : Image.asset('assets/images/default_car_image.png')),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1),
                        ),
                        Text(
                          '$model',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF535353)),
                        ),
                        Text(
                          '$brand ($year)',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF535353)),
                        ),
                        Spacer(),
                        !isUsed?Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF0A905D),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Colors.white),
                          ),
                        ):Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEDD16),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Pending Admin Approval',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Color(0xFF212121)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
