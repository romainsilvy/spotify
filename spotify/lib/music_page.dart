import 'package:flutter/material.dart';
import 'package:spotify/main.dart';
import 'package:spotify/page_manager.dart';
import 'package:spotify/utils/utils.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

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
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'Spotify'),
            ),
          );
        }),
        title: Text(myMusicList[widget.index].title +
            ' - ' +
            myMusicList[widget.index].singer),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            spacer(20),
            Image(
              width: 80 * MediaQuery.of(context).size.width / 100,
              fit: BoxFit.cover,
              image: AssetImage(myMusicList[widget.index].imagePath),
            ),
            spacer(50),
            Text(
              myMusicList[widget.index].title,
              style: TextStyle(fontSize: 30),
            ),
            spacer(10),
            Text(
              myMusicList[widget.index].singer,
            ),
            const Spacer(),
            NavigationButtons(pageManager: _pageManager, index: widget.index),
            Spacer(),
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
            spacer(20),
          ],
        ),
      ),
    );
  }
}

class NavigationButtons extends StatefulWidget {
  const NavigationButtons(
      {Key? key, required this.pageManager, required this.index})
      : super(key: key);
  final PageManager pageManager;
  final int index;
  @override
  State<NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //previous button
          IconButton(
            iconSize: 50,
            icon: Icon(Icons.skip_previous),
            onPressed: () {
              widget.pageManager.pause();
              if (widget.index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MusicPage(index: myMusicList.length - 1),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPage(index: widget.index - 1),
                  ),
                );
              }
            },
          ),
          ValueListenableBuilder<ButtonState>(
            valueListenable: widget.pageManager.buttonNotifier,
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
                    iconSize: 50,
                    onPressed: widget.pageManager.play,
                  );
                case ButtonState.playing:
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 50,
                    onPressed: widget.pageManager.pause,
                  );
              }
            },
          ),
          //next button
          IconButton(
            iconSize: 50,
            icon: Icon(Icons.skip_next),
            onPressed: () {
              widget.pageManager.pause();
              if (widget.index == myMusicList.length - 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPage(index: 0),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPage(index: widget.index + 1),
                  ),
                );
              }
            },
          ),
        ]);
  }
}
