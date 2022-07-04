import 'dart:convert';
import 'package:miru/gogoanime/types.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class GogoAnime {
  final String host = 'gogoanime.herokuapp.com';
  final String scheme = 'https';
  Future<List<Results>> fetchPopular() async {
    final response =
        await http.get(Uri(scheme: scheme, host: host, path: 'popular'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final results = (data as List).map((i) => Results.fromJson(i));
      return results.toList();
    } else {
      return [];
    }
  }

  Future<AnimeDetails?> fetchDetails(String animeId) async {
    final response = await http
        .get(Uri(scheme: scheme, host: host, path: 'anime-details/$animeId'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final results = AnimeDetails.fromJson(data);
      return results;
    }
    return null;
  }

  Future<StreamLinks?> fetchStreamLinks(String episodeId) async {
    final response = await http
        .get(Uri(scheme: scheme, host: host, path: 'vidcdn/watch/$episodeId'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final results = StreamLinks.fromJson(data);
      return results;
    }
    return null;
  }
}
