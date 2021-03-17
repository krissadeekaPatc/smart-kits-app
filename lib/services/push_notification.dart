import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:smartfarm/screen/notifications.dart';
import '../main.dart';

abstract class PushNotifications extends State<MyApp> {
  // final BuildContext context;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  // PushNotifications({this.context});
  // var snackBar = SnackBar(content: ListTile(title: Text("data")));
  void initFirebaseMessaging() {
    firebaseMessaging.configure(
      onMessage: (message) async {
        print(message);
        if (Platform.isIOS) {
          print("onMessage: ${message["notification"]["title"]}");
          showDialog(
            context: context,
            builder: (context) {
              return Card(
                child: Text("${message["notification"]["title"]}"),
              );
            },
          );
          // Get.snackbar("title", "message");
          // showOverlayNotification((context) {
          //   print(context);
          //   return Card(
          //     margin: const EdgeInsets.symmetric(horizontal: 4),
          //     child: SafeArea(
          //       child: ListTile(
          //         leading: SizedBox.fromSize(
          //             size: const Size(40, 40),
          //             child: ClipOval(
          //                 child: Container(
          //               color: Colors.black,
          //             ))),
          //         title: Text("sadasdasda"),
          //         subtitle: Text("asdasdasdas"),
          //         trailing: IconButton(
          //             icon: Icon(Icons.close),
          //             onPressed: () {
          //               OverlaySupportEntry.of(context).dismiss();
          //             }),
          //       ),
          //     ),
          //   );
          // }, duration: Duration(milliseconds: 4000));
        }

        // showSimpleNotification(Text("${message["notification"]["title"]}"));
      },
      onLaunch: (Map<String, dynamic> message) async {
        if (Platform.isIOS) {
          print("onLaunch: ${message["aps"]["alert"]["title"]}");
          Get.to(NotificationList());
        }

        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        if (Platform.isIOS) {
          print("onResume: $message");
        }

        print("onResume: $message");
      },
    );

    firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));

    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Token : $token");
    });
  }
}
