import 'package:flutter/material.dart';
import 'package:miru/gogoanime/http_service.dart';
import 'package:miru/gogoanime/types.dart';

import '../views/anime_info_view.dart';

Widget getDisplayCard(Results element, GogoAnime gogo, BuildContext context) {
  return GestureDetector(
    onTap: () => {
      gogo.fetchDetails(element.animeId!).then((value) => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnimeInfoView(animeDetail: value)))
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
          image: NetworkImage(element.animeImg!),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          element.animeTitle!,
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
}
