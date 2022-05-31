import 'package:flutter/material.dart';
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
        title: Text(myMusicList[widget.index].title +
            ' - ' +
            myMusicList[widget.index].singer),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              myMusicList[widget.index].title,
            ),
            const Spacer(),
            NavigationButtons(),
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
          ],
        ),
      ),
    );
  }
}

class NavigationButtons extends StatefulWidget {
  const NavigationButtons({Key? key}) : super(key: key);

  @override
  State<NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  late final PageManager _pageManager;
  @override
  void initState() {
    super.initState();
    _pageManager = PageManager(myMusicList[0].urlSong);
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //previous button
          IconButton(
            iconSize: 50,
            icon: Icon(Icons.skip_previous),
            onPressed: () {},
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
                    iconSize: 50,
                    onPressed: _pageManager.play,
                  );
                case ButtonState.playing:
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 50,
                    onPressed: _pageManager.pause,
                  );
              }
            },
          ),
          //next button
          IconButton(
            iconSize: 50,
            icon: Icon(Icons.skip_next),
            onPressed: () {
              //widget.index += 1;
            },
          ),
        ]);
  }
}
