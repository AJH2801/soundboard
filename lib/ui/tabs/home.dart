import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:soundboard/ui/tabs/new_recording.dart';
import '../../sounds.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localstorage = LocalStorage("soundboard.json");
  var sounds = <Widget>[];

  @override
  void initState() {
    super.initState();
    setupStorage();
    setupSounds();
  }

  void setupStorage() async {
    var value = localstorage.getItem('sounds');
    if (value == null) {
      localstorage.setItem('sounds', []);
    }
  }

  void setupSounds() {
    final storedSounds = localstorage.getItem('sounds') as List;
    setState(() {
      sounds = images
          .map((e) => Ink.image(
              image: AssetImage("images/${e.image}"),
              child: InkWell(onTap: () {
                print("Tapped on ${e.name}");
                final player = AudioPlayer();
                player.setAsset("sounds/${e.sound}");
                player.play();
              })))
          .toList();
      for (String uri in storedSounds) {
        sounds.add(Ink.image(
            image: AssetImage("images/placeholder.png"),
            child: InkWell(onTap: () {
              print("Tapped on stored sound");
              final player = AudioPlayer();
              player.setUrl(uri);
              player.play();
            })));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: sounds,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((BuildContext context) => NewRecordingScreen())));
          setupSounds();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
