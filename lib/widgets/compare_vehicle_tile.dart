import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class CompareVehicleTile extends StatelessWidget {
  final String name;
  final String year;
  final String brand;
  final String model;
  final String price;
  final String id;
  final String imageUrl;
  final bool isUsed;
  final Function() onRemovePressed;

  CompareVehicleTile(
      {this.onRemovePressed,
      this.name,
      this.year,
      this.brand,
      this.id,
      this.model,
      this.price,
      this.imageUrl,
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
              padding: EdgeInsets.symmetric(vertical: 16.0),
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
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$model',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFF535353)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$brand',
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
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$year',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                Visibility(
                                  visible: !isUsed,
                                  child: Text(
                                    '${AppLocalizations.of(context).perMonth.capitalize()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xFF9E9E9E)),
                                  ),
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
            ),
          ),
          Positioned(
            top: -(MediaQuery.of(context).size.width * 0.083333 * 0.35),
            right: -(MediaQuery.of(context).size.width * 0.083333 * 0.35),
            child: InkWell(
              onTap: onRemovePressed,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.093333,
                height: MediaQuery.of(context).size.width * 0.093333,
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFE00000)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
