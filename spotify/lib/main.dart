import 'package:flutter/material.dart';
import 'package:spotify/music.dart';
import 'package:just_audio/just_audio.dart';

final List<Music> myMusicList = [
  Music(
    title: 'Tout va bien',
    singer: 'Alonzo',
    imagePath: 'assets/images/cover.jpg',
    urlSong: 'assets/music/tout-va-bien.mp3',
  ),
  Music(
    title: 'Tout va bien',
    singer: 'Alonzo',
    imagePath: 'assets/images/cover.jpg',
    urlSong: 'assets/music/tout-va-bien.mp3',
  ),
  Music(
    title: 'Tout va bien',
    singer: 'Alonzo',
    imagePath: 'assets/images/cover.jpg',
    urlSong: 'assets/music/tout-va-bien.mp3',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  //create a list of music

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
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
      //add three floating actions to the bottom of the screen
    );
  }
}

//this is the second page
class MusicPage extends StatelessWidget {
  const MusicPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myMusicList[index].title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${myMusicList[index].title}',
            ),
          ],
        ),
      ),
      //add three buttons
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'Retour',
            child: Icon(Icons.arrow_back),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Pause',
            child: Icon(Icons.pause),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              final audioPlayer = AudioPlayer();
              audioPlayer.setUrl(myMusicList[index].urlSong);
              audioPlayer.play();
            },
            tooltip: 'Play',
            child: Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
