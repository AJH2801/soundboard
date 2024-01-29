import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundboard/ui/tabs/new_recording.dart';
import '../../sounds.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> sounds = images
        .map((e) => Ink.image(
            image: AssetImage("images/${e.image}"),
            child: InkWell(onTap: () {
              print("Tapped on ${e.name}");
              final player = AudioPlayer();
              player.setAsset("sounds/${e.sound}");
              player.play();
            })))
        .toList();
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: sounds,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((BuildContext context) => NewRecordingScreen())));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
