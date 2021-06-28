import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeRequestTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imageUrl;
  final Function() onPressed;

  HomeRequestTile({this.onPressed, this.imageUrl, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.444444,
            height: MediaQuery.of(context).size.width * 0.444444 * 0.5,
            child: Stack(
              children: [
                Positioned.fill(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            color: Colors.black,
                            child: Image.asset('$imageUrl', fit: BoxFit.fitWidth, alignment: Alignment.center,),))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$title',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
