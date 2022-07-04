import 'package:flutter/material.dart';
import 'package:miru/gogoanime/types.dart';
import 'package:miru/views/playback_view.dart';

class AnimeInfoView extends StatelessWidget {
  final AnimeDetails? animeDetail;
  const AnimeInfoView({Key? key, required this.animeDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimeDetails data;
    if (animeDetail == null) {
      return const Text("Data not available");
    } else {
      data = animeDetail!;
    }
    Widget titleSection = Container(
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
                    data.animeTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  data.genres.join(", "),
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

    Color color = Colors.white;
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaybackView(animeDetail: data)));
            },
            child: _buildButtonColumn(color, Icons.stream, 'WATCH')),
        // _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection = Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        data.synopsis,
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: ListView(
        children: [
          Image.network(
            data.animeImg,
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection,
        ],
      ),
    );
  }
}

Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}
