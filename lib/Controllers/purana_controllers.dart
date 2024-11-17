import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vishnu_purana_application/Models/puranas_model.dart';

class PuranaControllers extends ChangeNotifier {
  List<Shloka> allShlokas = [];
  List<Shloka> filteredShlokas = [];
  String selectedLanguage = 'Hindi';
  Map<int, bool> showTranslations = {};
  late VishnuPurana vishnuPurana;

  // Decode JSON Data
  Future<void> jsonEncode() async {
    String jsonPath = "assets/Json/main.json";
    String jsonData = await rootBundle.loadString(jsonPath);
    Map<String, dynamic> jsonList = jsonDecode(jsonData);
    PuranasModel allData = PuranasModel.fromJson(json: jsonList);

    vishnuPurana = allData.vishnuPurana;
    allShlokas = vishnuPurana.shlokas ?? [];
    filteredShlokas = List.from(allShlokas);
    notifyListeners();
  }

  // Toggle the visibility of translation for a particular Shloka
  void toggleTranslationVisibility(int index) {
    showTranslations[index] = !(showTranslations[index] ?? false);
    notifyListeners();
  }

  // Change the Shloka Language
  void changeLanguage(String language) {
    selectedLanguage = language;
    filterShlokas();
    notifyListeners();
  }

  // Get the Shloka Translation in selected Language
  String getTranslation(int index) {
    final shloka = filteredShlokas[index];
    switch (selectedLanguage) {
      case 'Hindi':
        return shloka.translation.hindi;
      case 'English':
        return shloka.translation.english;
      case 'Gujarati':
        return shloka.translation.gujarati;
      default:
        return shloka.translation.hindi;
    }
  }

  // Get All Translations in Remaining Languages
  List<String> getOtherTranslations(int index) {
    final shloka = filteredShlokas[index];
    return [
      "Hindi: ${shloka.translation.hindi}",
      "English: ${shloka.translation.english}",
      "Gujarati: ${shloka.translation.gujarati}",
    ];
  }

  bool isTranslationVisible(int index) {
    return showTranslations[index] ?? false;
  }

  // Filter the Shlokas
  void filterShlokas() {
    filteredShlokas = allShlokas;
    notifyListeners();
  }

  // Search for a particular Shloka by verse number
  void searchShloka(String verseNumber) {
    if (verseNumber.isEmpty) {
      filteredShlokas = allShlokas;
    } else {
      filteredShlokas = allShlokas
          .where((shloka) => shloka.verse.toString() == verseNumber)
          .toList();
    }
    notifyListeners();
  }

  // To Refresh the page after searching a verse
  void refreshShlokas() {
    filteredShlokas = List.from(allShlokas);
    notifyListeners();
  }
}
