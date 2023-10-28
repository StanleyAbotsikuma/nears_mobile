// import 'dart:async';
// import 'dart:isolate';

// import 'package:audioplayers/audioplayers.dart';
// Isolate? audioPlayerIsolate;
// SendPort? audioPlayerSendPort;

// void audioPlayerIsolateEntry(SendPort sendPort) {
//   final audioPlayer = AudioPlayer();

//   // Listen for messages from the main isolate
//   ReceivePort receivePort = ReceivePort();
//   sendPort.send(receivePort.sendPort);
//   receivePort.listen((message) {
//     if (message['play'] != null) {
//       final String audioUrl = message['play'];
//       audioPlayer.play(UrlSource('https://example.com/my-audio.wav'));
//     } else if (message['stop'] != null) {
//       audioPlayer.stop();
//     }
//   });
// }



// void startAudioPlayerIsolate() async {
//   audioPlayerIsolate = await Isolate.spawn(
//     audioPlayerIsolateEntry,
//     audioPlayerSendPort?.sendPort,
//   );

//   // Receive the send port from the audio player isolate
//   final receivePort = ReceivePort();
//   audioPlayerIsolate?.addOnExitListener(receivePort.sendPort);
//   receivePort.listen((dynamic message) {
//     audioPlayerSendPort = message;
//   });
// }

// void stopAudioPlayerIsolate() {
//   if (audioPlayerIsolate != null) {
//     audioPlayerIsolate?.kill(priority: Isolate.immediate);
//     audioPlayerIsolate = null;
//     audioPlayerSendPort = null;
//   }
// }


// void playAudio(String audioUrl) {
//   audioPlayerSendPort?.send({'play': audioUrl});
// }

// void stopAudio() {
//   audioPlayerSendPort?.send({'stop': true});
// }