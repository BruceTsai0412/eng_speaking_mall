import 'package:flutter/material.dart';
import 'genre_1_scene.dart';
import 'genre_1_scene_2.dart';
import 'genre_1_scene_3.dart';

class Genre1 extends StatefulWidget {
  @override
  _Genre1State createState() => _Genre1State();
}

class _Genre1State extends State<Genre1> {
  final List<String> _movieTitles = [
    'La La Land',
    'Love Happens',
    'Titanic',
    'Movie title 4',
    'Movie title 5',
    'Movie title 6',
  ];

  final List<String> _imagePaths = [
    'image/pos_la_la_land.png',
    'image/pos_love_happens.png',
    'image/pos_titanic.png',
    'image/pos_la_la_land.png',
    'image/pos_la_la_land.png',
    'image/pos_la_la_land.png',
  ];

  final List<String> _routes = [
    '/genre1scene',
    '/genre1scene2',
    '/genre1scene3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('romance_1'),
      ),
      backgroundColor: Color(0xFFFFCD45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              3,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildMovieContainer(_movieTitles[2 * index], _imagePaths[2 * index], index * 2),
                  buildMovieContainer(_movieTitles[2 * index + 1], _imagePaths[2 * index + 1], index * 2 + 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildMovieContainer(String title, String imagePath, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, _routes[index]);
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  imagePath,
                  height: 180.0,
                  width: 180.0,
                ),
                SizedBox(height: 6.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _routes[index] == '/genre1scene' ? Genre1Scene() : _routes[index] == '/genre1scene2' ? Genre1Scene2() : Genre1Scene3()),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF264683)), 
          child: Text('Select', style: const TextStyle(color: Color(0xffffffff),),),
        ),
      ],
    );
  }
}