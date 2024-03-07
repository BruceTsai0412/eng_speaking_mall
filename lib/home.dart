import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'romance_1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> _genreNames = [
    'Romance',
    'Sci-Fi',
    'Comedy',
    'Adventure',
  ];

    final List<String> _imagePaths = [
    'image/pos_la_la_land.png',
    'image/pos_back_to_the_future.png',
    'image/pos_me_time.png',
    'image/pos_jumanji.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      backgroundColor: Color(0xFFFFCD45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Text('What\'s New', style: const TextStyle(fontSize: 20.0),),
                ),
              ),
              const SizedBox.shrink(),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'image/support_us.png',
                      height: 180.0,
                      width: 350.0,
                    ),
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
                            width: 2.0,
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
                                    _genreNames[index],
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
                                        image: AssetImage(_imagePaths[index],),
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
                                              MaterialPageRoute(builder: (context) => NewPage()),
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
            ],
          ),
        ),
      ),
    );
  }
}