import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:enigma/src/features/voice_call/data/model/call_model.dart';
import 'package:enigma/src/features/voice_call/presentation/view_model/call_controller.dart';
import 'package:enigma/src/features/voice_call/presentation/view_model/call_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// MultiChannel Example
class CallScreen extends ConsumerStatefulWidget {
  /// Construct the [JoinChannelVideo]
  const CallScreen({Key? key, required this.callModel, required this.isCalling})
      : super(key: key);
  final bool isCalling;
  final CallModel callModel;
  static const String route = "/call";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<CallScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((t) async {
      // await ref
      //     .read(callProvider.notifier)
      //     .initiateCallEngine(callModel: widget.callModel);
      if (widget.isCalling) {
        await ref.read(callProvider.notifier).call(callModel: widget.callModel);
      } else {
        await ref
            .read(callProvider.notifier)
            .initiateCallEngine(callModel: widget.callModel);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final call = ref.watch(callProvider);
    // print("Agora Client ${call.agoraClient}");
    print("Agora Engine ${call.engine}");
    return Scaffold(
        body: /*call.agoraClient == null && */ call.engine == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Center(
                    child: _remoteVideo(call),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 100,
                      height: 150,
                      child: Center(
                        child: call.isJoined
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: call.engine!,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ));
  }

  Widget _remoteVideo(CallGeneric call) {
    if (call.remoteIdJoined != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: call.engine!,
          canvas: VideoCanvas(uid: call.remoteIdJoined),
          connection: RtcConnection(channelId: widget.callModel.channelId),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
