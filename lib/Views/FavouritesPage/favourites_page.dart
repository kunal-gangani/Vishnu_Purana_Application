// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:vishnu_purana_application/Controllers/purana_controllers.dart';

// class FavouritesPage extends StatelessWidget {
//   FavouritesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PuranaControllers>(
//       builder: (context, value, _) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.deepOrange.shade700,
//             centerTitle: true,
//             title: Text(
//               "प्रिय श्लोक",
//               style: GoogleFonts.hind(
//                 fontSize: 26,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.yellow.shade700,
//                 letterSpacing: 2,
//               ),
//             ),
//           ),
//           body: value.favoriteShlokas.isEmpty
//               ? Center(
//                   child: Text(
//                     "कोई प्रिय श्लोक उपलब्ध नहीं है।",
//                     style: GoogleFonts.hind(
//                       fontSize: 20,
//                       color: Colors.brown.shade700,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 )
//               : ListView.builder(
//                   padding: const EdgeInsets.all(16.0),
//                   itemCount: value.favoriteShlokas.length,
//                   itemBuilder: (context, index) {
//                     final shloka = value.favoriteShlokas[index];
//                     return Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 8,
//                       color: Colors.orange.shade50,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Verse ${shloka.verse}',
//                               style: GoogleFonts.hind(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.brown.shade700,
//                               ),
//                             ),
//                             Divider(
//                               color: Colors.orange.shade300,
//                               thickness: 1,
//                             ),
//                             Text(
//                               shloka.sanskrit,
//                               style: GoogleFonts.hind(
//                                 fontSize: 18,
//                                 color: Colors.brown.shade700,
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               padding: const EdgeInsets.all(12.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade100,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 value.getTranslation(index),
//                                 style: GoogleFonts.hind(
//                                   fontSize: 16,
//                                   color: Colors.brown.shade900,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 textAlign: TextAlign.justify,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         );
//       },
//     );
//   }
// }
