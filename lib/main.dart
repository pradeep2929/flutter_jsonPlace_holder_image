import 'package:flutter/material.dart';
import 'package:image_viewer/ui/MyHomePage.dart';

void main() => runApp(new MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      title: "Json Image",
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: "Albums",
      ),
    ));
