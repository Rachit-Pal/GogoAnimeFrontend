import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miru/gogoanime/http_service.dart';
import 'package:miru/gogoanime/types.dart';

void main() {
  var gogo = GogoAnime();
  List<Results> popular = [];
  test("gogoanime popular", () async {
    popular = await gogo.fetchPopular();
    popular.every((element) {
      if (kDebugMode) {
        print(element.toJson());
      }
      return true;
    });
    expect(popular.length, greaterThan(0));
  });

  test("gogoanime details", () async {
    final results = await gogo.fetchDetails("naruto");
    if (kDebugMode) {
      print(results?.toJson());
    }
    expect(results?.animeTitle, matches("Naruto"));
  });

  test("gogoanime vidstream", () async {
    final results = await gogo.fetchStreamLinks("naruto-episode-220");
    if (kDebugMode) {
      print(results?.toJson());
    }
    expect(results?.sources.length, greaterThan(0));
  });
}
