import 'package:flutter/cupertino.dart';
import 'package:spotify/music.dart';

final List<Music> myMusicList = [
  Music(
    title: 'Tout va bien',
    singer: 'Alonzo',
    imagePath: 'assets/images/tout-va-bien.jpg',
    urlSong: 'assets/music/tout-va-bien.mp3',
  ),
  Music(
    title: 'Filtré',
    singer: 'Timal, Gazo',
    imagePath: 'assets/images/filtre.png',
    urlSong: 'assets/music/filtre.mp3',
  ),
  Music(
    title: 'Best life',
    singer: 'Naps',
    imagePath: 'assets/images/best-life.jpg',
    urlSong: 'assets/music/best-life.mp3',
  ),
  Music(
    title: 'Ambassadeur',
    singer: 'Dadju',
    imagePath: 'assets/images/ambassadeur.jpg',
    urlSong: 'assets/music/ambassadeur.mp3',
  ),
  Music(
    title: 'Traficante',
    singer: 'Alonzo',
    imagePath: 'assets/images/traficante.jpg',
    urlSong: 'assets/music/traficante.mp3',
  ),
];

SizedBox spacer(double height) => SizedBox(height: height);
