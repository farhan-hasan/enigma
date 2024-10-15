import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TestBle extends StatefulWidget {
  const TestBle({super.key});

  static const route = "/test";

  static String getRoute() => "/test";

  @override
  State<TestBle> createState() => _TestBleState();
}

class _TestBleState extends State<TestBle> {
  ValueNotifier<List<BluetoothDevice>> connectedSystemDevices =
      ValueNotifier([]);

  @override
  void initState() {
    isSupported();
    // TODO: implement initState
    super.initState();
  }

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  isSupported() async {
    if (await FlutterBluePlus.isSupported == false) {
      BotToast.showText(text: "Bluetooth not supported by this device");
      return;
    }

    // _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
    //   _adapterState = state;
    // }

    BotToast.showText(text: "Bluetooth supported by this device");

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  scanDevice() async {
    // var withServices = [Guid("bf27730d-860a-4e09-889c-2d8b6a9e0fe7")];
    await FlutterBluePlus.startScan(
      // withNames: ["Tanzim A30"],
      // withKeywords: ["Akhulbab"],
      // withServices: withServices,
      // withRemoteIds: [
      //   // "9C:73:B1:11:14:45",
      //   // "70:74:14:FD:C4:92",
      //   // "A48B88DB-A5BC-5518-928B-1067A5F9554D"
      // ],
      // androidScanMode: AndroidScanMode.balanced,

      timeout: const Duration(seconds: 10),
    );

    // FlutterBluePlus.events.onDiscoveredServices.listen(
    //       (event) async {
    //     await event.device.connect().whenComplete(
    //           () {
    //         print("${event.device.advName} - ${event.device.isConnected}");
    //       },
    //     ).onError((error, stackTrace) => print(error.toString()),);
    //   },
    // );

    // var subscription1 =
    //     FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
    //   print(state);
    //   if (state == BluetoothAdapterState.on) {
    //     // print("Calling Scanning");
    //     //scanDevice();
    //   } else {
    //     // show an error to the user, etc
    //   }
    // });
    // // Battery Level Service
    // var systemDevices = await FlutterBluePlus.systemDevices([]);
    // debug(systemDevices);

    //   var subscription2 = FlutterBluePlus.onScanResults.listen(
    //     (results) {
    //       if (results.isNotEmpty) {
    //         ScanResult r = results.last; // the most recently found device
    //         print('${r.device.remoteId}: "${r.advertisementData}" found!');
    //       } else {
    //         print(results);
    //       }
    //     },
    //     onError: (e) => print(e),
    //   );
  }

  onConnect(BluetoothDevice device) async {
    FlutterBluePlus.stopScan();
    // await device.pair();
    // FlutterBluePlus.systemDevices([]);
    await Future.delayed(const Duration(milliseconds: 500));

    await device.connect();
    connectedSystemDevices.value = await FlutterBluePlus.systemDevices([]);
    debug(connectedSystemDevices.value);
    if (device.isConnected) {
      BotToast.showText(text: "The Bluetooth Device is Connected Successfully");
    } else {
      BotToast.showText(text: "The Bluetooth Device Connection is Failed");
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: scanDevice, icon: Icon(Icons.add)),
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: FlutterBluePlus.onScanResults,
        builder: (context, snapshot) {
          // print(snapshot.hasData);
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                if (snapshot.data?[index].advertisementData.txPowerLevel !=
                    null) {
                  return ListTile(
                    title: ValueListenableBuilder(
                      valueListenable: connectedSystemDevices,
                      builder: (context, value, child) {
                        return Text(
                          "${index + 1}) ${snapshot.data?[index].advertisementData}",
                          style: TextStyle(
                              color: connectedSystemDevices.value
                                      .contains(snapshot.data?[index].device)
                                  ? Colors.red
                                  : Colors.black),
                        );
                      },
                    ),
                    trailing: IconButton(
                        onPressed: () =>
                            onConnect(snapshot.data![index].device),
                        icon: const Icon(Icons.add)),
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          } else {
            return const Center(
              child: Text("No device found"),
            );
          }
        },
      ),
    );
  }
}
