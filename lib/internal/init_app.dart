import 'package:dd_study_22_ui/data/services/database.dart';
import 'package:dd_study_22_ui/firebase_options.dart';
import 'package:dd_study_22_ui/ui/navigation/app_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dd_study_22_ui/internal/utils.dart';
import 'package:flutter/material.dart';

void showModal(String title, String content) {
  var ctx = AppNavigator.key.currentContext;
  if (ctx != null) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Got it"))
            ],
          );
        });
  }
}

void catchMessage(RemoteMessage message) {
  "Got a message whilst in the foreground!".console;
  "Message data: ${message.data}".console();

  if (message.notification != null) {
    showModal(message.notification!.title!, message.notification!.body!);
  }
}

Future initFireBase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true);

  FirebaseMessaging.onMessage.listen(catchMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(catchMessage);

  try {
    ((await messaging.getToken()) ?? "No token").console();
  } catch (e) {
    e.toString().console();
  }
}

Future initApp() async {
  await initFireBase();
  await DB.instance.init();
}
