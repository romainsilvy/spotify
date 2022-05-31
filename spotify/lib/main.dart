import 'package:flutter/material.dart';
import 'package:spotify/music.dart';
import 'package:spotify/page_manager.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:just_audio/just_audio.dart';

final List<Music> myMusicList = [
  Music(
    title: 'Tout va bien',
    singer: 'Alonzo',
    imagePath: 'assets/images/cover.jpg',
    urlSong: 'assets/music/tout-va-bien.mp3',
  ),
  Music(
    title: 'Tout va bien 2',
    singer: 'Alonzo',
    imagePath: 'assets/images/cover.jpg',
    urlSong: 'assets/music/tout-va-bien.mp3',
  ),
  Music(
    title: 'Tout va bien 3',
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

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

//this is the second page
class _MusicPageState extends State<MusicPage> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager(myMusicList[widget.index].urlSong);
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myMusicList[widget.index].title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${myMusicList[widget.index].title}',
            ),
            const Spacer(),
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: _pageManager.progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                  progress: value.current,
                  buffered: value.buffered,
                  total: value.total,
                  onSeek: _pageManager.seek,
                );
              },
            ),
            ValueListenableBuilder<ButtonState>(
              valueListenable: _pageManager.buttonNotifier,
              builder: (_, value, __) {
                switch (value) {
                  case ButtonState.loading:
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 32.0,
                      height: 32.0,
                      child: const CircularProgressIndicator(),
                    );
                  case ButtonState.paused:
                    return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      iconSize: 32.0,
                      onPressed: _pageManager.play,
                    );
                  case ButtonState.playing:
                    return IconButton(
                      icon: const Icon(Icons.pause),
                      iconSize: 32.0,
                      onPressed: _pageManager.pause,
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
