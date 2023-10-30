import 'dart:isolate';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:nears/configs/images.dart';

class AudioIsolate {
  late FlutterIsolate _isolate;
  SendPort? _sendPort;

  Future<void> initialize() async {
    BackgroundIsolateBinaryMessenger.ensureInitialized;

    ReceivePort isolateReceivePort = ReceivePort();
    _isolate =
        await FlutterIsolate.spawn(_isolateEntry, isolateReceivePort.sendPort);
    _sendPort = await isolateReceivePort.first;

    // isolateReceivePort.listen((message) {
    //   if (message is SendPort) {
    //     _sendPort = message;
    //   }
    // });
  }

  void playAudio() async {
    _sendPort!.send('play');
  }

  void stopAudio() {
    _sendPort!.send('stop');
  }

  void playBusy() async {
    _sendPort!.send('playBusy');
  }

  void stopBusy() {
    _sendPort!.send('stopBusy');
  }

  void dispose() {
    _isolate.kill();
  }
}

void _isolateEntry(SendPort sendPort) async {
  // Initialize the audio player
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayer1 = AudioPlayer();
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  await for (dynamic message in receivePort) {
    if (message is String) {
      if (message == 'play') {
        await audioPlayer.play(AssetSource(AppAssets.dailing));
        await audioPlayer.setReleaseMode(ReleaseMode.loop);
      } else if (message == 'stop') {
        await audioPlayer.stop();
      } else if (message == 'playBusy') {
        await audioPlayer1.play(AssetSource(AppAssets.yaa_chinaa_busy));
        await audioPlayer1.setReleaseMode(ReleaseMode.loop);
      } else if (message == 'stopBusy') {
        await audioPlayer1.stop();
      }
    }
  }
}
