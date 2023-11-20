import 'package:flutter/material.dart';

class NewRecordingScreen extends StatefulWidget {
  @override
  State<NewRecordingScreen> createState() => _NewRecordingScreenState();
}

class _NewRecordingScreenState extends State<NewRecordingScreen> {
  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(
                child: Icon(Icons.mic),
                onPressed: () {},
              ),
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
