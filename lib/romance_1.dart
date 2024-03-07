import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
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
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    'Movies:',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox.shrink(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildMovieContainer('Movie title 1', 'image/pos_la_la_land.png'),
                      buildMovieContainer('Movie title 2', 'image/pos_la_la_land.png'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildMovieContainer('Movie title 3', 'image/pos_la_la_land.png'),
                      buildMovieContainer('Movie title 4', 'image/pos_la_la_land.png'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildMovieContainer('Movie title 5', 'image/pos_la_la_land.png'),
                      buildMovieContainer('Movie title 6', 'image/pos_la_la_land.png'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildMovieContainer(String title, String imagePath) {
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
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF264683)), 
          child: Text('Select', style: const TextStyle(color: Color(0xffffffff),),),
        ),
      ],
    );
  }
}