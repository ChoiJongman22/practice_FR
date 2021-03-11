import 'package:flutter/material.dart';
import 'package:practicefr/src/camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JongMan Camera",
      debugShowCheckedModeBanner: false, //debug 마크 삭제
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home:CameraScreen(),
    );
  }

}