// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:flutter_sound/flutter_sound.dart' as flutterSound;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class RecTestCopy extends StatefulWidget {
//   @override
//   _VideoTestState createState() => _VideoTestState();
// }

// class _VideoTestState extends State<RecTestCopy> {
//   late YoutubePlayerController _controller;
//   YoutubePlayerValue? _playerValue;
//   late flutterSound.FlutterSoundRecorder _audioRecorder;

//   String? _recordingFilePath;
//   bool _isRecording = false;
//   Duration _recordDuration = Duration.zero;
//   Duration _maxDuration = Duration(seconds: 10);

//   Timer? _durationTimer;

//   // Play button
//   bool _isPlaying = false;
//   flutterSound.FlutterSoundPlayer? _audioPlayer;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: 'FWG3Dfss3Jc',
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     )..addListener(() {
//         if (_controller.value.playerState == PlayerState.ended) {
//           _controller.seekTo(Duration.zero);
//         }
//       });

//     _controller.addListener(() {
//       setState(() {
//         _playerValue = _controller.value;
//       });
//     });

//     _audioRecorder = flutterSound.FlutterSoundRecorder();
//     _audioRecorder.openRecorder().then((value) {
//       _audioRecorder.setSubscriptionDuration(const Duration(milliseconds: 500));
//     });

//     // Initialize the recording file path
//     _getRecordingFilePath().then((path) {
//       _recordingFilePath = path;
//     });

//     // Start the recording duration timer
//     _durationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_isRecording) {
//         setState(() {
//           _recordDuration += Duration(seconds: 1);
//         });
//       }
//     });

//     // Initialize the audio player
//     _audioPlayer = flutterSound.FlutterSoundPlayer();
//     _audioPlayer!.openPlayer().then((value) {
//       _audioPlayer!.setSubscriptionDuration(const Duration(milliseconds: 500));
//     });
//   }

//   Future<String> _getRecordingFilePath() async {
//     Directory appDirectory = await getApplicationDocumentsDirectory();
//     String appDocPath = appDirectory.path;
//     Directory audioDirectory = Directory('$appDocPath/audio');
//     if (!audioDirectory.existsSync()) {
//       audioDirectory.createSync(recursive: true);
//     }
//     return '${audioDirectory.path}/audio.aac';
//   }

//   @override
//   Widget build(BuildContext context) {

//     if (_recordingFilePath == null) {
//       _isPlaying = false;
//     } else {
//       _isPlaying = _audioPlayer != null && _audioPlayer!.isPlaying;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Test'),
//       ),
//       backgroundColor: Color(0xffffcd45),
//       body: Column(
//         children: [
//           YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: Colors.amber,
//             progressColors: const ProgressBarColors(
//               playedColor: Colors.amber,
//               handleColor: Colors.amberAccent,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(8.0),
//             width: 380,
//             height: 300,
//             decoration: BoxDecoration(
//               color: Color(0xfffcf3e3),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: Colors.black,
//                 width: 1.5,
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment:MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: IconButton(
//                         icon: Icon(
//                           _isRecording
//                               ? Icons.stop
//                               : Icons.mic,
//                           size: 36,
//                         ),
//                         color: Colors.black,
//                         onPressed: () {
//                           _recordAudio();
//                         },
//                       ),
//                     ),
//                     if (_recordingFilePath != null)
//                       Container(
//                         margin: EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: IconButton(
//                           icon: Icon(
//                             _isPlaying
//                               ? _audioPlayer!.isStopped
//                                   ? Icons.pause
//                                   : Icons.play_arrow
//                               : Icons.play_arrow,
//                               size: 36,
//                             ),
//                             color: Colors.black,
//                             onPressed: () {
//                               if (_audioPlayer!.playerState == flutterSound.PlayerState.isPlaying) {
//                                 _audioPlayer!.pausePlayer();
//                                 setState(() {
//                                   _isPlaying = false;
//                                 });
//                               } else {
//                                 if (_isPlaying) {
//                                   _audioPlayer!.resumePlayer();
//                                 } else {
//                                   _playAudio();
//                                 }
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 3,
//                       child: LinearProgressIndicator(
//                         value: _recordDuration.inSeconds / _maxDuration.inSeconds,
//                         backgroundColor: Color(0xFF666464),
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                       ),
//                     ),
//                   Text(
//                     'Time:${_recordDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_recordDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
//                   ),
//                   Text(
//                     'Max:${_maxDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_maxDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
//                   ),
//                   if (_recordingFilePath != null)
//                     Text('Recording: $_recordingFilePath'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Future<void> _playAudio() async {
//     if (_recordingFilePath != null) {
//       await _audioPlayer!.startPlayer(fromURI: _recordingFilePath!);
//       _audioPlayer!.positionStream.listen((playerState) {
//         if (playerState.position != null) {
//           setState(() {
//             _recordDuration = playerState.position;
//           });
//         }
//       });
//     }
//   }

//   Future<void> _recordAudio() async {
//     var status = await Permission.microphone.status;
//     if (status != PermissionStatus.granted) {
//       status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         print('Microphone permission not granted');
//         return;
//       }
//     }

//     setState(() {
//       _isRecording = !_isRecording;
//     });

//     if (_isRecording) {
//       String filePath = await _getRecordingFilePath();
//       await _audioRecorder.startRecorder(toFile: filePath);
//       _durationTimer?.cancel();
//       _durationTimer =
//           Timer.periodic(Duration(seconds: 1), (timer) {
//         if (_isRecording) {
//           setState(() {
//             _recordDuration += Duration(seconds: 1);
//           });
//         }
//       });
//     } else {
//       await _audioRecorder.stopRecorder();
//       _recordingFilePath = await _getRecordingFilePath();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _audioPlayer!.closePlayer();
//     _audioRecorder.closeRecorder();
//     super.dispose();
//   }
// }