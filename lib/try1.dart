import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Drag app"),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double width = 100.0, height = 100.0;
  Offset position = const Offset(0.0, 100.0 - 20);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
//           left: position.dx,
//           top: position.dy - height + 20,
          child: GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Draggable(
                  data: index,
                  feedback: Material(
                    child: Container(
                      height: 200,
                      width: 200,
                      alignment: Alignment.center,
                      color: Colors.red[100 * (index % 9)],
                      child: Text('grid item $index'),
                    ),
                  ),
                  childWhenDragging: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    color: Colors.transparent,
//                     child: Text('grid item $index'),
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('grid item $index'),
                  ),
                  onDragStarted: () {
                    setState(() {});
                  },
                  onDragCompleted: () {
                    setState(() {});
                  },
                );
              },
              childCount: 30,
            ),
          ),
        ),
      ],
    );
  }
}
