import 'package:flutter/material.dart';
import 'genre_1_romance.dart';

class Genre extends StatelessWidget {
  final List<List<String>> genreNames = const [
    ['Romance', 'image/pos_la_la_land.png', 'image/pos_la_la_land.png', 'image/pos_la_la_land.png', 'image/pos_la_la_land.png'],
    ['Sci-Fi', 'image/pos_back_to_the_future.png', 'image/pos_back_to_the_future.png', 'image/pos_back_to_the_future.png', 'image/pos_back_to_the_future.png'],
    ['Comedy', 'image/pos_me_time.png', 'image/pos_me_time.png', 'image/pos_me_time.png', 'image/pos_me_time.png'],
    ['Adventure', 'image/pos_jumanji.png', 'image/pos_jumanji.png', 'image/pos_jumanji.png', 'image/pos_jumanji.png'],
  ];

  final String difficulty;

  const Genre({Key? key, required this.difficulty}) : super(key: key);

  List<String> getImagePaths(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return genreNames[0].sublist(1);
      case 'Intermediate':
        return genreNames[1].sublist(1);
      case 'Hard':
        return genreNames[2].sublist(1);
      case 'Phonetics 1':
        return genreNames[3].sublist(1);
      case 'Phonetics 2':
        return genreNames[3].sublist(1);
      default:
        return genreNames[0].sublist(1);
    }
  }

  List<String> getGenreNames(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return genreNames[0].sublist(0, 4);
      case 'Intermediate':
        return genreNames[1].sublist(0, 4);
      case 'Hard':
        return genreNames[2].sublist(0, 4);
      case 'Phonetics 1':
        return genreNames[3].sublist(0, 4);
      case 'Phonetics 2':
        return genreNames[3].sublist(0, 4);
      default:
        return genreNames[0].sublist(0, 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePaths = getImagePaths(difficulty);
    final genreNamesList = getGenreNames(difficulty);

    return Scaffold(
      appBar: AppBar(
        title: Text('Genre'),
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
                4,
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
                                    offset: Offset(0, 3), // changes position of shadow
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
                                        MaterialPageRoute(builder: (context) => Genre1()),
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