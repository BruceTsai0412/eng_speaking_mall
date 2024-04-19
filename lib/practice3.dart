import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'record.dart';

class Practice3 extends StatefulWidget {
  final String movieName;
  final int sceneNumber;

  Practice3({super.key, required this.movieName, required this.sceneNumber});

    // Maps for startEndTimes, _sentences, and initialVideoId
    final Map<String, Map<int, List<List<Duration>>>> startEndTimesMap = {
      'La La Land': {
        1: [
          [Duration(seconds: 0), Duration(seconds: 6)],
          [Duration(seconds: 10), Duration(seconds: 15)],
          //...
        ],
        2: [
          [Duration(seconds: 0), Duration(seconds: 6)],
          [Duration(seconds: 10), Duration(seconds: 15)],
        ],
        //...
      },
      'Movie2': {
        //...
      },
      //...
    };

    final Map<String, Map<int, List<String>>> sentencesMap = {
      'La La Land': {
        1: [
          'Hello, how are you?',
          'I am doing well, thank you.',
          //...
        ],
        2: [
          'Hello, how are you?',
          'I am doing well, thank you.',
        ],
        //...
      },
      'Movie2': {
        //...
      },
      //...
    };

    final Map<String, Map<int, String>> initialVideoIdsMap = {
      'La La Land': {
        1: 'FWG3Dfss3Jc',
        2: 'FWG3Dfss3Jc',
        //...
      },
      'Movie2': {
        //...
      },
      //...
    };

  @override
  _VideoTestState createState() => _VideoTestState();
}

class _VideoTestState extends State<Practice3> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;
  late stt.SpeechToText _speech;
  String _transcription = '';
  late List<String> _sentences;
  int _currentSentenceIndex = 0;
  late List<List<Duration>> _startEndTimes;
  int _currentTimestampIndex = 0;
  late String _initialVideoId;

  @override
  void initState() {
    super.initState();

    // Get startEndTimes, _sentences, and initialVideoId from maps
    _startEndTimes = widget.startEndTimesMap[widget.movieName]![widget.sceneNumber]!;
    _sentences = widget.sentencesMap[widget.movieName]![widget.sceneNumber]!;
    _initialVideoId = widget.initialVideoIdsMap[widget.movieName]![widget.sceneNumber]!;

    _controller = YoutubePlayerController(
      initialVideoId: _initialVideoId,
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
    _controller.seekTo(startTime);
    _controller.play();
    await Future.delayed(endTime - startTime);
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
      int index = (_currentTimestampIndex + 1) % _startEndTimes.length;
      _playAndPauseVideo(_startEndTimes[index][0], _startEndTimes[index][1]);
      _currentTimestampIndex = index;
    });
    _stopListening();
  }

  void _previousSentence() {
    setState(() {
      _currentSentenceIndex = (_currentSentenceIndex - 1 + _sentences.length) % _sentences.length;
      int index = (_currentTimestampIndex - 1 + _startEndTimes.length) % _startEndTimes.length;
      _playAndPauseVideo(_startEndTimes[index][0], _startEndTimes[index][1]);
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
                              icon: Icon(Icons.transcribe),
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
                                _playAndPauseVideo(_startEndTimes[_currentTimestampIndex][0], _startEndTimes[_currentTimestampIndex][1]);
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
                    MaterialPageRoute(builder: (context) => Record(sentences: _sentences, initialVideoId: _initialVideoId,)),
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