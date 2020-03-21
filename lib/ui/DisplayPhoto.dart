import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/model/Photo.dart';

class DisplayPhoto extends StatelessWidget {
  final Photo photo;

  DisplayPhoto({this.photo});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(photo.title),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: body());
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                photo.url,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            ListTile(
              title: Text("Photo Id: " + photo.id.toString()),
              subtitle: Text(photo.title),
            ),
          ],
        ),
      ),
    );
  }
}
