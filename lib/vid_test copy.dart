import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_sound/flutter_sound.dart' as flutterSound;
import 'package:path_provider/path_provider.dart';

class VideoTestCopy extends StatefulWidget {
  @override
  _VideoTestState createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTestCopy> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;
  late flutterSound.FlutterSoundRecorder _audioRecorder;

  // Path for the recorded audio file
  String _recordingFilePath = '';

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'FWG3Dfss3Jc',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        _controller.seekTo(Duration.zero);
      }
    });

    _controller.addListener(() {
      setState(() {
        _playerValue = _controller.value;
      });
    });

    _audioRecorder = flutterSound.FlutterSoundRecorder();
    _audioRecorder.openRecorder().then((value) {
      _audioRecorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    });

    // Initialize the recording file path
    _getRecordingFilePath();
  }

    Future<void> _recordAudio() async {
    if (_audioRecorder.isRecording) {
      await _audioRecorder.stopRecorder();
    } else {
      String filePath = await _getRecordFilePath();
      await _audioRecorder.startRecorder(toFile: filePath);
    }

    setState(() {});
  }

  Future<String> _getRecordFilePath() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String appDocPath = appDirectory.path;
    Directory audioDirectory = Directory('$appDocPath/audio');
    if (!audioDirectory.existsSync()) {
      audioDirectory.createSync();
    }
    return '${audioDirectory.path}/audio.aac';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Test'),
      ),
      backgroundColor: Color(0xffffcd45),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            width: 380,
            height: 300,
            decoration: BoxDecoration(
              color: Color(0xfffcf3e3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: IconButton(
              color: Colors.black,
              icon: Icon(_audioRecorder.isRecording ? Icons.stop : Icons.mic),
              onPressed: _recordAudio,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    _controller.dispose();
    super.dispose();
  }
}