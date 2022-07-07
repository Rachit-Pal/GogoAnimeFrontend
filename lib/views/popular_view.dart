import 'package:flutter/material.dart';
import 'package:miru/gogoanime/http_service.dart';
import 'package:miru/utils/display_card.dart';

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
        return getDisplayCard(_results[index], gogo, context);
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
