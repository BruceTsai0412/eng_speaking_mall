import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart' as flutterSound;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Recorder4 extends StatefulWidget {
  @override
  _VideoTestState createState() => _VideoTestState();
}

class _VideoTestState extends State<Recorder4> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;
  late flutterSound.FlutterSoundRecorder _audioRecorder;
  late flutterSound.FlutterSoundPlayer _audioPlayer;
  late stt.SpeechToText _speech;
  String _transcription = '';
  bool _isRecording = false;
  bool _isRecordingInitialzed = false;
  bool _isPlaying = false;
  bool _isTranscribing = false;
  List<String> _recordingFilePaths = [];
  int _currentIndex = 0;
  String? _playbackFilePath;

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

    _getRecordingFilePaths().then((paths) {
      setState(() {
        _recordingFilePaths = paths;
        _currentIndex = _recordingFilePaths.length - 1;
      });
    });

    _startListening();
  }

  Future<List<String>> _getRecordingFilePaths() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String appDocPath = appDirectory.path;
    Directory audioDirectory = Directory('$appDocPath/audio');
    if (!audioDirectory.existsSync()) {
      audioDirectory.createSync(recursive: true);
    }
    List<String> filePaths = [];
    audioDirectory.listSync().forEach((file) {
      if (file is File && file.path.endsWith('.aac')) {
        filePaths.add(file.path);
      }
    });
    return filePaths;
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
    String filePath = '${audioDirectory.path}/audio${_recordingFilePaths.length + 1}.aac';
    _recordingFilePaths.add(filePath);
    return filePath;
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

  Future<void> _recordAudio() async {
    if (_recordingFilePaths.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum number of recordings reached'),
        ),
      );
      return;
    }

    var status = await Permission.microphone.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        print('Microphone permission not granted');
        return;
      }
    }

    if (!_isRecordingInitialzed) {
      await _speech.initialize();
      _isRecordingInitialzed = true;
    }

    if (_isRecording) {
      try {
        await _audioRecorder.stopRecorder();
        _playbackFilePath = _recordingFilePaths[_currentIndex];
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
          _isRecording = true;
          _currentIndex = _recordingFilePaths.length - 1;
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
      if (_recordingFilePaths.isNotEmpty) {
        String lastFilePath = _recordingFilePaths.removeLast();
        await _deleteFile(lastFilePath);
        if (_currentIndex >= _recordingFilePaths.length) {
          _currentIndex--;
        }
        _playbackFilePath = _recordingFilePaths.isNotEmpty ? _recordingFilePaths.last : null;
      }
      _stopListening();
      setState(() {
        _transcription = '';
      });
    } catch (e) {
      print('Error undoing recording: $e');
    }
  }

  Future<void> _startListening() async {
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _transcription = result.recognizedWords;
        });
      },
    );
    setState(() {
      _isTranscribing = true;
    });
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _transcription = '';
_isTranscribing = false;
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
        title: Text('Rec4'),
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
                        icon: Icon(_isRecording
                            ? Icons.stop
                            : Icons.mic),
                        onPressed: _recordAudio,
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(_isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: _playbackFilePath !=
                            null
                            ? _playAudio
                            : null,
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(_isTranscribing
                            ? Icons.stop
                            : Icons.transcribe),
                        onPressed: _isTranscribing
                            ? _stopListening
                            : _startListening,
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.delete),
                        onPressed: _playbackFilePath !=
                            null
                            ? _undo
                            : null,
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.arrow_back),
                        onPressed: _currentIndex > 0
                            ? () {
                                setState(() {
                                  _currentIndex--;
                                  _playbackFilePath = _recordingFilePaths[_currentIndex];
                                });
                              }
                            : null,
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.arrow_forward),
                        onPressed: _currentIndex < _recordingFilePaths.length - 1
                            ? () {
                                setState(() {
                                  _currentIndex++;
                                  _playbackFilePath = _recordingFilePaths[_currentIndex];
                                });
                              }
                            : null,
                      ),
                    ],
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
            ..._recordingFilePaths.map((path) => Text(path)),
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