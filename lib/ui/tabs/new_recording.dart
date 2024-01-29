import 'package:flutter/material.dart';
import 'package:record/record.dart';

class NewRecordingScreen extends StatefulWidget {
  @override
  State<NewRecordingScreen> createState() => _NewRecordingScreenState();
}

class _NewRecordingScreenState extends State<NewRecordingScreen> {
  bool recorded = false;
  bool recording = false;
  final recorder = AudioRecorder();

  @override
  Widget build(BuildContext context) {
    late Row buttonRow;
    if (recording) {
      buttonRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton.icon(
            icon: Icon(Icons.stop),
            label: Text("Stop"),
            onPressed: () {
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
          onPressed: () {
            setState(() {
              recording = true;
            });
          });
      if (recorded) {
        buttonRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          recordButton,
          ElevatedButton.icon(
              icon: Icon(Icons.play_arrow),
              label: Text("Play"),
              onPressed: () {}),
          ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text("Save"),
              onPressed: () {
                Navigator.pop(context);
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
              SizedBox(
                  width: 240.0,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )),
              SizedBox(height: 8.0),
              buttonRow,
              SizedBox(height: 8.0),
              SizedBox(
                  width: 480.0,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )),
              SizedBox(height: 8.0),
              ElevatedButton(
                child: Text("Sumbit"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}
