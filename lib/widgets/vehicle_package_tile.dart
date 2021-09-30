import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';

class VehiclePackageModelTile extends StatelessWidget {
  final String duration;
  final String mileage;
  final String installment;
  final int value;
  final bool isSelected;
  final Function() onPressed;

  VehiclePackageModelTile({
    this.duration,
    this.mileage,
    this.installment,
    this.value,
    this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: (MediaQuery.of(context).size.width * 0.9111111) - 32,
        height: MediaQuery.of(context).size.width * 0.9111111 * 0.25,
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0XFFEEEEEE))),
        child: Row(
          children: [
            Radio(
              value: isSelected ? value : -1,
              groupValue: value,
              toggleable: true,
              onChanged: (value){
                onPressed();
              },
            ),
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
                  '${AppLocalizations.of(context).duration.capitalize()}',
                  style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  '$duration ${AppLocalizations.of(context).months}',
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
                  '${AppLocalizations.of(context).mileage.capitalize()}',
                  style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  '$mileage ${AppLocalizations.of(context).km}',
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
                  '${AppLocalizations.of(context).installment.capitalize()}',
                  style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  'KD $installment.00',
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
    );
  }
}
