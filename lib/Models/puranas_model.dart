import 'dart:convert';

class PuranasModel {
  VishnuPurana vishnuPurana;

  PuranasModel({
    required this.vishnuPurana,
  });

  factory PuranasModel.fromJson({required Map<String, dynamic> json}) =>
      PuranasModel(
        vishnuPurana: VishnuPurana.fromJson(json["VishnuPurana"]),
      );

  Map<String, dynamic> toJson() => {
        "VishnuPurana": vishnuPurana.toJson(),
      };
}

class VishnuPurana {
  Title title;
  List<Shloka> shlokas;

  VishnuPurana({
    required this.title,
    required this.shlokas,
  });

  factory VishnuPurana.fromRawJson(String str) =>
      VishnuPurana.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VishnuPurana.fromJson(Map<String, dynamic> json) => VishnuPurana(
        title: Title.fromJson(json["title"]),
        shlokas:
            List<Shloka>.from(json["shlokas"].map((x) => Shloka.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title.toJson(),
        "shlokas": List<dynamic>.from(shlokas.map((x) => x.toJson())),
      };
}

class Shloka {
  int verse;
  String sanskrit;
  Title translation; // This will hold translations in all languages

  Shloka({
    required this.verse,
    required this.sanskrit,
    required this.translation,
  });

  factory Shloka.fromRawJson(String str) => Shloka.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shloka.fromJson(Map<String, dynamic> json) => Shloka(
        verse: json["verse"],
        sanskrit: json["sanskrit"],
        translation: Title.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "verse": verse,
        "sanskrit": sanskrit,
        "translation": translation.toJson(),
      };
}

class Title {
  String hindi;
  String english;
  String gujarati;

  Title({
    required this.hindi,
    required this.english,
    required this.gujarati,
  });

  factory Title.fromRawJson(String str) => Title.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        hindi: json["Hindi"],
        english: json["English"],
        gujarati: json["Gujarati"],
      );

  Map<String, dynamic> toJson() => {
        "Hindi": hindi,
        "English": english,
        "Gujarati": gujarati,
      };
}
