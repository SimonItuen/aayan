import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FilterBrandTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isChecked;
  final Function() onPressed;

  FilterBrandTile({this.onPressed, this.name, this.imageUrl, this.isChecked});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.13611,
                height: MediaQuery.of(context).size.width * 0.13611,
                padding: EdgeInsets.all(4),
                child: Center(
                    child: imageUrl.startsWith('http')
                        ? CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return SpinKitFadingCube(
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
                        : Image.asset('assets/images/icon.png',color: Colors.grey,)),
              ),
              Expanded(
                  child: Text(
                '$name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )),
              Visibility(
                  visible: isChecked,
                  child: Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).primaryColor,
                  )),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 16,
              )
            ],
          ),
          Divider(
            color: Color(0xFFEEEEEE),
          )
        ],
      ),
    );
  }
}
