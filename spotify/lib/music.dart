import 'package:just_audio/just_audio.dart';

// create a class music with title, singer, imagePath and urlSong
class Music {
  final String title;
  final String singer;
  final String imagePath;
  final String urlSong;

  const Music({
    required this.title,
    required this.singer,
    required this.imagePath,
    required this.urlSong,
  });
}
