// import 'package:flutter/material.dart';

// class PreviewContainer extends StatelessWidget {
//   final String title;

//   final bool isNetflixOriginal;
//   const PreviewContainer({Key key, this.title, this.isNetflixOriginal = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18.0),
//           child: Text(
//             title,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//         ),
//         SizedBox(height: 8.0),
//         Container(
//           height: isNetflixOriginal ? 300 : 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: null,
//             itemBuilder: (_, index) => Container(
//               margin: const EdgeInsets.all(4.0),
//               width: isNetflixOriginal ? 150 : 110,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('lists[index].imageUrl,'),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
