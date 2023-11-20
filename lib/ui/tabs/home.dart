import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundboard/ui/tabs/new_recording.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final images = [
      (name: "Whar", image: "whar.jpg", sound: "placeholder.mp3"),
      (name: "Zhongli", image: "zhongli.jpg", sound: "zhongli.mp3"),
      (name: "Amogus", image: "amogus.png", sound: "amogus.mp3"),
      (name: "Placeholder", image: "placeholder.png", sound: "placeholder.mp3"),
      (name: "1-Up", image: "oneup.jpg", sound: "one-up.mp3"),
      (name: "Raiden Shogun", image: "raidenshogun.jpg", sound: "raiden.mp3"),
    ]
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
        children: images,
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
