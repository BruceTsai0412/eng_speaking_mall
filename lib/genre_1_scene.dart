import 'package:flutter/material.dart';

class Genre1Scene extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genre1Scene'),
      ),
      backgroundColor: Color(0xFFFFCD45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add your widgets here
            ],
          ),
        ),
      ),
    );
  }
}