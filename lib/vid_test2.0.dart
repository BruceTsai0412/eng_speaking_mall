import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTest2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest2> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('video/vid_001.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });

        _controller.addListener(() {


          if (_controller.value.isPlaying == false && _controller.value.position.inSeconds < 5) {
            _controller.play();
          }

        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Video Test'),
      ),
      backgroundColor: Color(0xffffcd45),
      body: Column(
        children: [
          Container(
            width: 393,
            height: 200,
            child: VideoPlayer(_controller),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            width: 380,
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