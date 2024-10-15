import 'package:audioplayers/audioplayers.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';

class VoiceMessageViewWidget extends StatefulWidget {
  const VoiceMessageViewWidget(
      {super.key, required this.url, required this.isFile});

  final String url;
  final bool isFile;

  @override
  State<VoiceMessageViewWidget> createState() => _VoiceMessageViewState();
}

class _VoiceMessageViewState extends State<VoiceMessageViewWidget> {
  AudioPlayer player = AudioPlayer();
  Duration? duration;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (t) async {
        await player.setSource(UrlSource(widget.url ?? ""));
        duration = await player.getDuration() ?? const Duration(seconds: 10);
        debug(duration?.inSeconds);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VoiceMessageView(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      circlesColor: Theme.of(context).colorScheme.primary,
      activeSliderColor: Theme.of(context).colorScheme.onPrimary,
      // notActiveSliderColor:
      //     Theme.of(context).colorScheme.primary.withOpacity(0.2),
      controller: VoiceController(
          audioSrc: widget.url,
          isFile: widget.isFile,
          maxDuration: duration ?? const Duration(seconds: 0),
          onComplete: () {},
          onPause: () {},
          onPlaying: () {}),
    );
  }
}
