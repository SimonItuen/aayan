import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeNotificationTile extends StatelessWidget {
  final String title;
  final String time;
  final String details;
  final String imageUrl;
  final Function() onPressed;

  HomeNotificationTile(
      {this.onPressed, this.imageUrl, this.title, this.time, this.details});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(visible:imageUrl!=null,child: Image.asset('$imageUrl', fit: BoxFit.fitWidth,)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$title',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Text(
                          '$time',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.black),
                        ),
                        Text(
                          '$details',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF535353)),
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
