import 'package:flutter/material.dart';
// import 'package:dragzy/try1.dart';
import 'package:dragzy/withoutPackage.dart';

void main() {
  runApp(const MyApp());
//  runApp(MyApp2());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dragzy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          // const MyHomePage(title: 'Drag And Drop'),
          const MyHomePageWithoutPackage(title: 'Drag And Drop'),
    );
  }
}
