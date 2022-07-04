// To parse this JSON data, do
//
//     final results = resultsFromJson(jsonString);

// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

List<Results> resultsFromJson(String str) =>
    List<Results>.from(json.decode(str).map((x) => Results.fromJson(x)));

String resultsToJson(List<Results> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Results {
  Results({
    required this.animeId,
    required this.animeTitle,
    required this.animeImg,
    required this.releasedDate,
    required this.animeUrl,
  });

  String animeId;
  String animeTitle;
  String animeImg;
  String releasedDate;
  String animeUrl;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        animeId: json["animeId"],
        animeTitle: json["animeTitle"],
        animeImg: json["animeImg"],
        releasedDate: json["releasedDate"],
        animeUrl: json["animeUrl"],
      );

  Map<String, dynamic> toJson() => {
        "animeId": animeId,
        "animeTitle": animeTitle,
        "animeImg": animeImg,
        "releasedDate": releasedDate,
        "animeUrl": animeUrl,
      };
}

class AnimeDetails {
  AnimeDetails({
    required this.animeTitle,
    required this.type,
    required this.releasedDate,
    required this.status,
    required this.genres,
    required this.otherNames,
    required this.synopsis,
    required this.animeImg,
    required this.totalEpisodes,
    required this.episodesList,
  });
  late final String animeTitle;
  late final String type;
  late final String releasedDate;
  late final String status;
  late final List<String> genres;
  late final String otherNames;
  late final String synopsis;
  late final String animeImg;
  late final String totalEpisodes;
  late final List<EpisodesList> episodesList;

  AnimeDetails.fromJson(Map<String, dynamic> json) {
    animeTitle = json['animeTitle'];
    type = json['type'];
    releasedDate = json['releasedDate'];
    status = json['status'];
    genres = List.castFrom<dynamic, String>(json['genres']);
    otherNames = json['otherNames'];
    synopsis = json['synopsis'];
    animeImg = json['animeImg'];
    totalEpisodes = json['totalEpisodes'];
    episodesList = List.from(json['episodesList'])
        .map((e) => EpisodesList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['animeTitle'] = animeTitle;
    _data['type'] = type;
    _data['releasedDate'] = releasedDate;
    _data['status'] = status;
    _data['genres'] = genres;
    _data['otherNames'] = otherNames;
    _data['synopsis'] = synopsis;
    _data['animeImg'] = animeImg;
    _data['totalEpisodes'] = totalEpisodes;
    _data['episodesList'] = episodesList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class EpisodesList {
  EpisodesList({
    required this.episodeId,
    required this.episodeNum,
    required this.episodeUrl,
  });
  late final String episodeId;
  late final String episodeNum;
  late final String episodeUrl;

  EpisodesList.fromJson(Map<String, dynamic> json) {
    episodeId = json['episodeId'];
    episodeNum = json['episodeNum'];
    episodeUrl = json['episodeUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['episodeId'] = episodeId;
    _data['episodeNum'] = episodeNum;
    _data['episodeUrl'] = episodeUrl;
    return _data;
  }
}

class StreamLinks {
  StreamLinks({
    // ignore: non_constant_identifier_names
    required this.Referer,
    required this.sources,
    required this.sourcesBk,
  });
  // ignore: non_constant_identifier_names
  late final String Referer;
  late final List<Sources> sources;
  late final List<SourcesBk> sourcesBk;
  
  StreamLinks.fromJson(Map<String, dynamic> json){
    Referer = json['Referer'];
    sources = List.from(json['sources']).map((e)=>Sources.fromJson(e)).toList();
    sourcesBk = List.from(json['sources_bk']).map((e)=>SourcesBk.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Referer'] = Referer;
    _data['sources'] = sources.map((e)=>e.toJson()).toList();
    _data['sources_bk'] = sourcesBk.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Sources {
  Sources({
    required this.file,
    required this.label,
    required this.type,
  });
  late final String file;
  late final String label;
  late final String type;
  
  Sources.fromJson(Map<String, dynamic> json){
    file = json['file'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['file'] = file;
    _data['label'] = label;
    _data['type'] = type;
    return _data;
  }
}

class SourcesBk {
  SourcesBk({
    required this.file,
    required this.label,
    required this.type,
  });
  late final String file;
  late final String label;
  late final String type;
  
  SourcesBk.fromJson(Map<String, dynamic> json){
    file = json['file'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['file'] = file;
    _data['label'] = label;
    _data['type'] = type;
    return _data;
  }
}