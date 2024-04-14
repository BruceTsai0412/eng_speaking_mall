import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Practice extends StatefulWidget {
  @override
  _VideoTestState createState() => _VideoTestState();
}

class _VideoTestState extends State<Practice> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;
  late stt.SpeechToText _speech;
  String _transcription = '';
  List<String> _sentences = [
    'Hello, how are you?',
    'I am doing well, thank you.',
    'What are you working on today?',
    'I am practicing my speaking skills.',
    'That is great, keep up the good work!',
  ];
  int _currentSentenceIndex = 0;
  Color _textColor = Colors.black;

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

    _speech = stt.SpeechToText();

    _initializeSpeech();

    _startListening();
  }

  Future<void> _initializeSpeech() async {
    await _speech.initialize();
  }

  Future<void> _startListening() async {
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _transcription = result.recognizedWords;
        });
      },
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _transcription = '';
    });
    if (_transcription == _sentences[_currentSentenceIndex]) {
      _textColor = Colors.green;
    } else {
      _textColor = Colors.red;
    }
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice'),
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
            ..._sentences.map((sentence) {
              return Container(
                margin: EdgeInsets.all(8.0),
                height: 180,
                width: 380,
                decoration: BoxDecoration(
                  color: Color(0xfffcf3e3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Speech-to-Text Output:',
                            style: TextStyle(color: _textColor),
                          ),
                          Text(
                            _transcription,
                            maxLines: null,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: _textColor),
                          ),
                          Text(
                            'Sentence to practice: ${sentence}',
                            maxLines: null,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                color: Colors.black,
                                icon: Icon(Icons.mic),
                                onPressed: _startListening,
                              ),
                              IconButton(
                                color: Colors.black,
                                icon: Icon(Icons.stop),
                                onPressed: _stopListening,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _speech.stop();
    _speech.cancel();
    super.dispose();
  }
}