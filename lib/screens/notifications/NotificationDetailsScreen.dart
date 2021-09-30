import 'dart:async';

import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareLeaseDetailsScreen.dart';
import 'package:Aayan/screens/lease_vehicle/AddLeaseVehicleScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/compare_vehicle_tile.dart';
import 'package:Aayan/models/NotificationModel.dart';
import 'package:Aayan/widgets/home_notification_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Aayan/extensions/app_extensions.dart';
import 'package:Aayan/services/HttpService.dart';

class NotificationDetailsScreen extends StatefulWidget {
  static final String routeName = '/notification-details';

  @override
  _NotificationDetailsScreenState createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  bool isLoading = true;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
     timer = Timer.periodic(Duration(minutes: 1), (Timer timer) async {
        await HttpService.getHomeNotifications(context);
      });
      isLoading = await HttpService.getNotificationDetails(context,
          notificationId: Provider.of<AppProvider>(context, listen: false)
              .getTempNotificationId);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    NotificationModel notification = _appProvider.getTempNotificationModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${AppLocalizations.of(context).notifications.capitalize()} ${AppLocalizations.of(context).details.capitalize()}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                    visible: notification.imageUrl.toString().startsWith('http'),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return SpinKitDoubleBounce(
                          size: 16,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.6),
                        );
                      },
                      imageUrl: '${notification.imageUrl}',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${notification.title}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        '${notification.timeDiff}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Colors.black),
                      ),
                      Text(
                        '${notification.description}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFF535353)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
