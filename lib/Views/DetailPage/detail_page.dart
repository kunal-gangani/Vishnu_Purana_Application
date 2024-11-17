import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vishnu_purana_application/Controllers/purana_controllers.dart';
import 'package:vishnu_purana_application/Controllers/theme_controller.dart';
import 'package:vishnu_purana_application/Models/puranas_model.dart';
import 'package:vishnu_purana_application/Views/DetailPage/Components/translation_section.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeController>(context, listen: false)
                  .toggleTheme();
            },
            icon: Icon(
              Provider.of<ThemeController>(context).isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(
            16.0.sp,
          ),
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
                  const Divider(
                    color: Colors.deepOrange,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Sanskrit verse
                  Container(
                    padding: EdgeInsets.all(
                      12.sp,
                    ),
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
                  translationSection(
                    context,
                    title: 'Translation (Hindi):',
                    translation: shloka.translation.hindi,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // English Translation
                  translationSection(
                    context,
                    title: 'Translation (English):',
                    translation: shloka.translation.english,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Gujarati Translation
                  translationSection(
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
      bottomNavigationBar:
          Consumer<PuranaControllers>(builder: (context, value, _) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.copy,
              ),
              label: 'Copy',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.share,
              ),
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
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (index == 1) {
              // Share verse
              Share.share(
                'Check out this verse: ${shloka.sanskrit}',
              );
            }
          },
        );
      }),
    );
  }
}
