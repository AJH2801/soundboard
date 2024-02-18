import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class NewRecordingScreen extends StatefulWidget {
  @override
  State<NewRecordingScreen> createState() => _NewRecordingScreenState();
}

class _NewRecordingScreenState extends State<NewRecordingScreen> {
  bool recorded = false;
  bool recording = false;
  String? path;
  final recorder = AudioRecorder();
  final localstorage = LocalStorage("soundboard.json");

  @override
  void initState() {
    super.initState();
    recorder.hasPermission();
    setupStorage();
  }

  void setupStorage() {
    var value = localstorage.getItem('sounds');
    if (value == null) {
      localstorage.setItem('sounds', []);
    }
  }

  @override
  Widget build(BuildContext context) {
    late Row buttonRow;
    if (recording) {
      buttonRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton.icon(
            icon: Icon(Icons.stop),
            label: Text("Stop"),
            onPressed: () async {
              path = await recorder.stop();
              print(path);
              setState(() {
                recording = false;
                recorded = true;
              });
            })
      ]);
    } else {
      ElevatedButton recordButton = ElevatedButton.icon(
          icon: Icon(Icons.mic),
          label: Text("Record"),
          onPressed: () async {
            setState(() {
              recording = true;
            });
            await recorder.start(const RecordConfig(encoder: AudioEncoder.wav),
                path: "test.wav");
          });
      if (recorded) {
        buttonRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          recordButton,
          ElevatedButton.icon(
              icon: Icon(Icons.play_arrow),
              label: Text("Play"),
              onPressed: () async {
                var player = AudioPlayer();
                print(path);
                await player.setUrl(path!);
                await player.play();
              }),
          ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text("Save"),
              onPressed: () async {
                final response = await http.get(Uri.parse(path!));
                final data =
                    Uri.dataFromBytes(response.bodyBytes, mimeType: 'audio/wav')
                        .toString();
                var value = localstorage.getItem("sounds");
                final sounds = value as List;
                sounds.add(data);
                localstorage.setItem("sounds", sounds);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              })
        ]);
      } else {
        buttonRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          recordButton,
        ]);
      }
    }
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRow,
              SizedBox(height: 8.0),
              SizedBox(
                  width: 480.0,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )),
            ],
          ),
        ));
  }
}
