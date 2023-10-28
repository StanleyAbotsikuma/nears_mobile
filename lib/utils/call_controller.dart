import 'dart:isolate';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

import '../configs/images.dart';

class CallController {
  late FlutterIsolate audioIsolate;
  SendPort? audioSendPort;
  CallController() {
    startAudioIsolate();
  }

  void startAudioIsolate() async {
    ReceivePort isolateReceivePort = ReceivePort();
    audioIsolate = await FlutterIsolate.spawn(
        audioIsolateEntry, isolateReceivePort.sendPort);
    isolateReceivePort.listen((message) {
      if (message is SendPort) {
        audioSendPort = message;
      }
    });
  }

  void audioIsolateEntry(SendPort sendPort) async {
// Initialize the audio player
    AudioPlayer audioPlayer = AudioPlayer();

    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (dynamic message in receivePort) {
      if (message is String) {
        if (message == 'play') {
// Play audio
          // await audioPlayer.play(
          //     UrlSource('https://freewavesamples.com/files/Bontempi-B3-C5.wav'));
          await audioPlayer.play(AssetSource(AppAssets.dailing));

          await audioPlayer.setReleaseMode(ReleaseMode.loop);
        } else if (message == 'stop') {
// Stop audio
          await audioPlayer.stop();
        }
      }
    }
  }

  void playAudio() {
    audioSendPort!.send('play');
  }

  void stopAudio() {
    audioSendPort!.send('stop');
  }

  void dispose() {
    audioIsolate.kill();
  }
}
