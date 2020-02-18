import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:io';

import 'api.dart';


class FirebaseNotifications {
  int userId;
  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase(int userId) {
    this.userId = userId;
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessagingListeners();

  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(">>>>>>>>>firebase messaging token");
      print(token);
      APIService.updateUserFirebaseToken(userId, token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}