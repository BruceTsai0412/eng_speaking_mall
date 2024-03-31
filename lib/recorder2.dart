import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart' as flutterSound;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Recorder2 extends StatefulWidget {
  @override
  _VideoTestState createState() => _VideoTestState();
}

class _VideoTestState extends State<Recorder2> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;
  late flutterSound.FlutterSoundRecorder _audioRecorder;
  late flutterSound.FlutterSoundPlayer _audioPlayer;
  late stt.SpeechToText _speech;
  String _transcription = '';
  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'FWG3Dfss3Jc',
      flags: YoutubePlayerFlags(
        autoPlay: false,
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
    _audioPlayer = flutterSound.FlutterSoundPlayer();
    _speech = stt.SpeechToText();

    _initializeRecorder();
    _initializePlayer();

    _getRecordingFilePath().then((path) {
      _recordingFilePath = path;
    });

    _startListening();
  }

  Future<void> _initializeRecorder() async {
    await _audioRecorder.openRecorder();
    _audioRecorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> _initializePlayer() async {
    await _audioPlayer.openPlayer();
    _audioPlayer.setSubscriptionDuration(const Duration(milliseconds: 10));
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

  Future<String> _getPlaybackFilePath() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String appDocPath = appDirectory.path;
    Directory audioDirectory = Directory('$appDocPath/audio');
    if (!audioDirectory.existsSync()) {
      audioDirectory.createSync(recursive: true);
    }
    return '${audioDirectory.path}/audio_playback.aac';
  }

  String? _recordingFilePath;
  String? _playbackFilePath;

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
        _playbackFilePath = _recordingFilePath;
        _stopListening();
        setState(() {
          _isRecording = false;
          _transcription = '';
       });
      } catch (e) {
        print('Error stopping recorder: $e');
      }
    } else {
      try {
        String filePath = await _getRecordingFilePath();
        await _audioRecorder.startRecorder(
          toFile: filePath,
          codec: flutterSound.Codec.aacADTS,
        );
        setState(() {
          _recordingFilePath = filePath;
          _isRecording = true;
        });
        _startListening();
      } catch (e) {
        print('Error starting recorder: $e');
      }
    }
  }

  Future<void> _playAudio() async {
    if (_playbackFilePath != null) {
      try {
        await _audioPlayer.startPlayer(
          fromURI: _playbackFilePath!,
          codec: flutterSound.Codec.aacADTS,
        );
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        print('Error starting player: $e');
      }
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print('Error stopping player: $e');
    }
  }

  Future<void> _undo() async {
    try {
      await _audioPlayer.stopPlayer();
      setState(() {
        _playbackFilePath = null;
        _isPlaying = false;
      });
      await _deleteFile(_playbackFilePath);
      await _getRecordingFilePath().then((path) {
        _recordingFilePath = path;
      });
      _stopListening();
      setState(() {
        _transcription = '';
      });
    } catch (e) {
      print('Error undoing recording: $e');
    }
  }

  Future<void> _startListening() async {
    await _speech.initialize();
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _transcription = result.recognizedWords!;
        });
      },
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _transcription = '';
    });
  }

  Future<void> _deleteFile(String? filePath) async {
    if (filePath != null && File(filePath).existsSync()) {
      await File(filePath).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Test'),
      ),
      backgroundColor: Color(0xffffcd45),
      body: SingleChildScrollView(
        child: Column(
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
              height: 300,
              width: 380,
              decoration: BoxDecoration(
                color: Color(0xfffcf3e3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Colors.black,
                        icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                        onPressed: _recordAudio,
                      ),
                      IconButton(
                        color: Colors.black,
                        icon:
                            Icon(_isPlaying ? Icons.pause : Icons.play_arrow),onPressed: _playbackFilePath != null
                            ? _playAudio
                            : null,
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.delete),
                        onPressed: _playbackFilePath != null
                            ? _undo
                            : null,
                      ),
                    ],
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Text(
                        _transcription,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Speech-to-Text Output:'),
                        Text(
                          _transcription,
                          maxLines: null,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_recordingFilePath != null)
              Text(_recordingFilePath!),
            if (_playbackFilePath != null)
              Text(_playbackFilePath!),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioRecorder.closeRecorder();
    _audioPlayer.closePlayer();
    _speech.stop();
    _speech.cancel();
    super.dispose();
  }
}