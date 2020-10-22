import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///creates a list with item, here setting: Tehem, Camera, Privacy
    ///currently only visual and not responsive
    return new Center(
      child: ListView(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Theme')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Camera')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Privacy')),
          ),
        ],
      ),
    );
  }
}
