import 'package:flutter/material.dart';
import 'genre_1_movie_1.dart';
import 'genre_1_movie_2.dart';
import 'genre_1_movie_3.dart';
import 'data/genre_data.dart';

class Genre1 extends StatefulWidget {
  final String difficulty;
  final String genre;

  const Genre1({Key? key, required this.difficulty, required this.genre}) : super(key: key);

  @override
  _Genre1State createState() => _Genre1State();
}

class _Genre1State extends State<Genre1> {
  late GenreData _genreData;

  @override
  void initState() {
    super.initState();
    _genreData = getGenreData(widget.difficulty, widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.genre}'),
      ),
      backgroundColor: Color(0xFFFFCD45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              _genreData.movieTitles.length ~/ 2,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildMovieContainer(_genreData.movieTitles[2 * index], _genreData.imagePaths[2 * index], index * 2),
                  buildMovieContainer(_genreData.movieTitles[2 * index + 1], _genreData.imagePaths[2 * index + 1], index * 2 + 1),
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
        Container(
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
        SizedBox(
          height: 35.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _genreData.routes[index] == '/genre1scene' ? Genre1Scene() : _genreData.routes[index] == '/genre1scene2' ? Genre1Scene2() : Genre1Scene3()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF264683)),
            child: Text('Select', style: const TextStyle(color: Color(0xffffffff),),),
          ),
        ),
      ],
    );
  }
}