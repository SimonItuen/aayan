import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeBrandTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Function() onPressed;

  HomeBrandTile({this.onPressed, this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.205556,
              height: MediaQuery.of(context).size.width * 0.205556,
              child: Center(child: Image.asset('$imageUrl')),
            )),
      ),
    );
  }
}
