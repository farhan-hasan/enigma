import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

String token =
    "007eJxTYDjW6vlhm7hS1Z3pan77lDPr3/3T2tPPk3E58OLyMo+SDwYKDIZm5oZGFklpJqbG5iamKclJpqmmlkmmRolAKs0y2WTZGpH0hkBGhkcF1oyMDBAI4nMyOGck5uWl5ni6MDAAACRFIZQ=";
String appID = "167128bf453745dcb5e59b52ae59f9c4";
String channelID = "ChannelID";
int uid = 0;

/// JoinChannelAudio Example
class JoinChannelAudio extends StatefulWidget {
  /// Construct the [JoinChannelAudio]
  const JoinChannelAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {

  late final RtcEngine _engine;

  // todo: Replace with channel ID
  String channelId = channelID;
  final String _selectedUid = '';
  bool isJoined = false,
      openMicrophone = true,
      muteMicrophone = false,
      muteAllRemoteAudio = false,
      enableSpeakerphone = true,
      playEffect = false;
  bool _isSetDefaultAudioRouteToSpeakerphone = false;
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 100,
      _playbackVolume = 100,
      _inEarMonitoringVolume = 100;
  late TextEditingController _controller;
  late final TextEditingController _selectedUidController;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _selectedUidController = TextEditingController(text: _selectedUid);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    // todo: replace with Agora Project App ID
    await _engine.initialize(RtcEngineContext(
      appId: appID,
    ));

    _rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        debug('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        debug(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid,
          RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
        debug(
            '[onRemoteAudioStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        debug(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      onAudioRoutingChanged: (routing) {
        debug('[onAudioRoutingChanged] routing: $routing');
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine.joinChannel(
        // todo: replace with dynamic token
        token: token,
        channelId: _controller.text,
        // todo:  replace with dynamic uid
        uid: uid,
        options: ChannelMediaOptions(
          channelProfile: _channelProfileType,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = true;
      muteMicrophone = false;
      muteAllRemoteAudio = false;
      enableSpeakerphone = true;
      playEffect = false;
      _enableInEarMonitoring = false;
      _recordingVolume = 100;
      _playbackVolume = 100;
      _inEarMonitoringVolume = 100;
    });
  }

  _switchMicrophone() async {
    // await await _engine.muteLocalAudioStream(!openMicrophone);
    await _engine.enableLocalAudio(!openMicrophone);
    setState(() {
      openMicrophone = !openMicrophone;
    });
  }

  _muteLocalAudioStream() async {
    await _engine.muteLocalAudioStream(!muteMicrophone);
    setState(() {
      muteMicrophone = !muteMicrophone;
    });
  }

  _muteAllRemoteAudioStreams() async {
    await _engine.muteAllRemoteAudioStreams(!muteAllRemoteAudio);
    setState(() {
      muteAllRemoteAudio = !muteAllRemoteAudio;
    });
  }

  _switchSpeakerphone() async {
    await _engine.setEnableSpeakerphone(!enableSpeakerphone);
    setState(() {
      enableSpeakerphone = !enableSpeakerphone;
    });
  }

  _onChangeInEarMonitoringVolume(double value) async {
    _inEarMonitoringVolume = value;
    await _engine.setInEarMonitoringVolume(_inEarMonitoringVolume.toInt());
    setState(() {});
  }

  _toggleInEarMonitoring(value) async {
    try {
      await _engine.enableInEarMonitoring(
          enabled: value,
          includeAudioFilters: EarMonitoringFilterType.earMonitoringFilterNone);
      _enableInEarMonitoring = value;
      setState(() {});
    } catch (e) {
      // Do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Channel ID'),
                ),
                const Text('Channel Profile: '),
                DropdownButton<ChannelProfileType>(
                    items: items,
                    value: _channelProfileType,
                    onChanged: isJoined
                        ? null
                        : (v) async {
                      setState(() {
                        _channelProfileType = v!;
                      });
                    }),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: isJoined ? _leaveChannel : _joinChannel,
                        child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                      ),
                    )
                  ],
                ),
                if (kIsWeb) ...[
                  TextField(
                    controller: _selectedUidController,
                    decoration: const InputDecoration(
                        hintText: 'input userID you want to mute/unmute'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _engine.muteRemoteAudioStream(
                          uid: int.tryParse(_selectedUidController.text) ?? -1,
                          mute: true);
                    },
                    child: const Text('mute Remote Audio'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _engine.muteRemoteAudioStream(
                          uid: int.tryParse(_selectedUidController.text) ?? -1,
                          mute: false);
                    },
                    child: const Text('unmute Remote Audio'),
                  ),
                ],
              ],
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (kIsWeb) ...[
                        ElevatedButton(
                          onPressed: _muteLocalAudioStream,
                          child: Text(
                              'Microphone ${muteMicrophone ? 'muted' : 'unmute'}'),
                        ),
                        ElevatedButton(
                          onPressed: _muteAllRemoteAudioStreams,
                          child: Text(
                              'All Remote Microphone ${muteAllRemoteAudio ? 'muted' : 'unmute'}'),
                        ),
                      ],
                      ElevatedButton(
                        onPressed: _switchMicrophone,
                        child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
                      ),
                      if (!kIsWeb) ...[
                        ElevatedButton(
                          onPressed: () {
                            _isSetDefaultAudioRouteToSpeakerphone =
                            !_isSetDefaultAudioRouteToSpeakerphone;
                            _engine.setDefaultAudioRouteToSpeakerphone(
                                _isSetDefaultAudioRouteToSpeakerphone);
                            setState(() {});
                          },
                          child: Text(!_isSetDefaultAudioRouteToSpeakerphone
                              ? 'SetDefaultAudioRouteToSpeakerphone'
                              : 'UnsetDefaultAudioRouteToSpeakerphone'),
                        ),
                        ElevatedButton(
                          onPressed: isJoined ? _switchSpeakerphone : null,
                          child: Text(
                              enableSpeakerphone ? 'Speakerphone' : 'Earpiece'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('RecordingVolume:'),
                            Slider(
                              value: _recordingVolume,
                              min: 0,
                              max: 400,
                              divisions: 5,
                              label: 'RecordingVolume',
                              onChanged: isJoined
                                  ? (double value) async {
                                setState(() {
                                  _recordingVolume = value;
                                });
                                await _engine.adjustRecordingSignalVolume(
                                    value.toInt());
                              }
                                  : null,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('PlaybackVolume:'),
                            Slider(
                              value: _playbackVolume,
                              min: 0,
                              max: 400,
                              divisions: 5,
                              label: 'PlaybackVolume',
                              onChanged: isJoined
                                  ? (double value) async {
                                setState(() {
                                  _playbackVolume = value;
                                });
                                await _engine.adjustPlaybackSignalVolume(
                                    value.toInt());
                              }
                                  : null,
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              const Text('InEar Monitoring Volume:'),
                              Switch(
                                value: _enableInEarMonitoring,
                                onChanged: isJoined ? _toggleInEarMonitoring : null,
                                activeTrackColor: Colors.grey[350],
                                activeColor: Colors.white,
                              )
                            ]),
                            if (_enableInEarMonitoring)
                              SizedBox(
                                  width: 300,
                                  child: Slider(
                                    value: _inEarMonitoringVolume,
                                    min: 0,
                                    max: 100,
                                    divisions: 5,
                                    label:
                                    'InEar Monitoring Volume $_inEarMonitoringVolume',
                                    onChanged: isJoined
                                        ? _onChangeInEarMonitoringVolume
                                        : null,
                                  ))
                          ],
                        ),
                      ],
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                ))
          ],
        ),
      ),
    );
  }
}

// TODO: These credentials are used by Farhan (Testing purpose)
/// String token =
///     "007eJxTYLhxurF9++kZYq6XYqsXTy3bbxK0Xq7Tdt3yFJF3V+otcu4oMCSZJFoaWiRbpqSmpZiYJpsmmadYpFqYmBunGBuaG5mZXrwqkN4QyMgwJ7SMiZEBAkF8HoaS1OISheSMxLy81BwGBgDoDSPn";
/// String appId = "b4a918c9defd45c5b7d8e8473d317265";
/// String channelId = "test channel";
