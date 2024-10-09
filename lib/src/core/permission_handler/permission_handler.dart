import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<void> requestPermission() async {
    PermissionStatus locationPermission = await Permission.location.request();
    PermissionStatus bleScan = await Permission.bluetoothScan.request();
    PermissionStatus bleConnect = await Permission.bluetoothConnect.request();
  }
}
