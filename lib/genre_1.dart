import 'package:flutter/material.dart';
import 'genre_1_movie_1.dart';
import 'genre_1_movie_2.dart';
import 'genre_1_movie_3.dart';

  class GenreData {
    final List<String> movieTitles;
    final List<String> imagePaths;
    final List<String> routes;

    GenreData(this.movieTitles, this.imagePaths, this.routes);
  }

  GenreData getGenreData(String difficulty, String genre) {
    switch (difficulty) {
      case 'Easy':
        switch (genre) {
          case 'Romance':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/genre1scene',
              ],
            );
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Adventure':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          default:
            throw Exception('Invalid genre: $genre');
        }
      case 'Intermediate':
        switch (genre) {
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          case 'Comedy':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Adventure':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          default:
            throw Exception('Invalid genre: $genre');
        }
      case 'Hard':
        switch (genre) {
          case 'Comedy':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Adventure':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Biographies':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          default:
            throw Exception('Invalid genre: $genre');
        }
      default:
        throw Exception('Invalid difficulty: $difficulty');
    }
  }

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
          padding: EdgeInsets.fromLTRB(12, 50, 12, 10),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 190.0,
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
      MaterialPageRoute(builder: (context) => Genre1Scene(movieName: _genreData.movieTitles[index], imagePath: _genreData.imagePaths[index])),
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