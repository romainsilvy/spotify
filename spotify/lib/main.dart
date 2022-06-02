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
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Color.fromARGB(255, 33, 31, 31)),
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.title),
      ),

      body: Column(
        children: <Widget>[
          spacer(20),
          Container(
            child: Image(
              width: 80 * MediaQuery.of(context).size.width / 100,
              fit: BoxFit.cover,
              image: AssetImage(myMusicList[0].imagePath),
            ),
          ),
          spacer(40),
          Expanded(
            child: ListView.builder(
              itemCount: myMusicList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      myMusicList[index].title),
                  subtitle: Text(
                      style: TextStyle(
                        color: Color.fromARGB(255, 149, 144, 144),
                      ),
                      myMusicList[index].singer),
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
