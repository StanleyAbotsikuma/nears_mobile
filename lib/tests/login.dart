import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:nears/configs/images.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late FlutterIsolate audioIsolate;
  SendPort? audioSendPort;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    audioIsolate.kill();
    super.dispose();
  }

  void playAudio() {
    audioSendPort!.send('play');
  }

  void stopAudio() {
    audioSendPort!.send('stop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        TextButton(
          onPressed: playAudio,
          child: Text('Play Audio'),
        ),
        TextButton(
          onPressed: stopAudio,
          child: Text('Stop Audio'),
        ),
      ],
    )));
  }
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
