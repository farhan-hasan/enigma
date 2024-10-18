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

  static Future<void> initVoiceChannel({
    required int intUid,
    required String channelId,
  }) async {
    // Initialize RtcEngine and set the channel profile
    await _engine.initialize(const RtcEngineContext(
      appId: APP_ID,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
    // Handle engine events
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debug('local user ${connection.localUid} joined');
          // setState(() {
          //   _localUserJoined = true;
          // });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debug("remote user $remoteUid joined");
          // setState(() {
          //   _remoteUid = remoteUid;
          // });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debug("remote user $remoteUid left channel");
          // setState(() {
          //   _remoteUid = null;
          // });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debug('Expiring token: $token for local user ${connection.localUid}');
          _fetchToken(intUid, channelId, false, CallType.voice);
        },
        onRequestToken: (RtcConnection connection) {
          debug('requested token for local user ${connection.localUid}');
          _fetchToken(intUid, channelId, true, CallType.voice);
        },
      ),
    );
    debug("before fetch userUidInt: $intUid");
    await _fetchToken(intUid, channelId, true, CallType.voice);
  }

  static Future<void> initVideoChannel({
    required int intUid,
    required String channelId,
  }) async {
    // Initialize RtcEngine and set the channel profile to live broadcasting
    await _engine.initialize(const RtcEngineContext(
      appId: APP_ID,
    ));
    _engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        debug('local user ${connection.localUid} joined');
        // setState(() {
        //   isJoined = true;
        // });
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        debug("remote user $remoteUid joined");
        // setState(() {
        //   remoteUid.add(rUid);
        // });
      },
      onUserOffline: (RtcConnection connection, int remoteUid,
          UserOfflineReasonType reason) {
        debug("remote user $remoteUid left channel");
        // setState(() {
        //   remoteUid.removeWhere((element) => element == rUid);
        // });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        debug('local user ${connection.localUid} left');
        // setState(() {
        //   isJoined = false;
        //   remoteUid.clear();
        // });
      },
      onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
        debug('Expiring token: $token for local user ${connection.localUid}');
        _fetchToken(intUid, channelId, false, CallType.video);
      },
      onRequestToken: (RtcConnection connection) {
        debug('requested token for local user ${connection.localUid}');
        _fetchToken(intUid, channelId, true, CallType.video);
      },
    ));
    await _engine.enableVideo();
    await _engine.startPreview();
    await _fetchToken(intUid, channelId, true, CallType.video);
    // setState(() {
    //   _isReadyPreview = true;
    // });
  }

  static Future<void> _fetchToken(int uid, String channelId,
      bool needJoinChannel, CallType callType) async {
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
      final token = decodedResponse['token'];
      debug("token form API: $token - $uid");
      if (needJoinChannel) {
        switch (callType) {
          case CallType.voice:
            {
              debug("joining voice channel");
              await _engine.joinChannel(
                token: token,
                channelId: channelId,
                uid: uid,
                options: const ChannelMediaOptions(
                    // Automatically subscribe to all audio streams
                    autoSubscribeAudio: true,
                    // Publish microphone audio
                    publishMicrophoneTrack: true,
                    // Set user role to clientRoleBroadcaster (broadcaster) or clientRoleAudience (audience)
                    clientRoleType: ClientRoleType.clientRoleBroadcaster),
              );
              break;
            }
          case CallType.video:
            {
              debug("joining video channel");
              await _engine.joinChannel(
                token: token,
                channelId: channelId,
                uid: uid,
                options: const ChannelMediaOptions(
                  channelProfile:
                      ChannelProfileType.channelProfileLiveBroadcasting,
                  clientRoleType: ClientRoleType.clientRoleBroadcaster,
                ),
              );
              break;
            }
        }
      } else {
        debug("called renewToken");
        await _engine.renewToken(token);
      }
    } finally {
      client.close();
    }
  }

  static Future<void> releaseResource() async {
    await _engine.leaveChannel(); // Leave the channel
    await _engine.release();
  }
}
