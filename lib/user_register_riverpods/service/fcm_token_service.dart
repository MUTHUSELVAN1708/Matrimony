import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeFCM() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('fcmToken') == null) {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await sendTokenToBackend(token);
      }
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await sendTokenToBackend(newToken);
    });
  }

  Future<void> sendTokenToBackend(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final int? userId = await SharedPrefHelper.getUserId();

    try {
      final response = await http.post(
        Uri.parse(Api.fcmToken),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({'userId': userId, 'fcmtoken': token}),
      );

      if (response.statusCode == 200) {
        await prefs.setString('fcmToken', token);
      } else {
        throw Exception('Failed to send token to backend');
      }
    } catch (e) {
      print("Error sending token: $e");
    }
  }
}
