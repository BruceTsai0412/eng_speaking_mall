import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTest extends StatefulWidget {
  @override
  _VideoTestState createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {
  late YoutubePlayerController _controller;
  YoutubePlayerValue? _playerValue;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '_z-1fTlSDF0',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
        if (_controller.value.playerState == PlayerState.ended) {
          _controller.seekTo(Duration.zero);
        }
      });

    Future.delayed(Duration(seconds: 60), () {
      if (_controller.value.playerState != PlayerState.ended) {
        _controller.pause();
      }
    });

    _controller.addListener(() {
      setState(() {
        _playerValue = _controller.value;
      });
    });
  }

  void listener() {
    if (_playerValue!.playerState == PlayerState.playing && _playerValue!.position.inSeconds > 5) {
      _controller.pause();
    } else if (_playerValue!.playerState == PlayerState.paused) {
      _controller.play();
    }
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
            onReady: () {
              Future.delayed(Duration(seconds: 60), () {
                if (_controller.value.playerState != PlayerState.ended) {
                  _controller.pause();
                }
              });
            },
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            width: 350,
            height: 400,
            decoration: BoxDecoration(
              color: Color(0xfffcf3e3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}