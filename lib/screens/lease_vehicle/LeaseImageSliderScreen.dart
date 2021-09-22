import 'package:Aayan/models/VehicleDetailModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LeaseImageSliderScreen extends StatefulWidget {
  static final String routeName = '/lease_image_slider';
  const LeaseImageSliderScreen({Key key}) : super(key: key);

  @override
  _LeaseImageSliderScreenState createState() => _LeaseImageSliderScreenState();
}

class _LeaseImageSliderScreenState extends State<LeaseImageSliderScreen> {
  PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController= PageController(initialPage: Provider.of<AppProvider>(context, listen: false).getImagePageControllerIndex);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    VehicleDetailModel vehicleDetails =
    Provider.of<AppProvider>(context, listen: true)
        .getTempLeaseVehicleDetail();
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(backgroundColor:Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, size: 28,color: Colors.white,),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          for(int index=0; index<vehicleDetails.imageList.length; index++)
          InteractiveViewer(child: CachedNetworkImage(
            progressIndicatorBuilder:
                (context, url, downloadProgress) {
              return SpinKitFadingCube(
                size: 16,
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(0.6),
              );
            },
            imageUrl:
            '${vehicleDetails.imageList[index]}',
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
          ),),
        ],
      ),
    );
  }
}
