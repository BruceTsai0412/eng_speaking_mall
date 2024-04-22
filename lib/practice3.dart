import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'record.dart';

class Practice3 extends StatefulWidget {
  final String movieName;
  final int sceneNumber;

  Practice3({super.key, required this.movieName, required this.sceneNumber});

    final Map<String, Map<int, List<List<Duration>>>> startEndTimesMap = {
      'Notting Hill': {
        1: [
          [Duration(minutes: 1, seconds: 27), Duration(minutes: 1, seconds: 31)],
          [Duration(minutes: 1, seconds: 31), Duration(minutes: 1, seconds: 33)],
          [Duration(minutes: 1, seconds: 33), Duration(minutes: 1, seconds: 36)],
          [Duration(minutes: 1, seconds: 36), Duration(minutes: 1, seconds: 41)],
          [Duration(minutes: 1, seconds: 39), Duration(minutes: 1, seconds: 43)],
        ],
        2: [
          [Duration(minutes: 2, seconds: 7), Duration(minutes: 2, seconds: 10)],
          [Duration(minutes: 2, seconds: 10), Duration(minutes: 2, seconds: 13)],
          [Duration(minutes: 2, seconds: 13), Duration(minutes: 2, seconds: 17)],
          [Duration(minutes: 2, seconds: 17), Duration(minutes: 2, seconds: 20)],
          [Duration(minutes: 2, seconds: 20), Duration(minutes: 2, seconds: 24)],
          [Duration(minutes: 2, seconds: 23), Duration(minutes: 2, seconds: 26)],
        ]
      },
      'Titanic': {
        1: [
          [Duration(minutes: 0, seconds: 0), Duration(minutes: 0, seconds: 1)],
          [Duration(minutes: 0, seconds: 1), Duration(minutes: 0, seconds: 5)],
          [Duration(minutes: 0, seconds: 6), Duration(minutes: 0, seconds: 9)],
          [Duration(minutes: 0, seconds: 9), Duration(minutes: 0, seconds: 15)],
          [Duration(minutes: 0, seconds: 26), Duration(minutes: 0, seconds: 27)],
          [Duration(minutes: 0, seconds: 28), Duration(minutes: 0, seconds: 30)],
          [Duration(minutes: 0, seconds: 31), Duration(minutes: 0, seconds: 35)],
          [Duration(minutes: 0, seconds: 35), Duration(minutes: 0, seconds: 37)],
        ],
        2: [
          [Duration(minutes: 0, seconds: 1), Duration(minutes: 0, seconds: 5)],
          [Duration(minutes: 0, seconds: 6), Duration(minutes: 0, seconds: 9)],
          [Duration(minutes: 0, seconds: 13), Duration(minutes: 0, seconds: 17)],
          [Duration(minutes: 0, seconds: 17), Duration(minutes: 0, seconds: 19)],
          [Duration(minutes: 0, seconds: 30), Duration(minutes: 0, seconds: 33)],
          [Duration(minutes: 0, seconds: 39), Duration(minutes: 0, seconds: 42)]
        ]
      },
      'Jurassic Park': {
        1: [
          [Duration(minutes: 0, seconds: 47), Duration(minutes: 0, seconds: 54)],
          [Duration(minutes: 1, seconds: 2), Duration(minutes: 1, seconds: 9)],
          [Duration(minutes: 1, seconds: 10), Duration(minutes: 1, seconds: 15)],
          [Duration(minutes: 1, seconds: 30), Duration(minutes: 1, seconds: 33)],
          [Duration(minutes: 1, seconds: 35), Duration(minutes: 1, seconds: 40)],
          [Duration(minutes: 1, seconds: 49), Duration(minutes: 1, seconds: 53)],
          [Duration(minutes: 2, seconds: 1), Duration(minutes: 2, seconds: 4)],
          [Duration(minutes: 2, seconds: 4), Duration(minutes: 2, seconds: 7)]
        ],
        2: [
          [Duration(minutes: 2, seconds: 20), Duration(minutes: 2, seconds: 24)],
          [Duration(minutes: 2, seconds: 24), Duration(minutes: 2, seconds: 26)],
          [Duration(minutes: 2, seconds: 26), Duration(minutes: 2, seconds: 29)],
          [Duration(minutes: 2, seconds: 28), Duration(minutes: 2, seconds: 29)],
          [Duration(minutes: 2, seconds: 29), Duration(minutes: 2, seconds: 31)],
          [Duration(minutes: 2, seconds: 32), Duration(minutes: 2, seconds: 34)],
          [Duration(minutes: 2, seconds: 35), Duration(minutes: 2, seconds: 40)],
          [Duration(minutes: 2, seconds: 40), Duration(minutes: 2, seconds: 42)]
        ]
      },
      'The Princess Diaries': {
        1: [
          [Duration(minutes: 0, seconds: 7), Duration(minutes: 0, seconds: 10)],
          [Duration(minutes: 0, seconds: 10), Duration(minutes: 0, seconds: 12)],
          [Duration(minutes: 0, seconds: 15), Duration(minutes: 0, seconds: 17)],
          [Duration(minutes: 0, seconds: 17), Duration(minutes: 0, seconds: 20)],
          [Duration(minutes: 0, seconds: 27), Duration(minutes: 0, seconds: 29)]
        ],
        2: [
          [Duration(minutes: 1, seconds: 45), Duration(minutes: 1, seconds: 48)],
          [Duration(minutes: 1, seconds: 48), Duration(minutes: 1, seconds: 50)],
          [Duration(minutes: 1, seconds: 51), Duration(minutes: 1, seconds: 53)],
          [Duration(minutes: 1, seconds: 54), Duration(minutes: 1, seconds: 57)],
          [Duration(minutes: 1, seconds: 58), Duration(minutes: 2, seconds: 0)],
          [Duration(minutes: 2, seconds: 3), Duration(minutes: 2, seconds: 6)],
          [Duration(minutes: 2, seconds: 8), Duration(minutes: 2, seconds: 16)],
          [Duration(minutes: 2, seconds: 17), Duration(minutes: 2, seconds: 20)]
        ]
      },
      'Men In Black': {
        1: [
          [Duration(minutes: 0, seconds: 4), Duration(minutes: 0, seconds: 6)],
          [Duration(minutes: 0, seconds: 8), Duration(minutes: 0, seconds: 10)],
          [Duration(minutes: 0, seconds: 10), Duration(minutes: 0, seconds: 13)],
          [Duration(minutes: 0, seconds: 13), Duration(minutes: 0, seconds: 15)],
          [Duration(minutes: 0, seconds: 15), Duration(minutes: 0, seconds: 17)],
          [Duration(minutes: 0, seconds: 20), Duration(minutes: 0, seconds: 22)],
          [Duration(minutes: 0, seconds: 22), Duration(minutes: 0, seconds: 27)]
        ],
        2: [
          [Duration(minutes: 0, seconds: 39), Duration(minutes: 0, seconds: 42)],
          [Duration(minutes: 0, seconds: 42), Duration(minutes: 0, seconds: 46)],
          [Duration(minutes: 0, seconds: 46), Duration(minutes: 0, seconds: 48)],
          [Duration(minutes: 0, seconds: 48), Duration(minutes: 0, seconds: 49)],
          [Duration(minutes: 0, seconds: 50), Duration(minutes: 0, seconds: 53)]
        ]
      },
      'Back to the Future':{
        1: [
          [Duration(minutes: 2, seconds: 12), Duration(minutes: 2, seconds: 14)],
          [Duration(minutes: 2, seconds: 59), Duration(minutes: 3, seconds: 1)],
          [Duration(minutes: 3, seconds: 1), Duration(minutes: 3, seconds: 2)],
          [Duration(minutes: 3, seconds: 4), Duration(minutes: 3, seconds: 7)],
          [Duration(minutes: 3, seconds: 10), Duration(minutes: 3, seconds: 14)]
        ],
        2:[
          [Duration(minutes: 3, seconds: 17), Duration(minutes: 3, seconds: 18)],
          [Duration(minutes: 3, seconds: 19), Duration(minutes: 3, seconds: 21)],
          [Duration(minutes: 3, seconds: 21), Duration(minutes: 3, seconds: 24)],
          [Duration(minutes: 3, seconds: 24), Duration(minutes: 3, seconds: 27)],
          [Duration(minutes: 3, seconds: 27), Duration(minutes: 3, seconds: 30)]
        ]
      },
      'Bucket List':{
        1: [
          [Duration(minutes: 0, seconds: 3), Duration(minutes: 0, seconds: 4)],
          [Duration(minutes: 0, seconds: 5), Duration(minutes: 0, seconds: 7)],
          [Duration(minutes: 0, seconds: 10), Duration(minutes: 0, seconds: 14)],
          [Duration(minutes: 0, seconds: 14), Duration(minutes: 0, seconds: 22)],
          [Duration(minutes: 0, seconds: 27), Duration(minutes: 0, seconds: 33)],
          [Duration(minutes: 0, seconds: 39), Duration(minutes: 0, seconds: 42)],
          [Duration(minutes: 0, seconds: 44), Duration(minutes: 0, seconds: 45)]
        ],
        2:[
          [Duration(minutes: 0, seconds: 46), Duration(minutes: 0, seconds: 51)],
          [Duration(minutes: 0, seconds: 57), Duration(minutes: 1, seconds: 2)],
          [Duration(minutes: 1, seconds: 3), Duration(minutes: 1, seconds: 11)],
          [Duration(minutes: 1, seconds: 14), Duration(minutes: 1, seconds: 19)],
          [Duration(minutes: 1, seconds: 23), Duration(minutes: 1, seconds: 31)],
          [Duration(minutes: 1, seconds: 33), Duration(minutes: 1, seconds: 40)]
        ]
      },
      "Inception":{
        1:[
            [Duration(minutes: 1, seconds: 0), Duration(minutes: 1, seconds: 2)],
            [Duration(minutes: 1, seconds: 2), Duration(minutes: 1, seconds: 5)],
            [Duration(minutes: 1, seconds: 5), Duration(minutes: 1, seconds: 10)],
            [Duration(minutes: 1, seconds: 10), Duration(minutes: 1, seconds: 11)],
            [Duration(minutes: 1, seconds: 11), Duration(minutes: 1, seconds: 13)],
            [Duration(minutes: 1, seconds: 13), Duration(minutes: 1, seconds: 16)],
            [Duration(minutes: 1, seconds: 16), Duration(minutes: 1, seconds: 17)]
          ],
          2: [
            [Duration(minutes: 0, seconds: 0), Duration(minutes: 0, seconds: 3)],
            [Duration(minutes: 0, seconds: 3), Duration(minutes: 0, seconds: 4)],
            [Duration(minutes: 0, seconds: 4), Duration(minutes: 0, seconds: 5)],
            [Duration(minutes: 0, seconds: 5), Duration(minutes: 0, seconds: 8)],
            [Duration(minutes: 0, seconds: 8), Duration(minutes: 0, seconds: 12)]
          ]
      },
      "Soul":{
        1:[
            [Duration(minutes: 1, seconds: 52), Duration(minutes: 1, seconds: 55)],
            [Duration(minutes: 1, seconds: 55), Duration(minutes: 1, seconds: 57)],
            [Duration(minutes: 1, seconds: 59), Duration(minutes: 2, seconds: 2)],
            [Duration(minutes: 2, seconds: 2), Duration(minutes: 2, seconds: 5)],
            [Duration(minutes: 2, seconds: 7), Duration(minutes: 2, seconds: 8)],
            [Duration(minutes: 2, seconds: 9), Duration(minutes: 2, seconds: 15)],
            [Duration(minutes: 2, seconds: 18), Duration(minutes: 2, seconds: 19)]
          ],
          2: [
            [Duration(minutes: 2, seconds: 23), Duration(minutes: 2, seconds: 25)],
            [Duration(minutes: 2, seconds: 26), Duration(minutes: 2, seconds: 28)],
            [Duration(minutes: 2, seconds: 28), Duration(minutes: 2, seconds: 31)],
            [Duration(minutes: 2, seconds: 31), Duration(minutes: 2, seconds: 33)],
            [Duration(minutes: 2, seconds: 33), Duration(minutes: 2, seconds: 35)],
            [Duration(minutes: 2, seconds: 35), Duration(minutes: 2, seconds: 38)],
            [Duration(minutes: 2, seconds: 38), Duration(minutes: 2, seconds: 40)]
          ]
      },
      "Inside Out":{
        1:[
          [Duration(minutes: 0, seconds: 0), Duration(minutes: 0, seconds: 2)],
          [Duration(minutes: 0, seconds: 2), Duration(minutes: 0, seconds: 4)],
          [Duration(minutes: 0, seconds: 4), Duration(minutes: 0, seconds: 5)],
          [Duration(minutes: 0, seconds: 6), Duration(minutes: 0, seconds: 9)],
          [Duration(minutes: 0, seconds: 9), Duration(minutes: 0, seconds: 10)],
          [Duration(minutes: 0, seconds: 10), Duration(minutes: 0, seconds: 11)]
        ],
        2: [
          [Duration(minutes: 0, seconds: 28), Duration(minutes: 0, seconds: 31)],
          [Duration(minutes: 0, seconds: 33), Duration(minutes: 0, seconds: 35)],
          [Duration(minutes: 0, seconds: 35), Duration(minutes: 0, seconds: 37)],
          [Duration(minutes: 0, seconds: 37), Duration(minutes: 0, seconds: 38)],
          [Duration(minutes: 0, seconds: 38), Duration(minutes: 0, seconds: 40)],
          [Duration(minutes: 0, seconds: 40), Duration(minutes: 0, seconds: 42)]
        ]
      },
      'Charlie and the Chocolate\n                Factory':{
        1:[
          [Duration(minutes: 0, seconds: 2), Duration(minutes: 0, seconds: 3)],
          [Duration(minutes: 0, seconds: 4), Duration(minutes: 0, seconds: 6)],
          [Duration(minutes: 0, seconds: 7), Duration(minutes: 0, seconds: 9)],
          [Duration(minutes: 0, seconds: 12), Duration(minutes: 0, seconds: 17)],
          [Duration(minutes: 0, seconds: 21), Duration(minutes: 0, seconds: 23)],
          [Duration(minutes: 0, seconds: 25), Duration(minutes: 0, seconds: 27)],
          [Duration(minutes: 0, seconds: 30), Duration(minutes: 0, seconds: 41)],
          [Duration(minutes: 0, seconds: 49), Duration(minutes: 0, seconds: 54)],
          [Duration(minutes: 0, seconds: 59), Duration(minutes: 1, seconds: 0)],
          [Duration(minutes: 1, seconds: 3), Duration(minutes: 1, seconds: 4)]
        ]
      },
      'The Hunger Games':{
        1:[
          [Duration(minutes: 0, seconds: 12), Duration(minutes: 0, seconds: 15)],
          [Duration(minutes: 0, seconds: 16), Duration(minutes: 0, seconds: 19)],
          [Duration(minutes: 0, seconds: 20), Duration(minutes: 0, seconds: 21)],
          [Duration(minutes: 0, seconds: 21), Duration(minutes: 0, seconds: 23)],
          [Duration(minutes: 0, seconds: 24), Duration(minutes: 0, seconds: 28)]
        ],
        2:[
          [Duration(minutes: 1, seconds: 0), Duration(minutes: 1, seconds: 3)],
          [Duration(minutes: 1, seconds: 4), Duration(minutes: 1, seconds: 6)],
          [Duration(minutes: 1, seconds: 8), Duration(minutes: 1, seconds: 11)],
          [Duration(minutes: 1, seconds: 12), Duration(minutes: 1, seconds: 17)],
          [Duration(minutes: 1, seconds: 17), Duration(minutes: 1, seconds: 24)],
          [Duration(minutes: 1, seconds: 24), Duration(minutes: 1, seconds: 27)],
          [Duration(minutes: 1, seconds: 28), Duration(minutes: 1, seconds: 31)]
        ]
      },
    };

    final Map<String, Map<int, List<String>>> sentencesMap = {
      'Notting Hill': {
        1: [
          "I saw you put that book down your trousers.",
          "What book?",
          "The one down your trousers.",
          "I don't have a book down my trousers.",
          "Right. I tell you what, I'll call the police.",
        ],
        2: [
          "Sorry about that.",
          "No, that's fine.",
          "I was going to steal one myself but now I've changed my mind.",
          "Signed by the author, I see.",
          "Yah, we couldn't stop him.",
          "If you can find an unsigned one, it's worth an absolute fortune.",
        ],
      },
      'Titanic': {
        1: [
          "Don't do it.",
          "Stay back. Don't come any closer.",
          "Come on. Just give me your hand. I'll pull you back over.",
          "No! Stay where you are. I mean it. I'll let go.",
          "No,you won't.",
          "What do you mean, no, I won't?",
          "Don't presume to tell me what I will and will not do. You don't know me.",
          "Well,you would have done it already.",
        ],
        2: [
          "Now hold on to the railing. Keep your eyes closed, don't peek."
          "Step up onto the rail.",
          "Hold on. Hold on. Keep your eyes closed.",
          "Do you trust me?",
          "All right, open your eyes.",
          "I'm flying! Jack!",
        ],
      },
      'Jurassic Park': {
        1: [
          "I see her as one of my favorite when I was a kid, and now I say she is the most beautiful thing I have ever saw.",
          "Micro vesicles.  That's interesting. ... What are her symptoms?",
          "Imbalance, disorientation, labored breathing. Seems to happen about every six weeks or so.",
          "These are dilated. Take a look.",
          "That's pharmacological. From local plant life.",
          "Yes. We know they're toxic, but the animals don't eat them.",
          "There's only one way to be positive.",
          "I have to see the dinosaur's droppings.",
        ],
        2: [
          "That storm center hasn't dissipated or changed course."
          "We're going to have to cut the tour short, I'm afraid.",
          "Pick it up again tomorrow where we left off.",
          "You're sure we have to?",
          "It's not worth taking the chance, John.",
          "Tell them when they get back to the cars.",
          "Ladies and gentlemen, last shuttle to the dock leaves in approximately five minutes.",
          "Drop what you are doing and leave now.",
        ],
      },
      'The Princess Diaries': {
        1: [
          "The school tours are on Saturday, young lady.",
          "I'm here for a meeting with my grandmother.",
          "Please come to the front door.",
          "Thank you very much.",
          "Get off the grass!",
        ],
        2: [
          "Now, if you will sit down, she will be with you in a moment."
          "No. I don't need a moment. I'm here.",
          "Amelia, I'm so glad you could come.",
          "You've got a great place.",
          "Let me look at you.",
          "You look so... young.",
          "Thank you. And you look so ... ... clean.",
          "Charlotte, would you go and check on tea in the garden?",
        ],
      },
      'Men In Black': {
        1: [
          "Where are you going?",
          "Hey, man, what the hell is all this?",
          "In the mid-1950s the government started an underfunded agency",
          "with the simple and laughable purpose of establishing contact",
          "with a race not of this planet.",
          "Everyone thought the agency was a joke,",
          "except the aliens who made contact March 2 1961, outside New York.",
          
        ],
        2: [
          "They were a group of intergalactic refugees."
          "Wanted Earth for an apolitical zone for creatures without a planet.",
          "Did you ever see 'Casablanca'?",
          "Same thing, except no Nazis.",
          "We agreed and concealed all the evidence of their landing.",
        ],
      },
      'Back to the Future': {
        1: [
          "Look out!",
          "What, what is it, hot?",
          "It's cold, damn cold!",
          "Ha, ha, ha, Einstein, you little devil.",
          "Einstein's clock is exactly one minute behind mine, it's still ticking.",
          
        ],
        2: [
          "He's alright."
          "He's fine, and he's completely unaware that anything happened.",
          "As far as he's concerned the trip was instantaneous.",
          "That's why Einstein's watch is exactly one minute behind mine.",
          "He skipped over that minute to instantly arrive at this moment in time.",
        ],
      },
      'Bucket List': {
        1: [
          "Good afternoon.",
          "My name is Edward Cole.",
          "I do not know what most people say on these occasions.",
          "In all honesty... I've tried to avoid them.",
          "The simplest thing is, I loved him... and I miss him.",
          "Carter, and I saw the world together.",
          "It is amazing.",
          
        ],
        2: [
          "When you think, that only three months ago, we were complete strangers."
          "I hope it doesn't sound selfish of me.",
          "But the last months of his life... were the best months of mine.",
          "He saved my life, and he knew it before I did.",
          "I am proud... that this man, found it worth is while... to know me.",
          "In the end... I think it's safe to say, that we brought some joy, to one anothers lifes.",
        ],
      },
      'Inception': {
        1:[
          "Why are they all looking at me?",
          "Because my subconscious feels that someone else is creating this world.",
          "The more you change things, the quicker the projections start to converge on you.",
          "Converge?",
          "They sense the foreign nature of the dreamer.",
          "They attack, like white blood cells fighting an infection.",
          "Just you.",
        ],
        2:[
          "When we're asleep, our mind can do almost anything.",
          "Such as?",
          "Imagine you're designing a building.",
          "You consciously create each aspect.",
          "But sometimes, it feels like it's almost creating itself, if you know what I mean.",
        ]
      },
      'Soul': {
        1:[
          "You play 100 shows, and one of them is killer.",
          "You don't get many like tonight.",
          "So, uh, what happens next?",
          "We come back tomorrow night and do it all again.",
          "What's wrong, Teach?",
          "It's just I've been waiting on this day for my entire life.",
          "I thought I'd feel different.",
        ],
        2:[
          "I heard this story about a fish.",
          "He swims up to this older fish and says, ",
          "I'm trying to find this thing they call the 'ocean.'",
          "'The ocean?' says the older fish.",
          "'That's what you're in right now.'",
          "'This?' says the young fish. 'This is water.'",
          "What I want is the ocean.'",
        ]
      },
      'Inside Out': {
        1:[
          "First day of school. Very, very exciting.",
          "I was up late last night figuring out a new plan",
          "Here it is:",
          "Fear! I need a list of all the possible negative outcomes on the first day at a new school.",
          "Way ahead of you there.",
          "Does anyone know how to spell meteor?",
        ],
        2:[
          "Train of Thought, right on schedule.",
          "Anger, unload the daydreams.",
          "I ordered extra, in case things get slow in class.",
          "Might come in handy.",
          "If this new school is full of boring, useless classes.",
          "Which it probably will be.",
        ]
      },
      'Charlie and the Chocolate\n                Factory': {
        1:[
          "Then I'm not going.",
          "I wouldn't give up my family for anything. ",
          "Not for all the chocolate in the world.",
          "Oh, I see… that's weird.",
          "There's other candy too besides chocolate!",
          "I'm sorry, Mr. Wonka. I'm staying here.",
          "Wow. Well, that's just unexpected and… weird.",
          "But I suppose in that case, I'll just… goodbye, then.",
          "Sure you won't change your mind, then?",
          "I'm sure.",
        ]
      },
     'The Hunger Games': {
        1:[
          "Oh, joy. Why don't you join us?",
          "I was just giving some life saving advice.",
          "Like what?",
          "Oh, I was just asking about how to find shelter.",
          "Which would come in handy if in fact you were still alive.",
        ],
        2:[
          "You really wanna know how to stay alive?",
          "You get people to like you.",
          "Oh! Not what you were expecting?",
          "Well, when you're in the middle of The Games, and you're starving or freezing,",
          "some water, a knife, or even some matches can mean the difference between life and death.",
          "And those things only come from sponsors.",
          "And to get sponsors, you have to make people like you.",
        ]
      },
    };

    final Map<String, Map<int, String>> initialVideoIdsMap = {
      'Notting Hill': {
        1: 'mpZgODL1eGw',
        2: 'mpZgODL1eGw',
      },
      'Titanic': {
        1: 'zSRvmHSgaBg',
        2: '1YGfrGKK9Mo',
      },
      'Jurassic Park': {
        1: 'tYm7xeg27Rw',
        2: 'tYm7xeg27Rw',
      },
      'The Princess Diaries': {
        1: 'cVP4PMM3IZc',
        2: 'cVP4PMM3IZc',
      },
      'Men In Black': {
        1: 'WS93LMcRGRk',
        2: 'WS93LMcRGRk',
      },
      'Back to the Future': {
        1: 'FWG3Dfss3Jc',
        2: 'FWG3Dfss3Jc',
      },
      'Bucket List': {
        1: 'uiy-sT9JgRo',
        2: 'uiy-sT9JgRo',
      },
      'Inception': {
        1: '0b-H8oQUs1A',
        2: 'i3-jlhJgU9U',
      },
      'Soul': {
        1: 'Pg7Zit2Thks',
        2: 'Pg7Zit2Thks',
      },
      'Inside Out': {
        1: 'Whwyu09a8KE',
        2: 'Whwyu09a8KE',
      },
      'Charlie and the Chocolate\n                Factory': {
        1: 'ckjDSzjU-cQ',
      },
      'The Hunger Games': {
        1: 'Z92aHy9-fkk',
        2: 'Z92aHy9-fkk',
      },
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
    
    _startEndTimes = widget.startEndTimesMap[widget.movieName]![widget.sceneNumber]!;
    _sentences = widget.sentencesMap[widget.movieName]![widget.sceneNumber]!;
    _initialVideoId = widget.initialVideoIdsMap[widget.movieName]![widget.sceneNumber]!;

    _controller = YoutubePlayerController(
      initialVideoId: _initialVideoId,
      flags: const YoutubePlayerFlags(
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
    Set<String> lowerCaseSpeechWords = speechWords.map((word) => word.toLowerCase()).toSet();
    for (int i = 0; i < lowerCaseSentenceWords.length; i++) {
      bool match = lowerCaseSpeechWords.contains(lowerCaseSentenceWords[i]);
      print('Comparing ${lowerCaseSentenceWords[i]} to ${lowerCaseSpeechWords.join(', ')}: $match');
      comparedWords.add(match);
    }
    return comparedWords;
  }

  // Function to color the matched and unmatched words
  List<Text> splitDisplayingSentenceWithColors(String sentence) {
    List<String> sentenceWords = sentence.split(' ');
    List<Text> words = [];
    List<String> sentenceWordsNoPunctuation = sentenceWords.map((word) => word.replaceAll(RegExp(r'[.,!?;:]'), '')).toList();
    List<String> speechWords = splitSpeechIntoWords(_transcription);
    List<bool> comparedWords = compareWords(sentenceWordsNoPunctuation, speechWords);
    for (int i = 0; i < sentenceWords.length; i++) {
      TextStyle style;
      if (comparedWords[i]) {
        style = const TextStyle(fontSize: 20, color: Colors.green);
      } else {
        style = const TextStyle(fontSize: 20, color: Colors.red);
      }
      words.add(Text(sentenceWords[i] + ' ', style: style));
    }
    return words;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
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
            Container(
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
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Sentence to practice:',
                          style: TextStyle(fontSize: 20),
                          maxLines: null,
                          textAlign: TextAlign.center,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          children: splitDisplayingSentenceWithColors(_sentences[_currentSentenceIndex]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 30,
                              color: Colors.black,
                              icon: const Icon(Icons.transcribe),
                              onPressed: () {
                                _startListening();
                              },
                            ),
                            IconButton(
                              iconSize: 30,
                              color: Colors.black,
                              icon: const Icon(Icons.stop),
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
                                backgroundColor: const Color(0xFF264683),
                                padding: const EdgeInsets.fromLTRB(30,10,30,10),
                              ),
                              child: const Text(
                                'Listen',
                                style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
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
                    backgroundColor: const Color(0xFF264683),
                    padding: const EdgeInsets.fromLTRB(25,10,25,10),
                  ),
                  child: const Text(
                    'Last Line',
                    style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
                  ),
                ),
                const SizedBox(width: 60),
                ElevatedButton(
                  onPressed: _nextSentence,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF264683),
                    padding: const EdgeInsets.fromLTRB(25,10,25,10),
                  ),
                  child: const Text(
                    'Next Line',
                    style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Record(sentences: _sentences, initialVideoId: _initialVideoId,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 38, 131, 50),
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                ),
                child: const Text(
                  'Ready!',
                  style: TextStyle(fontSize: 18, color: Color(0xffffffff)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}