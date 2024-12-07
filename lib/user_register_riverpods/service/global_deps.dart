import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermission() async {
  await [
    Permission.storage,
    Permission.camera,
    Permission.notification,
  ].request();
}
