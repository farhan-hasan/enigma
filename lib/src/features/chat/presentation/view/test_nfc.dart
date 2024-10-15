import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class NFCTesting extends StatefulWidget {
  const NFCTesting({super.key});

  static String route = '/test_nfc';

  static get setRoute => route;

  @override
  State<NFCTesting> createState() => _NFCTestingState();
}

class _NFCTestingState extends State<NFCTesting> {
  ValueNotifier<String> nfcData = ValueNotifier<String>("No Data Found Yet");
  AudioRecorder record = AudioRecorder();
  AudioPlayer audioPlayer = AudioPlayer();
  String? path;

  void startRecord() async {
    try {
      if (await record.hasPermission()) {
        final Directory appDocumentsDir =
            await getApplicationDocumentsDirectory();
        print(appDocumentsDir.path);
        await record.start(const RecordConfig(),
            path: "${appDocumentsDir.path}/myFile.m4a");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> stopRecord() async {
    path = await record.stop();
    print(path);
    File file = File(path!);
    return path;
  }

  void playRecord() async {
    Source audioUrl = UrlSource(path!);
    await audioPlayer.play(audioUrl, volume: 10);
    print("Recording Playing");
  }

  void pauseRecord() async {
    await audioPlayer.pause();
  }

  readNFCData() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    // print(isAvailable);
    if (isAvailable) {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          // print(tag.data.toString());
          nfcData.value = tag.data.toString();
        },
      );
      // print(nfcData.value);
    } else {
      nfcData.value = "NFC is not available in this device";
    }
  }

  writeNFCData() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        // print("Inside session");
        NdefMessage message = NdefMessage(
            [NdefRecord.createText(FirebaseHandler.auth.currentUser!.uid)]);
        Ndef? ndef = Ndef.from(tag);
        if (ndef != null && ndef.isWritable) {
          await ndef.write(message);
          BotToast.showText(text: "Message is written successfully");
        } else {
          BotToast.showText(text: "NFC Tag is not writable or unsupported");
        }
      });
    } else {
      BotToast.showText(text: "NFC is not available in this device");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: nfcData,
              builder: (context, value, child) {
                return Text(value);
              },
            ),
            TextButton(
              onPressed: () => startRecord(),
              child: const Text("Start Record"),
            ),
            TextButton(
              onPressed: () async => path = await stopRecord(),
              child: const Text("Stop Record"),
            ),
            TextButton(
              onPressed: () => playRecord(),
              child: const Text("Play Record"),
            ),
            TextButton(
              onPressed: () => pauseRecord(),
              child: const Text("Pause Record"),
            ),
          ],
        ),
      ),
    );
  }
}
