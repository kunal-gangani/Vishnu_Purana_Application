import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'; // Required for clipboard
import 'package:share_plus/share_plus.dart'; // Required for sharing
import 'package:vishnu_purana_application/Models/puranas_model.dart';

class DetailPage extends StatelessWidget {
  final Shloka shloka;

  const DetailPage({Key? key, required this.shloka}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Flexify.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange.shade800,
        title: Text(
          'Details of Verse ${shloka.verse}',
          style: GoogleFonts.notoSerif(
            fontSize: 24.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 12,
            shadowColor: Colors.black54,
            color: Colors.orange[200],
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Verse number
                  Text(
                    'Verse ${shloka.verse}',
                    style: GoogleFonts.notoSerif(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade700,
                    ),
                  ),
                  const Divider(color: Colors.deepOrange, thickness: 2),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Sanskrit verse
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.deepOrange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      shloka.sanskrit,
                      style: GoogleFonts.notoSerif(
                        fontSize: 22.sp,
                        color: Colors.brown.shade700,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Hindi Translation
                  _buildTranslationSection(
                    context,
                    title: 'Translation (Hindi):',
                    translation: shloka.translation.hindi,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // English Translation
                  _buildTranslationSection(
                    context,
                    title: 'Translation (English):',
                    translation: shloka.translation.english,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Gujarati Translation
                  _buildTranslationSection(
                    context,
                    title: 'Translation (Gujarati):',
                    translation: shloka.translation.gujarati,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.copy),
            label: 'Copy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Copy verse to clipboard
            Clipboard.setData(ClipboardData(text: shloka.sanskrit));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Verse copied to clipboard!',
                ),
              ),
            );
          } else if (index == 1) {
            // Share verse
            Share.share(
              'Check out this verse: ${shloka.sanskrit}',
            );
          }
        },
      ),
    );
  }

  Widget _buildTranslationSection(
    BuildContext context, {
    required String title,
    required String translation,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.notoSerif(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade700,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.deepOrange.shade200,
              width: 1,
            ),
          ),
          child: Text(
            translation,
            style: GoogleFonts.notoSerif(
              fontSize: 18.sp,
              color: Colors.brown.shade900,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
