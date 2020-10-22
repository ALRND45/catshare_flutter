import 'package:flutter/material.dart';
import 'settings.dart';
import 'feed.dart';
import 'camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatShare',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    //creates a Tab bar, Camera,Feed,Settings
    final tabController = new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("CatShare"),
            backgroundColor: Colors.amber[600],
            bottom: new TabBar(
                indicatorColor: Colors.red,
                labelColor: Colors.grey[800],
                tabs: [
                  new Tab(icon: new Icon(Icons.camera_alt), text: "Camera"),
                  new Tab(icon: new Icon(Icons.home), text: "Feed"),
                  new Tab(icon: new Icon(Icons.settings), text: "Settings"),
                ]),
          ),
          body: new TabBarView(children: [
            //changes screen when swiped
            new CameraScreen(),
            new FeedScreen(),
            new SettingsScreen(),
          ]),
        ));
    return new MaterialApp(
      title: "CatShareTabs",
      home: tabController,
    );
  }
}
