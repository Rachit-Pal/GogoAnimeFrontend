import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miru/gogoanime/http_service.dart';
import '../gogoanime/types.dart';
import 'package:better_player/better_player.dart';

class PlaybackView extends StatefulWidget {
  final AnimeDetails? animeDetail;
  final String? episodeId;
  final StreamLinks? streamLinks;
  final String? episodeNumber;

  const PlaybackView(
      {Key? key,
      this.animeDetail,
      this.episodeId,
      this.streamLinks,
      this.episodeNumber})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state, unnecessary_this
      _PlaybackViewState(this.animeDetail, this.episodeId, this.streamLinks,
          this.episodeNumber);
}

class _PlaybackViewState extends State<StatefulWidget> {
  AnimeDetails? animeDetail;
  String? episodeId;
  String? episodeNumber = '1';
  StreamLinks? streamLinks;

  _PlaybackViewState(
      this.animeDetail, this.episodeId, this.streamLinks, this.episodeNumber);

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
    var gogo = GogoAnime();
    var videoPart = AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        streamLinks!.sources.first.file,
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
        ),
      ),
    );

    var listTiles = <Widget>[];
    for (var element in animeDetail!.episodesList) {
      listTiles.add(ListTile(
        leading: const Icon(Icons.movie),
        title: Text('Episode ${element.episodeNum}'),
        onTap: () {
          gogo.fetchStreamLinks(element.episodeId).then((value) => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlaybackView(
                            animeDetail: animeDetail,
                            streamLinks: value,
                            episodeNumber: element.episodeNum)))
              });
        },
      ));
    }

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    animeDetail!.animeTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  animeDetail!.genres.join(", "),
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    List<Widget> widGetList = List.from([
      videoPart,
      textSection,
      // bottomSection
      //textSection,
    ])
      ..addAll(listTiles);

    episodeNumber ??= '1';

    return Scaffold(
      appBar: AppBar(title: Text("Watch Episode $episodeNumber")),
      body: ListView(children: widGetList),
    );
  }
}
