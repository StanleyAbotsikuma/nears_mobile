import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../configs/connections.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  // videoRenderer for localPeer
  final _localRTCVideoRenderer = RTCVideoRenderer();

  // videoRenderer for remotePeer
  final _remoteRTCVideoRenderer = RTCVideoRenderer();

  // mediaStream for localPeer
  MediaStream? _localStream;

  // RTC peer connection
  RTCPeerConnection? _rtcPeerConnection;

  // list of rtcCandidates to be sent over signalling
  List<RTCIceCandidate> rtcIceCadidates = [];
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  WebSocketChannel? channel;
  // media status
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  Future<void> initWebSocket() async {
    final accessToken = await secureStorage.read(key: "accessToken");
    final wsUrl = Uri.parse(
        "${AppConnections.wsType}${AppConnections.host}ws/test/sdfsdf/?token=${accessToken!}");
    channel = WebSocketChannel.connect(wsUrl);
    channel!.stream.listen(onMessageReceived, onError: onError, onDone: onDone);
  }

  void disposeWebSocket() {
    if (channel != null) {
      channel!.sink.close();
      channel = null;
    }
  }

  void onMessageReceived(dynamic message) {
    try {
      final Map<String, dynamic> data = json.decode(message.toString());
      print(data);
      // print(data);
      if (data['receiver'].toString() == "caller") {
        switch (data['type']) {
          case "offer":
            // handleOffer(data['data'].toString(), channel);

            handleOffer(data['data'][0], data['data'][1]);
            break;
          case "candidate":
            _rtcPeerConnection!.addCandidate(RTCIceCandidate(
              data['data'][0],
              data['data'][1],
              data['data'][2],
            ));
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
    print('WebSocket error occurred: $error');
  }

  void onDone() {
    print('WebSocket channel closed');
  }

  @override
  void initState() {
    _localRTCVideoRenderer.initialize();
    _remoteRTCVideoRenderer.initialize();
    init();
    initWebSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                RTCVideoView(
                  _localRTCVideoRenderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(isAudioOn ? Icons.mic : Icons.mic_off),
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
                    icon: Icon(isVideoOn ? Icons.videocam : Icons.videocam_off),
                    onPressed: _toggleCamera,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  init() async {
    // create peer connection
    _rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': ['stun:stun2.l.google.com:19302']
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
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });

    // add mediaTrack to peerConnection
    _localStream!.getTracks().forEach((track) {
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });

    // set source for local video renderer
    _localRTCVideoRenderer.srcObject = _localStream;
    setState(() {});
    _rtcPeerConnection!.onIceCandidate =
        (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);
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

  void dispose() {
    _localRTCVideoRenderer.dispose();
    _remoteRTCVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    disposeWebSocket();
    super.dispose();
  }

  Future<void> handleOffer(type, offer) async {
    await _rtcPeerConnection!.setRemoteDescription(
      RTCSessionDescription(
        offer,
        type,
      ),
    );

    // create SDP answer
    RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();
    channel!.sink.add(json.encode({
      "receiver": "agent",
      "type": "answer",
      "data": [answer.type, answer.sdp]
    }));
    // set SDP answer as localDescription for peerConnection
    _rtcPeerConnection!.setLocalDescription(answer);
    // send iceCandidate generated to remote peer over signalling
    for (RTCIceCandidate candidate in rtcIceCadidates) {
      channel!.sink.add(json.encode({
        "receiver": "agent",
        "type": "candidate",
        "data": [candidate]
      }));
    }
  }
}
