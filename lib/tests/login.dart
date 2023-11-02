import 'package:flutter/material.dart';
import '../utils/call_controller.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioIsolate? _audioIsolate;

  @override
  void initState() {
    super.initState();

    _audioIsolate = AudioIsolate();
    _audioIsolate?.initialize().then((value) => null);
  }

  @override
  void dispose() {
    _audioIsolate?.dispose();
    super.dispose();
  }

  void playAudio() {
    _audioIsolate?.playAudio();
  }

  void stopAudio() {
    _audioIsolate?.stopAudio();
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
            const CallTimer(),
          ],
        ),
      ),
    );
  }
}
