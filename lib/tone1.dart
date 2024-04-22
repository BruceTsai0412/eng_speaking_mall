// ignore_for_file: unused_field
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as flutterSound;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Tone1 extends StatefulWidget {

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Tone1> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;
  late flutterSound.FlutterSoundRecorder _audioRecorder;
  late flutterSound.FlutterSoundPlayer _audioPlayer;
  bool _isRecording = false;
  bool _isRecordingInitialzed = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'fOONIlhXFh4',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        _controller.seekTo(Duration.zero);
      }
      if (_controller.value.position.inMinutes == 2 && _controller.value.position.inSeconds >= 25) {
        _controller.pause();
      }
    });
    
    _controller.seekTo(const Duration(minutes: 0, seconds: 52));

    _audioRecorder = flutterSound.FlutterSoundRecorder();
    _audioPlayer = flutterSound.FlutterSoundPlayer();

    _initializeRecorder();
    _initializePlayer();
    _getRecordingFilePath().then((path) {
      _recordingFilePath = path;
    });
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

  String? _recordingFilePath;
  String? _playbackFilePath;

  Future<void> _recordAudio() async {
  var status = await Permission.microphone.status;
  if (status!= PermissionStatus.granted) {
    status = await Permission.microphone.request();
    if (status!= PermissionStatus.granted) {
      print('Microphone permission not granted');
      return;
    }
  }

  if (!_isRecordingInitialzed) {
    _isRecordingInitialzed = true;
  }

  if (_isRecording) {
    try {
      await _audioRecorder.stopRecorder();
      _playbackFilePath = _recordingFilePath;
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print('Error stopping recorder: $e');
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return CountdownDialog(
          duration: const Duration(seconds: 5),
          onFinished: () async {
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
              _controller.play();
            } catch (e) {
              print('Error starting recorder: $e');
            }
          },
        );
      },
    );
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

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _stopAudio();
    } else {
      await _playAudio();
    }
  }

  void _undo() async {
    try {
      await _audioPlayer.stopPlayer();
      await _deleteFile(_playbackFilePath);
      setState(() {
        _isPlaying = false;
        _playbackFilePath = null;
      });
    } catch (e) {
      print('Error undoing recording: $e');
    }
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
        title: const Text('Record'),
      ),
      backgroundColor: const Color(0xffffcd45),
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
            const Text('Your Script:',
            style: TextStyle(fontSize: 20),
            maxLines: null,
            textAlign: TextAlign.center,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                height: 300,
                width: 380,
                decoration: BoxDecoration(
                  color: const Color(0xfffcf3e3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Text(
                                  'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                IconButton(
                  iconSize: 30,
                  color: _isRecording ? Colors.red : Colors.black,
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  onPressed: _recordAudio,
                ),
                IconButton(
                  iconSize: 30,
                  color: Colors.black,
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: _playbackFilePath != null? _togglePlayPause : null,
                ),
                IconButton(
                  iconSize: 30,
                  color: Colors.black,
                  icon: const Icon(Icons.undo),
                  onPressed: _playbackFilePath != null ? _undo : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_playbackFilePath!= null) {
                      await _playAudio();
                      _controller.play();
                      _controller.mute();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 38, 131, 50),
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  ),
                  child: const Text(
                    'Play!',
                    style: TextStyle(fontSize: 18, color: Color(0xffffffff)),
                  ),
                ),
              ],
            ),
            // if (_recordingFilePath != null) // For checking the recording path
            //   Text(_recordingFilePath!),
            // if (_playbackFilePath != null)
            //   Text(_playbackFilePath!),
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
    super.dispose();
  }
}

class CountdownDialog extends StatefulWidget {
  final Duration duration;
  final VoidCallback onFinished;

  const CountdownDialog({super.key, required this.duration, required this.onFinished});

  @override
  _CountdownDialogState createState() => _CountdownDialogState();
}

class _CountdownDialogState extends State<CountdownDialog> {
  late Timer _timer;
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _seconds = widget.duration.inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds <= 0) {
          _timer.cancel();
          widget.onFinished();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Image.asset('image/countdown.gif'),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}