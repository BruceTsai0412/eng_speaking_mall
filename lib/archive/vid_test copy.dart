import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_sound/flutter_sound.dart' as flutterSound;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoTestCopy extends StatefulWidget {
  @override
  _VideoTestState createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTestCopy> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;
  late flutterSound.FlutterSoundRecorder _audioRecorder;

  String? _recordingFilePath;
  bool _isRecording = false;

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
    _getRecordingFilePath().then((path) {
      _recordingFilePath = path;
    });
  }

  Future<String> _getRecordingFilePath() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String appDocPath = appDirectory.path;
    Directory audioDirectory = Directory('$appDocPath/audio');
    if (!audioDirectory.existsSync()) {
      audioDirectory.createSync(recursive: true);
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
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              onPressed: _recordAudio,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          if (_recordingFilePath != null)
            Text(_recordingFilePath!),

        ],
      ),
    );
  }

  Future<void> _recordAudio() async {
    var status = await Permission.microphone.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        print('Microphone permission not granted');
        return;
      }
    }

    if (_isRecording) {
      try {
        await _audioRecorder.stopRecorder();
      } catch (e) {
        print('Error stopping recorder: $e');
      }
    } else {
      try {
        String filePath = await _getRecordingFilePath();
        await _audioRecorder.startRecorder(toFile: filePath);
        setState(() {
          _recordingFilePath = filePath;
          _isRecording = true;
        });
      } catch (e) {
        print('Error starting recorder: $e');
      }
    }

    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
void dispose() {
    _controller.dispose();
    _audioRecorder.closeRecorder();
    super.dispose();
  }
}