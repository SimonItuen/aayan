import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeBrandTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Function() onPressed;

  HomeBrandTile({this.onPressed, this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: EdgeInsets.all(7),
              width: MediaQuery.of(context).size.width * 0.205556,
              height: MediaQuery.of(context).size.width * 0.205556,
              child: Center(child: imageUrl.startsWith('http')?CachedNetworkImage(
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return SpinKitDoubleBounce(
                    size: 16,
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                  );
                },
                imageUrl: '$imageUrl',
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ):Image.asset('assets/images/icon.png',color: Colors.grey,)),
            )),
      ),
    );
  }
}
