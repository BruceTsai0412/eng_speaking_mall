// import 'package:flutter/material.dart';
// import 'practice3.dart';

// class Movie extends StatelessWidget {
//   final String genre;
//   final String movieName;
//   final String imagePath;
//   final Map<String, Map<String, List<String>>> videoThumbnails = {
//     'Romance': {
//       'Notting Hill': ['image/thumbnail_notting_hill_A.png', 'image/thumbnail_notting_hill_B.png'],
//       'Titanic': ['image/test_vid_thumbnail_1.png', 'image/test_vid_thumbnail_2.png'],
//       //... other movie thumbnails...
//     },
//     'Sci-Fi': {
//       'La La Land': ['image/test_vid_thumbnail.png', 'image/test_vid_thumbnail.png'],
//       'Titanic': ['image/test_vid_thumbnail_1.png', 'image/test_vid_thumbnail_2.png'],
//       //... other movie thumbnails...
//     },
//     //... other genres...
//   };

//   Movie({super.key, required this.genre, required this.movieName, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     int sceneNumber = 1;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movie'),
//       ),
//       backgroundColor: Color(0xFFFFCD45),
//       body: Scrollbar(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Align(
//                   alignment: const Alignment(-0.9, 0),
//                   child: Text(movieName, style: const TextStyle(fontSize: 20.0),),
//                 ),
//               ),
//               Center(
//                 child: Image.asset(
//                   imagePath,
//                   height: 290.0,
//                   width: 210.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(height: 16.0),
//             ...List.generate(
//                 videoThumbnails[genre]![movieName]!.length,
//                 (index) {
//                   return InkWell(
//                     onTap: () {
//                         print('movieName: $movieName');
//                         print('sceneNumber: $sceneNumber');
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Practice3(movieName: movieName, sceneNumber: sceneNumber + index)),
//                       );
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             videoThumbnails[genre]![movieName]![index],
//                             height: 200.0,
//                             width: 340.0,
//                           ),
//                           SizedBox(height: 6.0),
//                           Text(
//                             'Scene ${index + 1}',
//                               style: const TextStyle(
//                               fontSize: 20.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }