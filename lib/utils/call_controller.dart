import 'dart:async';
import 'dart:isolate';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nears/configs/images.dart';

class AudioIsolate {
  late FlutterIsolate _isolate;
  SendPort? _sendPort;
  @pragma('vm:entry-point')
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

@pragma('vm:entry-point')
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

class CallTimer extends StatefulWidget {
  const CallTimer({super.key});

  @override
  State<CallTimer> createState() => _CallTimerState();
}

class _CallTimerState extends State<CallTimer> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  late Timer _timer;

  void increaseSecond() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds = seconds == 59 ? increaseMinutes() : seconds + 1;
      if (seconds == -1) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  int increaseMinutes() {
    minutes = minutes == 59 ? increaseHours() : minutes + 1;
    return 0;
  }

  int increaseHours() {
    hours = hours + 1;
    return 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    increaseSecond();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hours != 0) timeText("$hours"),
        if (hours != 0) timeText(":"),
        timeText("${minutes < 10 ? "0" : ""}$minutes"),
        timeText(":"),
        timeText("${seconds < 10 ? "0" : ""}$seconds"),
      ],
    );
  }

  Text timeText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jura',
        fontWeight: FontWeight.w700, // for Jura-Bold
        fontSize: 16.sp,
      ),
    );
  }
}
