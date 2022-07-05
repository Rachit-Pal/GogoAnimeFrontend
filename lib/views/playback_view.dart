import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miru/gogoanime/http_service.dart';
import '../gogoanime/types.dart';
import 'package:better_player/better_player.dart';

class PlaybackView extends StatefulWidget {
  final AnimeDetails? animeDetail;
  final String? episodeId;
  final StreamLinks? streamLinks;
  const PlaybackView({Key? key, this.animeDetail, this.episodeId, this.streamLinks})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state, unnecessary_this
      _PlaybackViewState(this.animeDetail, this.episodeId, this.streamLinks);
}

class _PlaybackViewState extends State<StatefulWidget> {
  AnimeDetails? animeDetail;
  String? episodeId;
  StreamLinks? streamLinks;
  _PlaybackViewState(this.animeDetail, this.episodeId, this.streamLinks);


  @override
  void initState() {
    super.initState();
  }

  StreamLinks? setStreamUrl() {
    StreamLinks? lnks;
    var gogo = GogoAnime();
    if (episodeId == null) {
      gogo
          .fetchStreamLinks(animeDetail!.episodesList.last.episodeId)
          .then((value) {
        lnks = value!;
        if (kDebugMode) {
          print(value.toJson().toString());
        }
      });
    } else if (lnks == null) {
      gogo.fetchStreamLinks(episodeId!).then((value) {
        lnks = value!;
        if (kDebugMode) {
          print(value.toJson().toString());
        }
      });
    }
    return lnks;
  }

  @override
  Widget build(BuildContext context) {
    var videoPart = AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        streamLinks!.sourcesBk.first.file,
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
