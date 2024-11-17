import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vishnu_purana_application/Controllers/purana_controllers.dart';
import 'package:vishnu_purana_application/Views/DetailPage/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PuranaControllers>(builder: (context, value, _) {
      if (value.allShlokas.isEmpty) {
        value.jsonEncode();
      }

      TextEditingController searchController = TextEditingController();

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange.shade700,
          centerTitle: true,
          title: Text(
            "विष्णु पुराण",
            style: GoogleFonts.hind(
              fontSize: 28.sp,
              color: Colors.yellow.shade700,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value.selectedLanguage,
                  items: [
                    'Hindi',
                    'English',
                    'Gujarati',
                  ].map<DropdownMenuItem<String>>(
                    (String lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text(
                          lang,
                          style: GoogleFonts.hind(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      value.changeLanguage(newValue);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                "assets/Images/background.jpg",
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.85),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: value.allShlokas.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Column(
                    children: [
                      // Search bar for verse number
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    8.0,
                                  ),
                                  child: TextField(
                                    controller: searchController,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Search by Verse',
                                      hintStyle: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                value.searchShloka(
                                  searchController.text,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: Text(
                                'Search',
                                style: GoogleFonts.hind(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          thickness: 8.0,
                          radius: const Radius.circular(10),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final shloka = value.filteredShlokas[index];
                              final isTranslationVisible =
                                  value.isTranslationVisible(index);
                              final translatedText =
                                  value.getTranslation(index);

                              return GestureDetector(
                                onTap: () {
                                  Flexify.go(
                                    DetailPage(
                                      shloka: shloka,
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 8,
                                  color: Colors.orange.shade50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Verse ${shloka.verse}',
                                          style: GoogleFonts.hind(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown.shade700,
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.orange.shade300,
                                          thickness: 1,
                                        ),
                                        Text(
                                          shloka.sanskrit,
                                          style: GoogleFonts.hind(
                                            fontSize: 18.sp,
                                            color: Colors.brown.shade700,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: Colors.orange.shade100,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            translatedText,
                                            style: GoogleFonts.hind(
                                              fontSize: 16.sp,
                                              color: Colors.brown.shade900,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            value.toggleTranslationVisibility(
                                                index);
                                          },
                                          icon: Icon(
                                            isTranslationVisible
                                                ? Icons.expand_less
                                                : Icons.expand_more,
                                            color: Colors.deepOrange.shade700,
                                          ),
                                          label: Text(
                                            isTranslationVisible
                                                ? "Hide Other Translations"
                                                : "Show Other Translations",
                                            style: GoogleFonts.hind(
                                              color: Colors.deepOrange.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        if (isTranslationVisible)
                                          ...value
                                              .getOtherTranslations(index)
                                              .map(
                                                (translation) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8.0,
                                                  ),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .orange.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: Colors.deepOrange
                                                            .shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      translation,
                                                      style: GoogleFonts.hind(
                                                        fontSize: 15.sp,
                                                        color: Colors
                                                            .brown.shade800,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Center(
                                child: Text(
                                  "ॐ",
                                  style: GoogleFonts.hind(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange.shade700,
                                  ),
                                ),
                              );
                            },
                            itemCount: value.filteredShlokas.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange.shade300,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          onPressed: () {
            value.refreshShlokas();
          },
          child: const Icon(
            Icons.refresh,
          ),
        ),
      );
    });
  }
}
