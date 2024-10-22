import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:enigma/src/core/rtc/rtc_config.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/voice_call/data/model/call_model.dart';
import 'package:enigma/src/features/voice_call/presentation/view_model/call_generic.dart';
import 'package:enigma/src/shared/data/model/push_body_model/push_body_model.dart';
import 'package:enigma/src/shared/domain/dto/fcm_dto.dart';
import 'package:enigma/src/shared/domain/use_cases/send_push_message_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callProvider =
    StateNotifierProvider.autoDispose<CallController, CallGeneric>(
        (ref) => CallController(ref));

class CallController extends StateNotifier<CallGeneric> {
  CallController(this.ref) : super(CallGeneric());
  Ref ref;

  SendPushMessageUsecase sendPushMessageUsecase = SendPushMessageUsecase();

  RtcEngineEventHandler? _rtcEngineEventHandler;

  Future<void> call({required CallModel callModel}) async {
    callModel.token ??= await RTCConfig.fetchToken(
        callModel.uid ?? 0, callModel.channelId ?? "");

    debug("call model stat ${callModel.toJson()}");

    await initiateCallEngine(callModel: callModel);
    sendCallNotification(callModel: callModel);
  }

  sendCallNotification({required CallModel callModel}) {
    sendPushMessageUsecase.call(FCMDto(
        recipientToken: callModel.receiverToken ?? "",
        title: "Enigma Call",
        body: "Call came from ${callModel.senderName}",
        imageUrl: callModel.senderAvatar ?? "",
        data: PushBodyModel(
            showNotification: false,
            type: "incoming_call",
            body: jsonEncode(callModel.toJson()))));
  }

  Future<void> initiateCallEngine({required CallModel callModel}) async {
    callModel.token ??= await RTCConfig.fetchToken(
        callModel.uid ?? 0, callModel.channelId ?? "");

    RtcEngine engine = createAgoraRtcEngine();

    await engine.initialize(const RtcEngineContext(
        appId: RTCConfig.APP_ID,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));

    _rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        debug('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        debug(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');

        state = state.update(isJoined: true);
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        debug(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');

        Set<int> uids = state.remoteUid;
        uids.add(rUid);
        state = state.update(remoteUid: uids);
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        debug(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        Set<int> uids = state.remoteUid;
        uids.removeWhere((element) => element == rUid);
        state = state.update(remoteUid: uids);
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        debug(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        state = state.update(remoteUid: {}, isJoined: false);
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        debug(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
    );

    engine.registerEventHandler(_rtcEngineEventHandler!);
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();

    AgoraClient agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: RTCConfig.APP_ID,
          channelName: callModel.channelId ?? "",
          uid: callModel.uid),
    );

    await agoraClient.initialize();

    state = state.update(engine: engine, agoraClient: agoraClient);

    await joinChannel(callModel: callModel);
  }

  Future<void> joinChannel({required CallModel callModel}) async {
    try {
      await leaveChannel();
    } catch (e) {}
    await state.engine?.joinChannel(
      token: callModel.token ?? "",
      channelId: callModel.channelId ?? "",
      uid: callModel.uid ?? 0,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> leaveChannel() async {
    await state.engine?.leaveChannel();
    state.update(
        openCamera: true, muteCamera: false, muteAllRemoteVideo: false);
  }

  Future<void> switchCamera() async {
    await state.engine?.switchCamera();
    state = state.update(switchCamera: !state.switchCamera);
  }

  openCamera() async {
    await state.engine?.enableLocalVideo(!state.openCamera);
    state = state.update(openCamera: !state.openCamera);
  }

  muteLocalVideoStream() async {
    await state.engine?.muteLocalVideoStream(!state.muteCamera);
    state = state.update(muteCamera: !state.muteCamera);
  }

  muteAllRemoteVideoStreams() async {
    await state.engine?.muteAllRemoteVideoStreams(!state.muteAllRemoteVideo);
    state = state.update(muteAllRemoteVideo: !state.muteAllRemoteVideo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    state.engine?.unregisterEventHandler(_rtcEngineEventHandler!);
    state.engine?.leaveChannel();
    state.engine?.release();
    super.dispose();
  }
}
