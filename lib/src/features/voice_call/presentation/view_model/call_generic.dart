import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';

class CallGeneric {
  bool isJoined,
      switchCamera,
      switchRender,
      openCamera,
      muteCamera,
      muteAllRemoteVideo;
  RtcEngine? engine;
  Set<int> remoteUid;
  AgoraClient? agoraClient;

  CallGeneric(
      {this.isJoined = false,
      this.switchCamera = true,
      this.switchRender = true,
      this.openCamera = true,
      this.muteCamera = true,
      this.muteAllRemoteVideo = false,
      this.remoteUid = const {},
      this.agoraClient,
      this.engine});

  CallGeneric update(
      {bool? isJoined,
      bool? switchCamera,
      bool? switchRender,
      bool? openCamera,
      bool? muteCamera,
      bool? muteAllRemoteVideo,
      RtcEngine? engine,
      Set<int>? remoteUid,
      AgoraClient? agoraClient}) {
    return CallGeneric(
        isJoined: isJoined ?? this.isJoined,
        switchCamera: switchCamera ?? this.switchCamera,
        switchRender: switchRender ?? this.switchRender,
        openCamera: openCamera ?? this.openCamera,
        muteCamera: muteCamera ?? this.muteCamera,
        muteAllRemoteVideo: muteAllRemoteVideo ?? this.muteAllRemoteVideo,
        engine: engine ?? this.engine,
        remoteUid: remoteUid ?? this.remoteUid,
        agoraClient: agoraClient ?? this.agoraClient);
  }
}
