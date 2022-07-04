import 'package:flutter/material.dart';
import 'package:miru/gogoanime/http_service.dart';
import '../gogoanime/types.dart';
import 'package:better_player/better_player.dart';

class PlaybackView extends StatelessWidget {
  final AnimeDetails animeDetail;
  final String? episodeId;
  const PlaybackView({Key? key, required this.animeDetail, this.episodeId})
      : super(key: key);
  Future<String> getStreamUrl() async {
    var gogo = GogoAnime();
    String url = '';
    if (episodeId == null) {
      var k =
          await gogo.fetchStreamLinks(animeDetail.episodesList[0].episodeId);
      url = k!.sources.first.file;
    } else {
      var k = await gogo.fetchStreamLinks(episodeId!);
      url = k!.sources.first.file;
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    var videoPart = AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        getStreamUrl().toString(),
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Watch")),
      body: ListView(
        children: [
          videoPart
          //titleSection,
          //buttonSection,
          //textSection,
        ],
      ),
    );
  }
}
