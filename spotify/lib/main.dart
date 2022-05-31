import 'package:flutter/material.dart';
import 'package:spotify/music_page.dart';
import 'package:spotify/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Spotify'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            //add an image here
            child: Container(
              child: Image.asset('assets/images/cover.jpg'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: myMusicList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(myMusicList[index].title),
                  subtitle: Text(myMusicList[index].singer),
                  leading: Image.asset(myMusicList[index].imagePath),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPage(index: index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      //add three floating actions to the bottom of the screen
    );
  }
}
