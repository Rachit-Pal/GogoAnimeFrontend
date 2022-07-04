import 'package:flutter/material.dart';
import 'package:miru/gogoanime/http_service.dart';
import 'package:miru/views/anime_info_view.dart';

import '../gogoanime/types.dart';

class PopularView extends StatefulWidget {
  const PopularView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  List<Results> _results = [];
  var gogo = GogoAnime();
  void fetchPopular() async {
    final results = await gogo.fetchPopular();
    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchPopular();
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _results.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => {
            gogo.fetchDetails(_results[index].animeId).then((value) => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimeInfoView(animeDetail: value))
              ) 
            })
          },
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 60, 64, 70),
              // borderRadius: BorderRadius.circular(11.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: NetworkImage(_results[index].animeImg),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _results[index].animeTitle,
                style: const TextStyle(fontSize: 21, color: Colors.white),
                textAlign: TextAlign.end,
                textWidthBasis: TextWidthBasis.longestLine,
                textDirection: TextDirection.ltr,
              ),
            ),
            // child: Text(_results[index].animeTitle),
            //padding: <-- Using to shift text position a little bit for your requirement
          ),
        );
        /*return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Entry ${entries[index]}')),
        );*/
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
