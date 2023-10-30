import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
      (name: "Zhongli", image: "zhongli.jpg", sound: "placeholder.mp3"),
      (name: "Grass Block", image: "grassblock.jpg", sound: "placeholder.mp3"),
      (name: "Popcorn", image: "popcorn.jpg", sound: "placeholder.mp3"),
      (name: "1-Up", image: "oneup.jpg", sound: "placeholder.mp3"),
      (
        name: "Raiden Shogun",
        image: "raidenshogun.jpg",
        sound: "placeholder.mp3"
      ),
    ]
        .map((e) => GestureDetector(
            child: Image.asset("images/${e.image}"),
            onTap: () {
              print("Tapped on ${e.name}");
              final player = AudioPlayer();
              player.setAsset("sounds/${e.sound}");
              player.play();
            }))
        .toList();
    return GridView.count(
      crossAxisCount: 3,
      children: images,
    );
  }
}
