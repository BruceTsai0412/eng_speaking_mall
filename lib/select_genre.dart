import 'package:flutter/material.dart';
import 'genre.dart';

final List<String> genreDifficultyEasy = [
  'Romance',
  'Sci-Fi',
  'Adventure',
];

final List<String> genreImagesEasy = [
  'image/pos_la_la_land.png',
  'image/pos_back_to_the_future.png',
  'image/pos_jumanji.png',
];

final List<String> genreDifficultyIntermediate = [
  'Sci-Fi',
  'Comedy',
  'Adventure',
];

final List<String> genreImagesIntermediate = [
  'image/pos_back_to_the_future.png',
  'image/pos_me_time.png',
  'image/pos_jumanji.png',
];

final List<String> genreDifficultyHard = [
  'Comedy',
  'Adventure',
  'Biographies',
];

final List<String> genreImagesHard = [
  'image/pos_me_time.png',
  'image/pos_jumanji.png',
  'image/pos_long_walk_to_freedom.png',
];

class selectGenre extends StatelessWidget {
  final String difficulty;

  const selectGenre({Key? key, required this.difficulty}) : super(key: key);

  List<String> getImagePaths(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return genreImagesEasy;
      // Add more cases for other difficulty levels
      case 'Intermediate':
        return genreImagesIntermediate;
      case 'Hard':
        return genreImagesHard;
      default:
        return [];
    }
  }

  List<String> getGenreNames(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return genreDifficultyEasy;
      // Add more cases for other difficulty levels
      case 'Intermediate':
        return genreDifficultyIntermediate;
      case 'Hard':
        return genreDifficultyHard;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePaths = getImagePaths(difficulty);
    final genreNamesList = getGenreNames(difficulty);

    print('Number of genres: ${genreNamesList.length}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Genre ($difficulty)'),
      ),
      backgroundColor: Color(0xffffcd45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text('Select a genre', style: const TextStyle(fontSize: 20.0),),
                ),
              ),
              ...List.generate(
                genreNamesList.length,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfffcf3e3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  margin: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                       child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              genreNamesList[index],
                              style: const TextStyle(fontSize: 20.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 35.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(imagePaths[index]),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, 50.0),
                              child: SizedBox(
                                width: 100,
                                height: 40,
                                child: Container(
                                  margin: EdgeInsets.all(1.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Genre(
                                            difficulty: difficulty,
                                            genre: genreNamesList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF264683)),
                                    child: Text('Enter', style: const TextStyle(color: Color(0xffffffff),),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}