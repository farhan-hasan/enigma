import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:enigma/src/features/voice_call/data/model/call_model.dart';
import 'package:enigma/src/features/voice_call/presentation/view/example_widget_builder.dart';
import 'package:enigma/src/features/voice_call/presentation/view_model/call_controller.dart';
import 'package:flutter/foundation.dart';
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
        await ref.read(callProvider.notifier).initiateCallEngine(
              callModel: widget.callModel,
              clientRoleType: ClientRoleType.clientRoleAudience,
            );
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
          : SafeArea(
              child: ExampleActionsWidget(
                displayContentBuilder: (context, isLayoutHorizontal) => Stack(
                  children: [
                    call.engine == null
                        ? CircularProgressIndicator()
                        : AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: call.engine!,
                              canvas: VideoCanvas(uid: widget.callModel.uid),
                              // useFlutterTexture: _isUseFlutterTexture,
                              // useAndroidSurfaceView: _isUseAndroidSurfaceView,
                            ),
                            onAgoraVideoViewCreated: (viewId) {
                              //call.engine!.startPreview();
                            },
                          ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: call.remoteIdJoined == null
                          ? Text("user has not joined yet")
                          : AgoraVideoView(
                              controller: VideoViewController.remote(
                                rtcEngine: call.engine!,
                                canvas: VideoCanvas(uid: call.remoteIdJoined),
                                connection: RtcConnection(
                                    channelId: widget.callModel.channelId),
                                // useFlutterTexture: _isUseFlutterTexture,
                                // useAndroidSurfaceView: _isUseAndroidSurfaceView,
                              ),
                            ),
                    ),
                    // AgoraVideoViewer(
                    //   client: call.agoraClient!,
                    //   layoutType: Layout.floating,
                    //   showNumberOfUsers: true,
                    //   showAVState: true,
                    //   floatingLayoutContainerHeight: 100,
                    //   floatingLayoutContainerWidth: 100,
                    //   enableHostControls: true,
                    // ),
                    // AgoraVideoButtons(
                    //   client: call.agoraClient!,
                    //   addScreenSharing: false,
                    // ),
                  ],
                ),
                actionsBuilder: (context, isLayoutHorizontal) {
                  final channelProfileType = [
                    ChannelProfileType.channelProfileLiveBroadcasting,
                    ChannelProfileType.channelProfileCommunication,
                  ];
                  final items = channelProfileType
                      .map((e) => DropdownMenuItem(
                            child: Text(
                              e.toString().split('.')[1],
                            ),
                            value: e,
                          ))
                      .toList();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!kIsWeb &&
                          (defaultTargetPlatform == TargetPlatform.android ||
                              defaultTargetPlatform == TargetPlatform.iOS))
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Column(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           const Text('Rendered by Flutter texture: '),
                        //           Switch(
                        //             value: _isUseFlutterTexture,
                        //             onChanged: isJoined
                        //                 ? null
                        //                 : (changed) {
                        //               setState(() {
                        //                 _isUseFlutterTexture = changed;
                        //               });
                        //             },
                        //           )
                        //         ]),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                      const Text('Channel Profile: '),
                      // DropdownButton<ChannelProfileType>(
                      //   items: items,
                      //   value: _channelProfileType,
                      //   onChanged: isJoined
                      //       ? null
                      //       : (v) {
                      //     setState(() {
                      //       _channelProfileType = v!;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      // BasicVideoConfigurationWidget(
                      //   rtcEngine: _engine,
                      //   title: 'Video Encoder Configuration',
                      //   setConfigButtonText: const Text(
                      //     'setVideoEncoderConfiguration',
                      //     style: TextStyle(fontSize: 10),
                      //   ),
                      //   onConfigChanged: (width, height, frameRate, bitrate) {
                      //     _engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
                      //       dimensions: VideoDimensions(width: width, height: height),
                      //       frameRate: frameRate,
                      //       bitrate: bitrate,
                      //     ));
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          // Expanded(
                          //   flex: 1,
                          //   child: ElevatedButton(
                          //     onPressed: isJoined ? _leaveChannel : _joinChannel,
                          //     child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                          //   ),
                          // )
                        ],
                      ),
                      if (!kIsWeb &&
                          (defaultTargetPlatform == TargetPlatform.android ||
                              defaultTargetPlatform == TargetPlatform.iOS)) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        // ElevatedButton(
                        //   onPressed: _switchCamera,
                        //   child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
                        // ),
                      ],
                      if (kIsWeb) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        // ElevatedButton(
                        //   onPressed: _muteLocalVideoStream,
                        //   child: Text('Camera ${muteCamera ? 'muted' : 'unmute'}'),
                        // ),
                        // ElevatedButton(
                        //   onPressed: _muteAllRemoteVideoStreams,
                        //   child: Text(
                        //       'All Remote Camera ${muteAllRemoteVideo ? 'muted' : 'unmute'}'),
                        // ),
                        // ElevatedButton(
                        //   onPressed: _openCamera,
                        //   child: Text('Camera ${openCamera ? 'on' : 'off'}'),
                        // ),
                      ],
                    ],
                  );
                },
              ),
            ),
    );
  }
}
