import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  File imageFile;
  Position _currentPosition;
  final _c = TextEditingController();
  String description = " ";

  _openGallery(BuildContext context) async {
    //Method to open gallery and pick an image that is displayed in feed
    _currentPosition = null;
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    //closes camera, redirects to feed
    Navigator.of(context).pop();
    //displays Description Text input
    _displayAddDesc(context);
  }

  //Method to open camera and pick an image that is displayed in feed
  _openCamera(BuildContext context) async {
    _currentPosition =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    //closes camera, redirects to feed
    Navigator.of(context).pop();
    //displays Description Text input
    _displayAddDesc(context);
  }

  //displays an alert box where you can add a description
  _displayAddDesc(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add a description'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new TextField(
                    controller: _c,
                    decoration: new InputDecoration(hintText: "description"),
                  ),
                  new FlatButton(
                    child: new Text("Save"),
                    onPressed: () {
                      setState(() {
                        this.description = _c.text;
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  //displays alert box where you can chose between gallery or camera
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select source'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  //methode to update displayed image
  Widget _switchImageView() {
    if (imageFile == null) {
      return Text('no image selected');
    } else {
      return Image.file(
        imageFile,
        width: 400,
        height: 400,
      );
    }
  }

  //Feed design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _switchImageView(),
                if (_currentPosition != null)
                  Text(
                      "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}")
                else
                  Text("no Geolocation data available"),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.amber[800],
                      width: 3,
                    ),
                  ),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.red[600],
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: Icon(Icons.add_photo_alternate),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
