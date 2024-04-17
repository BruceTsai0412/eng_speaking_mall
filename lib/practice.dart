import 'package:flutter/material.dart';
import 'package:learn_speak_app/recorder7.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
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
  List<List<Duration>> startEndTimes = [
    [Duration(seconds: 0), Duration(seconds: 6)],
    [Duration(seconds: 10), Duration(seconds: 15)],
    [Duration(seconds: 15), Duration(seconds: 20)],
    [Duration(seconds: 25), Duration(seconds: 30)],
    [Duration(seconds: 35), Duration(seconds: 40)],
  ];
    int _currentTimestampIndex = 0;

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
  }

  Future<void> _playAndPauseVideo(Duration startTime, Duration endTime) async {
    // Seek to the start time of the video
    _controller.seekTo(startTime);

    // Play the video
    _controller.play();

    // Wait for the end time to be reached
    await Future.delayed(endTime - startTime);

    // Pause the video
    _controller.pause();
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
  }

void _nextSentence() {
  setState(() {
    _currentSentenceIndex = (_currentSentenceIndex + 1) % _sentences.length;
    int index = (_currentTimestampIndex + 1) % startEndTimes.length;
    _playAndPauseVideo(startEndTimes[index][0], startEndTimes[index][1]);
    _currentTimestampIndex = index;
  });
  _stopListening();
}

void _previousSentence() {
  setState(() {
    _currentSentenceIndex = (_currentSentenceIndex - 1 + _sentences.length) % _sentences.length;
    int index = (_currentTimestampIndex - 1 + startEndTimes.length) % startEndTimes.length;
    _playAndPauseVideo(startEndTimes[index][0], startEndTimes[index][1]);
    _currentTimestampIndex = index;
  });
  _stopListening();
}

  // Function to split the sentence into words
  List<String> splitIntoWords(String sentence) {
    return (sentence.toLowerCase()).split(' ');
  }

  // Function to split the speech-to-text output into words
  List<String> splitSpeechIntoWords(String speech) {
    return (speech.toLowerCase()).split(' ');
  }

List<bool> compareWords(List<String> sentenceWords, List<String> speechWords) {
  List<bool> comparedWords = [];
  List<String> lowerCaseSentenceWords = sentenceWords.map((word) => word.toLowerCase()).toList();
  List<String> lowerCaseSpeechWords = speechWords.map((word) => word.toLowerCase()).toList();
  for (int i = 0; i < lowerCaseSentenceWords.length; i++) {
    bool match = lowerCaseSpeechWords.contains(lowerCaseSentenceWords[i]);
    print('Comparing ${lowerCaseSentenceWords[i]} to ${lowerCaseSpeechWords.join(', ')}: $match');
    comparedWords.add(match);
  }
  return comparedWords;
}

List<Text> splitDisplayingSentenceWithColors(String sentence) {
  List<String> sentenceWords = sentence.split(' ');
  List<Text> words = [];
  List<String> sentenceWordsNoPunctuation = sentenceWords.map((word) => word.replaceAll(RegExp(r'[.,!?;:]'), '')).toList();
  List<String> speechWords = splitSpeechIntoWords(_transcription);
  List<bool> comparedWords = compareWords(sentenceWordsNoPunctuation, speechWords);
  for (int i = 0; i < sentenceWords.length; i++) {
    TextStyle style;
    if (comparedWords[i]) {
      style = TextStyle(fontSize: 20, color: Colors.green);
    } else {
      style = TextStyle(fontSize: 20, color: Colors.red);
    }
    words.add(Text(sentenceWords[i] + ' ', style: style));
  }
  return words;
}

  // Function to color the matched and unmatched words
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
            Container(
              margin: EdgeInsets.all(15.0),
              height: 300,
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
                          'Sentence to practice:',
                          style: TextStyle(fontSize: 20),
                          maxLines: null,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: splitDisplayingSentenceWithColors(_sentences[_currentSentenceIndex]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 30,
                              color: Colors.black,
                              icon: Icon(Icons.mic),
                              onPressed: () {
                                _startListening();
                              },
                            ),
                            IconButton(
                              iconSize: 30,
                              color: Colors.black,
                              icon: Icon(Icons.stop),
                              onPressed: () {
                                _stopListening();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                            onPressed: () {
                              _playAndPauseVideo(startEndTimes[_currentTimestampIndex][0], startEndTimes[_currentTimestampIndex][1]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF264683),
                              padding: EdgeInsets.fromLTRB(30,10,30,10),
                            ),
                            child: Text(
                              'Listen',
                              style: const TextStyle(fontSize: 15, color: Color(0xffffffff)),
                            ),
                          ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _previousSentence,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF264683),
                    padding: EdgeInsets.fromLTRB(25,10,25,10),
                  ),
                  child: Text(
                    'Last Line',
                    style: const TextStyle(fontSize: 15, color: Color(0xffffffff)),
                  ),
                ),
                SizedBox(width: 60),
                ElevatedButton(
                  onPressed: _nextSentence,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF264683),
                    padding: EdgeInsets.fromLTRB(25,10,25,10),
                  ),
                  child: Text(
                    'Next Line',
                    style: const TextStyle(fontSize: 15, color: Color(0xffffffff)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Recorder7()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 38, 131, 50),
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                ),
                child: Text(
                  'Ready!',
                  style: const TextStyle(fontSize: 18, color: Color(0xffffffff)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}