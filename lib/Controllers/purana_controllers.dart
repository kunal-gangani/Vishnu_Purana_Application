import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vishnu_purana_application/Models/puranas_model.dart';

class PuranaControllers extends ChangeNotifier {
  List<Shloka> allShlokas = [];
  List<Shloka> filteredShlokas = [];
  String selectedLanguage = 'Hindi';
  Map<int, bool> showTranslations =
      {}; // Track visibility of translations per shloka

  Future<void> jsonEncode() async {
    String jsonPath = "assets/Json/main.json";
    String jsonData = await rootBundle.loadString(jsonPath);
    Map<String, dynamic> jsonList = jsonDecode(jsonData);
    PuranasModel allData = PuranasModel.fromJson(json: jsonList);

    allShlokas = allData.vishnuPurana.shlokas;
    filteredShlokas = List.from(allShlokas); // Initialize filteredShlokas
    notifyListeners();
  }

  void changeLanguage(String language) {
    selectedLanguage = language;
    filterShlokas();
    notifyListeners();
  }

  void toggleTranslationVisibility(int index) {
    showTranslations[index] = !(showTranslations[index] ?? false);
    notifyListeners();
  }

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

  void filterShlokas() {
    filteredShlokas = allShlokas;
    notifyListeners();
  }

  //Search for a particular by verse number
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

  //To Refresh the page after searching a verse
  void refreshShlokas() {
    filteredShlokas = List.from(allShlokas);
    notifyListeners();
  }
}
