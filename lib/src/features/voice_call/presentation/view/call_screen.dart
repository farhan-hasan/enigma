import 'package:enigma/src/core/rtc/rtc_config.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({super.key});

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  late String userUid, channelId;
  int userUidInt = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((t) async {
      await RTCConfig.init();
      String userUid = ref.read(profileProvider).profileEntity?.uid ?? "";
      channelId = userUid;
      int userUidInt = getIntUid(userUid);
      debug("init userUidInt: $userUidInt");
      RTCConfig.initVoiceChannel(intUid: userUidInt, channelId: userUid);
      //_initEngine(userUidInt);
    });
  }

  int getIntUid(String userUid) {
    int userUidInt = 0;
    for (int i = 0; i < userUid.length; i++) {
      userUidInt = (userUidInt * 31 + userUid.codeUnitAt(i)) &
          0xFFFFFFFF; // Constrain to 32-bit
    }
    return userUidInt;
  }

  // Future<void> _initEngine(int uid) async {
  //   await [Permission.microphone].request();
  //   _engine = createAgoraRtcEngine();
  //   await _engine.initialize(RtcEngineContext(
  //       appId: appId,
  //       channelProfile: ChannelProfileType.channelProfileCommunication));
  //   _engine.registerEventHandler(RtcEngineEventHandler(
  //     onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //       debug('local user ${connection.localUid} joined');
  //       // setState(() {
  //       //   isJoined = true;
  //       // });
  //     },
  //     onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
  //       debug("remote user $remoteUid joined");
  //       // setState(() {
  //       //   remoteUid.add(rUid);
  //       // });
  //     },
  //     onUserOffline:
  //         (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
  //       debug("remote user $remoteUid left channel");
  //       // setState(() {
  //       //   remoteUid.removeWhere((element) => element == rUid);
  //       // });
  //     },
  //     onLeaveChannel: (RtcConnection connection, RtcStats stats) {
  //       debug('local user ${connection.localUid} left');
  //       // setState(() {
  //       //   isJoined = false;
  //       //   remoteUid.clear();
  //       // });
  //     },
  //     onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
  //       debug('Expiring token: $token for local user ${connection.localUid}');
  //       _fetchToken(uid, channelId, false);
  //     },
  //     onRequestToken: (RtcConnection connection) {
  //       debug('requested token for local user ${connection.localUid}');
  //       _fetchToken(uid, channelId, true);
  //     },
  //   ));
  //   // await _engine.enableVideo();
  //   // await _engine.startPreview();
  //   debug("before fetch userUidInt: $uid");
  //   await _fetchToken(uid, channelId, true);
  //   // setState(() {
  //   //   _isReadyPreview = true;
  //   // });
  // }

  // // Initialize
  // Future<void> initAgora() async {
  //   // Get permission
  //   await [Permission.microphone].request();
  //   // Create an RtcEngine instance
  //   _engine = createAgoraRtcEngine();
  //   // Initialize RtcEngine and set the channel profile
  //   await _engine.initialize(RtcEngineContext(
  //     appId: appId,
  //     channelProfile: ChannelProfileType.channelProfileCommunication,
  //   ));
  //   // Handle engine events
  //   _engine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         debug('local user ${connection.localUid} joined');
  //         setState(() {
  //           _localUserJoined = true;
  //         });
  //       },
  //       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
  //         debug("remote user $remoteUid joined");
  //         setState(() {
  //           _remoteUid = remoteUid;
  //         });
  //       },
  //       onUserOffline: (RtcConnection connection, int remoteUid,
  //           UserOfflineReasonType reason) {
  //         debug("remote user $remoteUid left channel");
  //         setState(() {
  //           _remoteUid = null;
  //         });
  //       },
  //     ),
  //   );
  //   // Join a channel using a temporary token and channel name
  //   await _engine.joinChannel(
  //     token: token,
  //     channelId: channelId,
  //     options: const ChannelMediaOptions(
  //         // Automatically subscribe to all audio streams
  //         autoSubscribeAudio: true,
  //         // Publish microphone audio
  //         publishMicrophoneTrack: true,
  //         // Set user role to clientRoleBroadcaster (broadcaster) or clientRoleAudience (audience)
  //         clientRoleType: ClientRoleType.clientRoleBroadcaster),
  //     uid:
  //         0, // When you set uid to 0, a user name is randomly generated by the engine
  //   );
  // }

  // Future<void> _fetchToken(
  //   int uid,
  //   String channelID,
  //   bool needJoinChannel,
  // ) async {
  //   var client = Client();
  //   try {
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //     };
  //     var response = await client.post(Uri.parse(hostUrl),
  //         headers: headers,
  //         body: jsonEncode({'account': uid, 'channel_name': channelId}));
  //     var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     final token = decodedResponse['token'];
  //     debug("token form API: $token - $uid");
  //     if (needJoinChannel) {
  //       await _engine.joinChannel(
  //         token: token,
  //         channelId: channelID,
  //         uid: uid,
  //         options: const ChannelMediaOptions(
  //
  //             // Automatically subscribe to all audio streams
  //             autoSubscribeAudio: true,
  //             // Publish microphone audio
  //             publishMicrophoneTrack: true,
  //             // Set user role to clientRoleBroadcaster (broadcaster) or clientRoleAudience (audience)
  //             clientRoleType: ClientRoleType.clientRoleBroadcaster),
  //       );
  //     } else {
  //       debug("called renewToken");
  //       await _engine.renewToken(token);
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    RTCConfig.releaseResource();
    //_dispose();
  }

  // Future<void> _dispose() async {
  //   await _engine.leaveChannel(); // Leave the channel
  //   await _engine.release(); // Release resources
  // }

  // Build the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agora Voice Call',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora Voice Call'),
        ),
        body: const Center(
          child: Text('Have a voice call!'),
        ),
      ),
    );
  }
}
