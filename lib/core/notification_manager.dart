import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._();
  static const _appId = '66414d4c-46cd-4725-a383-826c606b1d76';

  factory NotificationManager() => _instance;

  NotificationManager._();

  Future<void> init() async {
    // The promptForPushNotificationsWithUserResponse function will show iOS
    // push notification prompt. We recommend removing the following code and
    // instead using an In-App Message to prompt for notification permission
    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   print("Accepted permission: $accepted");
    // });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    await OneSignal.shared.setAppId(_appId);
  }
}
