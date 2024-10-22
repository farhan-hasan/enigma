import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

enum CallType { voice, video }

class RTCConfig {
  static late RtcEngine _engine;
  static const String APP_ID = "a043b1dd233440b8a8435966f4a9dab3";
  static const String HOST_URL =
      'https://deeplink-host.onrender.com/enigma-token/generate';

  static init() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = createAgoraRtcEngine();
  }

  static Future<String?> fetchToken(
    int uid,
    String channelId,
  ) async {
    var client = Client();
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await client.post(Uri.parse(HOST_URL),
          headers: headers,
          body: jsonEncode({'account': uid, 'channel_name': channelId}));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      String token = decodedResponse['token'];
      debug("Token came ${token}");
      return token;
    } catch (e) {}
    client.close();
    return null;
  }

  static int stringToUnsignedInt(String input) {
    int hash = 0;
    for (int i = 0; i < input.length; i++) {
      hash = 31 * hash + input.codeUnitAt(i);
      // Ensure the hash is within the range of an unsigned 32-bit integer
      hash = hash & 0xFFFFFFFF;
    }
    return hash;
  }
}
