import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
                child: Center(child: Image.asset('$imageUrl')),
              ),
              Expanded(child: Text('$name', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),)),
              Visibility(visible: isChecked,child: Icon(Icons.check_rounded, color: Theme.of(context).primaryColor,))
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
