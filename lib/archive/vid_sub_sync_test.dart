// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoTest extends StatefulWidget {
//   @override
//   _VideoTestState createState() => _VideoTestState();
// }

// class _VideoTestState extends State<VideoTest> {
//   late YoutubePlayerController _controller;
//   YoutubePlayerValue? _playerValue;

//   List<Lyric> lyrics = [
//     Lyric(sentence: 'Happy Birthday to you', startTime: 14, endTime: 22),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: '_z-1fTlSDF0',
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     )..addListener(() {
//         if (_controller.value.playerState == PlayerState.ended) {
//           _controller.seekTo(Duration.zero);
//         }
//       });

//     Future.delayed(Duration(seconds: 60), () {
//       if (_controller.value.playerState != PlayerState.ended) {
//         _controller.pause();
//       }
//     });

//     _controller.addListener(() {
//       setState(() {
//         _playerValue = _controller.value;
//       });
//     });
//   }

//   void listener() {
//     if (_playerValue!.playerState == PlayerState.playing && _playerValue!.position.inSeconds > 5) {
//       _controller.pause();
//     } else if (_playerValue!.playerState == PlayerState.paused) {
//       _controller.play();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Test'),
//       ),
//       backgroundColor: Color(0xffffcd45),
//       body: Column(
//         children: [
//           YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: Colors.amber,
//             progressColors: const ProgressBarColors(
//               playedColor: Colors.amber,
//               handleColor: Colors.amberAccent,
//             ),
//             onReady: () {
//               Future.delayed(Duration(seconds: 60), () {
//                 if (_controller.value.playerState != PlayerState.ended) {
//                   _controller.pause();
//                 }
//               });
//             },
//           ),
//           Container(
//             margin: EdgeInsets.all(8.0),
//             width: 350,
//             height: 400,
//             decoration: BoxDecoration(
//               color: Color(0xfffcf3e3),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: Colors.black,
//                 width: 1.5,
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: lyrics.map<Widget>((Lyric lyric) {
//                   return LyricWidget(
//                     sentence: lyric.sentence,
//                     startTime: lyric.startTime,
//                     endTime: lyric.endTime,
//                     controller: _controller,
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class Lyric {
//   final String sentence;
//   final int startTime;
//   final int endTime;

//   Lyric({required this.sentence, required this.startTime, required this.endTime});
// }

// class LyricWidget extends StatefulWidget {
//   final String sentence;
//   final int startTime;
//   final int endTime;
//   final YoutubePlayerController controller;

//   LyricWidget({
//     required this.sentence,
//     required this.startTime,
//     required this.endTime,
//     required this.controller,
//   });

//   @override
//   _LyricWidgetState createState() => _LyricWidgetState();
// }

// class _LyricWidgetState extends State<LyricWidget> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _opacityAnimation;
//   bool _isAnimating = false;
//   late Shader _shader; // Define a new variable to hold the Shader object

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: (widget.endTime - widget.startTime) * 1000),
//     );

//     _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _shader = LinearGradient(
//       colors: [
//         Colors.black,
//         Colors.green,
//       ],
//       begin: Alignment.centerLeft,
//       end: Alignment.centerRight,
//       stops: [0, 1],
//       tileMode: TileMode.clamp,
//     ).createShader(Rect.fromLTWH(0, 0, 200, 50));

//     widget.controller.addListener(() {
//       if (widget.controller.value.playerState == PlayerState.playing) {
//         if (!_isAnimating && widget.controller.value.position.inSeconds >= widget.startTime) {
//           _animationController.forward();
//           _isAnimating = true;
//         } else if (widget.controller.value.position.inSeconds > widget.endTime) {
//           _animationController.reverse();
//           _isAnimating = false;
//         }
//       } else if (widget.controller.value.playerState == PlayerState.paused ||
//           widget.controller.value.playerState == PlayerState.ended) {
//         _animationController.stop();
//         _isAnimating = false;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: _opacityAnimation.value,
//       child: ShaderMask(
//         blendMode: BlendMode.srcIn,
//         shaderCallback: (Rect rect) {
//           return _shader;
//         },
//         child: Text(
//           widget.sentence,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.transparent,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _shader.dispose(); // Dispose the Shader object
//     super.dispose();
//   }
// }