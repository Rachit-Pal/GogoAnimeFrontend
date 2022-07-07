import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miru/gogoanime/http_service.dart';

import '../gogoanime/types.dart';
import '../utils/display_card.dart';

class MiruScrollViewSearch extends StatefulWidget {
  const MiruScrollViewSearch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MiruScrollViewSearch();
}

class _MiruScrollViewSearch extends State<MiruScrollViewSearch> {
  var cards = <Widget>[];
  final gogo = GogoAnime();
  var txtStyle = const TextStyle(
    color: Colors.white,
  );

  void displayStuff(Iterable<Results> results) {
    int i = 0;
    cards.clear();
    for (i; i < results.length; i++) {
      var res = results.elementAt(i);
      setState(() {
        cards.add(getDisplayCard(res, gogo, context));
        cards.add(Container(height: 5, color: Theme.of(context).primaryColor));
      });
    }
  }

  Future<void> updateSearch(String q) async {
    await updateCards(q);
  }

  Future updateCards(String query) async {
    // Iterable<nhentaipac.Book> resp;
    await gogo.searchAnime(query).then((value) {
      displayStuff(value);
    }).catchError((error) {
      setState(() {
        cards.clear();
        cards.add(ListTile(
          title: const Text("Error", style: TextStyle(color: Colors.white)),
          subtitle: Text(error.toString(),
              style: const TextStyle(color: Colors.white)),
          tileColor: Colors.red,
        ));
      });
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
    });
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: false,
          centerTitle: false,
          title: const Text('Miru'),
          actions: const [],
          bottom: AppBar(
            title: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: Colors.white),
              width: double.infinity,
              height: 40,
              //color: Colors.white,
              child: Center(
                child: TextField(
                  onChanged: (q) {
                    updateSearch(q);
                  },
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  // controller: queryController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    hintStyle:
                        const TextStyle(fontSize: 15, color: Colors.black),
                    hintText: 'Search anime',
                    // prefixStyle: TextStyle(color: Colors.black),
                    // prefixIcon: const Icon(Icons.search_outlined),
                    // suffixIcon: Icon(Icons.camera_alt)),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
                child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                // color: MaterialColor(0xFF1C1C1C, color)
              ),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: cards,
                ),
              ),
            )),
          ]),
        )
      ],
    );
  }
}
