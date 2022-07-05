import 'package:flutter/material.dart';
import 'package:miru/views/popular_view.dart';

void main() {
  runApp(const Miru());
}

class Miru extends StatelessWidget {
  const Miru({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miru',
      theme: ThemeData.dark(),
      home: const MiruHome(title: 'Miru'),
    );
  }
}

class MiruHome extends StatefulWidget {
  const MiruHome({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MiruHome> createState() => _MiruHomeState();
}

class _MiruHomeState extends State<MiruHome> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:
              PopularView()), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
