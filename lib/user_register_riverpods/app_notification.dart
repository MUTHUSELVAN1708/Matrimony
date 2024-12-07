import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:matrimony/common/colors.dart';

class AppNotification {
  static const String _notificationChannelKey =
      'aha_thirumanam_app_notification';
  static const String _notificationChannelName =
      'Aha Thirumanam App Notification';
  static String _notificationId = '';

  static bool _platformSupportsNotifications() =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static bool _platformNeedsFirebaseNotifications() =>
      !kIsWeb && Platform.isAndroid;

  static bool _platformWithDoseNotNeedsFirebaseNotifications() =>
      !kIsWeb && Platform.isIOS;

  static Future<void> initializeNotification() async {
    if (_platformSupportsNotifications()) {
      await AwesomeNotifications().initialize(
        'resource://drawable-mdpi/splash',
        [
          NotificationChannel(
            channelKey: _notificationChannelKey,
            channelName: _notificationChannelName,
            channelDescription:
                'Notification channel for application notifications',
            defaultColor: AppColors.primaryButtonColor,
            importance: NotificationImportance.High,
            criticalAlerts: true,
            playSound: true,
          ),
        ],
      );
    }
  }

  static Future<void> showFirebasePushNotification(
    RemoteMessage message,
  ) async {
    if (_platformNeedsFirebaseNotifications()) {
      final data = message.data;
      if (_notificationId != data['notificationId']) {
        _notificationId = data['notificationId'] as String;
        final payload = <String, String?>{};
        for (final a in data.entries) {
          payload[a.key] = a.value as String;
        }
        await createNotification(
          title: data['title'] as String? ?? '',
          body: data['body'] as String? ?? '',
          payload: payload,
          networkImagePath: data['image'] as String?,
        );
      }
    }
  }

  static Future<void> createNotification({
    required String title,
    required String body,
    required Map<String, String?> payload,
    String? networkImagePath,
  }) async {
    if (_platformSupportsNotifications()) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: _notificationChannelKey,
          title: title,
          body: body,
          payload: payload,
          bigPicture: networkImagePath,
          notificationLayout: networkImagePath != null
              ? NotificationLayout.BigPicture
              : NotificationLayout.BigText,
        ),
      );
    }
  }

  static Future<void> setupInAppNotification() async {
    if (_platformNeedsFirebaseNotifications()) {
      FirebaseMessaging.onMessage.listen(showFirebasePushNotification);
      await AwesomeNotifications()
          .setListeners(onActionReceivedMethod: _onActionReceivedMethod);
    }
    if (_platformWithDoseNotNeedsFirebaseNotifications()) {
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    }
  }

  static Future<void> _onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    final payload = receivedAction.payload;
    if (payload != null) {
      final navigationPage = payload['navigation_view'] ?? '';
      _handleNavigation(navigationPage);
    }
  }

  static Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    final payload = message.data;
    final navigationPage = payload['navigation_view'] as String? ?? '';
    _handleNavigation(navigationPage);
  }

  static void _handleNavigation(String navigationPage) {
    if (navigationPage.isNotEmpty) {
      // switch (navigationPage) {
      //   case 'profile':
      //     Context.currentContext?.push(Routes.profile);
      // }
    }
  }
}
