import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:audioplayers/audioplayers.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:gap/gap.dart';
import 'package:nears/screens/widgets.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../configs/connections.dart';
import '../configs/images.dart';
import '../utils/app_provider.dart';
import '../utils/call_controller.dart';

class CallScreen extends StatefulWidget {
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  AudioIsolate? _audioIsolate;
  String calltitle = "Calling...";
  // videoRenderer for localPeer
  final _localRTCVideoRenderer = RTCVideoRenderer();
  // videoRenderer for remotePeer
  final _remoteRTCVideoRenderer = RTCVideoRenderer();
  // mediaStream for localPeer
  MediaStream? _localStream;
  // RTC peer connection
  RTCPeerConnection? _rtcPeerConnection;
  String agentID = "";
  // list of rtcCandidates to be sent over signalling
  List<RTCIceCandidate> rtcIceCadidates = [];
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  WebSocketChannel? channel;
  // media status
  bool isAudioOn = true, isVideoOn = false, isFrontCameraSelected = true;
  int callState = 0;
  @pragma('vm:entry-point')
  Future<void> initWebSocket() async {
    if (callState == 0) {
      updateCallState(1);
    }

    final accessToken = await secureStorage.read(key: "accessToken");
    final host = await secureStorage.read(key: "host");
    final wsType = await secureStorage.read(key: "wsType");
    // final wsUrl = Uri.parse(
    //     "${AppConnections.wsType}${AppConnections.host}ws/emergency/?token=${accessToken!}");
    final wsUrl =
        Uri.parse("${wsType!}${host!}ws/emergency/?token=${accessToken!}");
    channel = WebSocketChannel.connect(wsUrl);
    channel!.ready.then((value) {
      channel!.sink.add(json.encode({
        "receiver": "nears",
        "type": "emergency",
        "data": [
          // ignore: use_build_context_synchronously
          Provider.of<AppProvider>(context, listen: false).getlocation(),
          // ignore: use_build_context_synchronously
          Provider.of<AppProvider>(context, listen: false).getAddress()
        ]
      }));
    });
    setState(() {});
    channel!.stream.listen(onMessageReceived, onError: onError, onDone: onDone);
  }

  void disposeWebSocket() {
    if (channel != null) {
      channel!.sink.close();
      channel = null;
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void onMessageReceived(dynamic message) {
    try {
      final Map<String, dynamic> data = json.decode(message.toString());

      if (data['receiver'].toString() == "caller") {
        switch (data['type']) {
          case "offer":
            updateCallState(2);
            _audioIsolate!.stopAudio();
            _audioIsolate!.stopBusy();
            calltitle = "Connected...";
            setState(() {});
            handleOffer(data['data'][0], data['data'][1], data['from']);
            break;
          case "candidate":
            _rtcPeerConnection!.addCandidate(RTCIceCandidate(
              data['data'][0],
              data['data'][1],
              data['data'][2],
            ));
            agentID = data['from'];
            if (callState == 1) {}
            setState(() {});
            break;
          default:
            break;
        }
      } else if (data['receiver'].toString() == "nears") {
        switch (data['type']) {
          case "busy":
            updateCallState(3);
            // print(data);
            _audioIsolate!.stopAudio();
            // print("test test test");
            _audioIsolate!.playBusy();
            calltitle = "Agents Busy...";
            setState(() {});
            break;

          case "end_call":
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: 'Case Reported',
              textTextStyle: const TextStyle(fontFamily: 'Jura'),
              titleTextStyle: TextStyle(
                  fontFamily: 'Jura',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
              confirmBtnTextStyle: TextStyle(
                  fontFamily: 'Jura',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
              cancelBtnTextStyle: TextStyle(
                  fontFamily: 'Jura',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
              confirmBtnText: 'Back',
              confirmBtnColor: Colors.green,
              onConfirmBtnTap: () {
                Navigator.of(context).pop();
              },
            );
            break;
          default:
            break;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void onError(dynamic error) {
    _audioIsolate!.stopAudio();
    // print("test test test");
    _audioIsolate!.playBusy();
    errorAlert(context);
  }

  void onDone() {
    _audioIsolate!.stopAudio();
    // print("test test test");
    _audioIsolate!.playBusy();
    errorAlert(context);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _audioIsolate = AudioIsolate();
    });
    _audioIsolate?.initialize().then((value) => playAudio());
    init();
    _localRTCVideoRenderer.initialize();
    _remoteRTCVideoRenderer.initialize();
    Timer(const Duration(seconds: 4), () {
      initWebSocket();
    });
  }

  void playAudio() {
    _audioIsolate?.playAudio();
  }

  void stopAudio() {
    _audioIsolate?.stopAudio();
  }

  void playBusy() {
    _audioIsolate?.playBusy();
  }

  void stopBusy() {
    _audioIsolate?.stopBusy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                isVideoOn
                    ? RTCVideoView(
                        _localRTCVideoRenderer,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      )
                    : Container(),
                Opacity(
                    opacity: isVideoOn ? 0 : 1,
                    child: SizedBox(
                      // decoration: BoxDecoration(image:),
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(150.h),
                          CircleAvatar(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              radius: 50,
                              child: Padding(
                                padding: EdgeInsets.all(15.w),
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.contain,
                                  width: 90.w,
                                  height: 90.h,
                                ),
                              )),
                          Gap(10.h),
                          SizedBox(
                            width: double.infinity,
                            child: title2(calltitle),
                          ),
                          Gap(10.h),
                          callState == 2 ? const CallTimer() : Container(),
                        ],
                      ),
                    )),
                SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 330.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(68),
                              color: const Color.fromARGB(180, 244, 244, 244),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(5, 0),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(
                                      isAudioOn ? Icons.mic : Icons.mic_off),
                                  onPressed: _toggleMic,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.call_end),
                                  iconSize: 30,
                                  onPressed: _leaveCall,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.cameraswitch),
                                  onPressed: _switchCamera,
                                ),
                                IconButton(
                                  icon: Icon(isVideoOn
                                      ? Icons.videocam
                                      : Icons.videocam_off),
                                  onPressed: _toggleCamera,
                                ),
                              ],
                            ),
                          ),
                          Gap(46.h)
                        ])),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  init() async {
    // create peer connection
    _rtcPeerConnection = await createPeerConnection({
      "sdpSemantics": "plan-b",
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });

    // listen for remotePeer mediaTrack event
    _rtcPeerConnection!.onTrack = (event) {
      _remoteRTCVideoRenderer.srcObject = event.streams[0];
      setState(() {});
    };

    // get localStream
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': true,
    });

    // add mediaTrack to peerConnection
    _localStream!.getTracks().forEach((track) {
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });

    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });

    // set source for local video renderer
    _localRTCVideoRenderer.srcObject = _localStream;
    setState(() {});

    _rtcPeerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      // print("this is mycandidate$candidate");
      rtcIceCadidates.add(candidate);
      channel!.sink.add(json.encode({
        "receiver": "agent",
        "type": "candidate",
        "data": [
          {
            "sdpMid": candidate.sdpMid,
            "sdpMLineIndex": candidate.sdpMLineIndex,
            "candidate": candidate.candidate
          }
        ],
        "to": agentID
      }));
    };

    setState(() {});
  }

  _leaveCall() {
    Navigator.pop(context);
  }

  _toggleMic() {
    // change status
    isAudioOn = !isAudioOn;
    // enable or disable audio track
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });
    setState(() {});
  }

  _toggleCamera() {
    // change status
    isVideoOn = !isVideoOn;
    // enable or disable video track
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
    setState(() {});
  }

  _switchCamera() {
    // change status
    isFrontCameraSelected = !isFrontCameraSelected;
    // switch camera
    _localStream?.getVideoTracks().forEach((track) {
      // ignore: deprecated_member_use
      track.switchCamera();
    });
    setState(() {});
  }

  @override
  void dispose() {
    _localRTCVideoRenderer.dispose();
    _remoteRTCVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    try {
      disposeWebSocket();
    } catch (e) {
      print(e);
    }
    _audioIsolate!.dispose();

    super.dispose();
  }

  Future<void> handleOffer(type, offer, sender) async {
    await _rtcPeerConnection!.setRemoteDescription(
      RTCSessionDescription(
        offer,
        type,
      ),
    );
    agentID = sender;
    // create SDP answer
    RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();
    channel!.sink.add(json.encode({
      "receiver": "agent",
      "type": "answer",
      "data": [answer.type, answer.sdp],
      "to": agentID
    }));

    // set SDP answer as localDescription for peerConnection
    _rtcPeerConnection!.setLocalDescription(answer);
    setState(() {});
    // send iceCandidate generated to remote peer over signalling
    for (RTCIceCandidate cand in rtcIceCadidates) {
      channel!.sink.add(json.encode({
        "receiver": "agent",
        "type": "candidate",
        "data": [cand],
        "to": agentID
      }));
    }
  }

  void dailingSoundIsolateEntry(SendPort sendPort) async {
    //Initialize the audio player
    AudioPlayer audioPlayer = AudioPlayer();
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    await for (dynamic message in receivePort) {
      if (message is String) {
        if (message == 'play') {
          await audioPlayer.play(AssetSource(AppAssets.dailing));
          await audioPlayer.setReleaseMode(ReleaseMode.loop);
        } else if (message == 'stop') {
          await audioPlayer.stop();
        }
      }
    }
  }

  void updateCallState(int update) {
    setState(() {
      callState = update;
    });
  }
}
