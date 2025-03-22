import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lenore/core/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        int? orderId;
        String? type = 'general';
        String? body;

        if (notificationResponse.payload!.isNotEmpty) {
          final payloadData = jsonDecode(notificationResponse.payload!);
          orderId = int.tryParse(payloadData['order_id']);
          type = payloadData['type'];
          body = payloadData['body'];

          // Check if body contains "delivered" and then show rating dialog
          if (orderId != null &&
              body != null &&
              body.toLowerCase().contains('delivered')) {
            //  showRatingDialog(orderId.toString());
            return;
          }
        }

        try {
          if (orderId != null) {
            // Navigator.push(
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           OrderDetailsScreen(orderModel: null, orderId: orderId)),
            // );
          } else if (orderId == null && type == 'message') {
            // Get.navigator!.push(
            //   MaterialPageRoute(
            //       builder: (context) => const ChatScreen(
            //             orderModel: null,
            //             isAppBar: true,
            //           )),
            // );
          } else if (type == 'wallet') {
            // Get.navigator!.push(
            //   MaterialPageRoute(
            //       builder: (context) => const WalletScreen(status: '')),
            // );
          } else if (type == 'general') {
            // Get.navigator!.push(
            //   MaterialPageRoute(
            //       builder: (context) => const NotificationScreen()),
            // );
          }
        } catch (e) {
          return;
        }
        return;
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(
            "onMessage: ${message.notification?.title}/${message.notification?.body}");
      }

      // Check for "delivered" in notification body
      String? body = message.notification?.body ?? message.data['body'];
      if (message.data['order_id'] != null &&
          body != null &&
          body.toLowerCase().contains('delivered')) {
        //  showRatingDialog(message.data['order_id']);
      } else {
        showNotification(message, flutterLocalNotificationsPlugin, kIsWeb);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(
            "onOpenApp: ${message.notification?.title}/${message.notification?.body}");
      }
      handleNotificationNavigation(message);
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        handleNotificationNavigation(message);
      }
    });
  }

  static void handleNotificationNavigation(RemoteMessage message) {
    try {
      String? type = message.data['type'] ?? 'general';
      String? orderId = message.data['order_id'];
      String? body = message.notification?.body ?? message.data['body'];

      // Check for "delivered" in notification body
      // if (orderId != null &&
      //     body != null &&
      //     body.toLowerCase().contains('delivered')) {
      //   showRatingDialog(orderId);
      //   return;
      // }

      if (orderId != null) {
        // Get.navigator!.push(
        //   MaterialPageRoute(
        //     builder: (context) => OrderDetailsScreen(
        //       orderModel: null,
        //       orderId: int.parse(orderId),
        //     ),
        //   ),
        // );
      } else if (type == 'message') {
        // Get.navigator!.push(
        //   MaterialPageRoute(
        //     builder: (context) => const ChatScreen(
        //       orderModel: null,
        //       isAppBar: true,
        //     ),
        //   ),
        // );
      } else if (type == 'wallet') {
        // Get.navigator!.push(
        //   MaterialPageRoute(
        //     builder: (context) => const WalletScreen(status: ''),
        //   ),
        // );
      } else if (type == 'general') {
        // Get.navigator!.push(
        //   MaterialPageRoute(
        //     builder: (context) => const NotificationScreen(),
        //   ),
        // );
      }
    } catch (e) {
      print('Error in navigation: $e');
    }
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin? fln, bool data) async {
    String? title;
    String? body;
    String? orderID;
    String? image;
    String? type;

    if (message.notification != null) {
      title = message.notification!.title;
      body = message.notification!.body;
      orderID = message.notification!.titleLocKey;
    } else {
      title = message.data['title'];
      body = message.data['body'];
      orderID = message.data['order_id'];
    }

    if (message.data['image'] != null) {
      image = message.data['image'];
    } else if (message.notification?.android?.imageUrl != null) {
      image = message.notification?.android?.imageUrl;
    }

    if (image != null && image.isNotEmpty) {
      if (!image.startsWith('http')) {
        image = '${baseUrl}/storage/app/public/notification/$image';
      }
    }

    type = message.data['type'];

    Map<String, String> payloadData = {
      'title': '$title',
      'body': '$body',
      'order_id': '$orderID',
      'image': '$image',
      'type': '$type',
    };

    if (kIsWeb) {
      // showDialog(
      //   context: Get.context!,
      //   builder: (context) => Center(
      //     child: NotificationDialogWebWidget(
      //       orderId: int.tryParse(orderID ?? ''),
      //       title: title,
      //       body: body,
      //       image: image,
      //       type: type,
      //     ),
      //   ),
      // );
    } else if (image != null && image.isNotEmpty) {
      try {
        await showBigPictureNotificationHiddenLargeIcon(payloadData, fln!);
      } catch (e) {
        if (kDebugMode) {
          print('Error showing image notification: $e');
        }
        await showBigTextNotification(payloadData, fln!);
      }
    } else {
      await showBigTextNotification(payloadData, fln!);
    }
  }

  static Future<void> showBigTextNotification(
      Map<String, String> data, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      data['body']!,
      htmlFormatBigText: true,
      contentTitle: data['title'],
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "Lenore Jewellery",
      "Lenore Jewellery",
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      // Remove this line or replace with default sound
      // sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, data['title'], data['body'], platformChannelSpecifics,
        payload: jsonEncode(data));
  }
  // static Future<void> showBigTextNotification(
  //     Map<String, String> data, FlutterLocalNotificationsPlugin fln) async {
  //   BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
  //     data['body']!,
  //     htmlFormatBigText: true,
  //     contentTitle: data['title'],
  //     htmlFormatContentTitle: true,
  //   );
  //   AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     "Lenore",
  //     "Lenore",
  //     importance: Importance.max,
  //     styleInformation: bigTextStyleInformation,
  //     priority: Priority.max,
  //     playSound: true,
  //     sound: const RawResourceAndroidNotificationSound('notification'),
  //   );
  //   NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await fln.show(0, data['title'], data['body'], platformChannelSpecifics,
  //       payload: jsonEncode(data));
  // }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
    Map<String, String> data,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    final String largeIconPath =
        await _downloadAndSaveFile(data['image']!, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(data['image']!, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: data['title'],
      htmlFormatContentTitle: true,
      summaryText: data['body'],
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "Lenore Jewellery",
      "Lenore Jewellery",
      //  AppConstants.appName,
      //AppConstants.appName,
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, data['title'], data['body'], platformChannelSpecifics,
        payload: jsonEncode(data));
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';

    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }
  // static Future<String> _downloadAndSaveFile(
  //     String url, String fileName) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final String filePath = '${directory.path}/$fileName';
  //   final Response response = await Dio()
  //       .get(url, options: Options(responseType: ResponseType.bytes));
  //   final File file = File(filePath);
  //   await file.writeAsBytes(response.data);
  //   return filePath;
  // }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(
        "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
}
