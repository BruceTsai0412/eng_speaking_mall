import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STT App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and speak';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STT App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                _text,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.stop : Icons.mic),
          ),
        ],
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            if (result.recognizedWords.isNotEmpty) {
              setState(() {
                _text = result.recognizedWords;
              });
              print(result.recognizedWords);
            }
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}