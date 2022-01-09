import 'package:flutter/material.dart';

class MyHomePageWithoutPackage extends StatefulWidget {
  const MyHomePageWithoutPackage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _MyHomePageWithoutPackageState createState() =>
      _MyHomePageWithoutPackageState();
}

class _MyHomePageWithoutPackageState extends State<MyHomePageWithoutPackage> {
  bool isDropped = false;
  bool isDragStarted = false;
  String? layout = "2x2";
  List<String> layouts = ["2x2", "4x4", "6x4"];

  int crossAxisCountNumber() {
    int crossAxisCount = 2;
    if (layout == "2x2") {
      crossAxisCount = 2;
    } else if (layout == "4x4") {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 6;
    }

    return crossAxisCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
                items: layouts
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (String? val) {
                  setState(() {
                    layout = val;
                  });
                },
                value: layout),
            Expanded(
              child: Stack(
                children: [
                  GridView.custom(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCountNumber(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Draggable(
                          data: index,
                          feedback: Material(
                            child: Container(
                              height: 200,
                              width: 200,
                              alignment: Alignment.center,
                              color: Colors.teal[100 * (index % 9)],
                              child: Text('grid item $index'),
                            ),
                          ),
                          childWhenDragging: Container(
                            height: 200,
                            width: 200,
                            alignment: Alignment.center,
                            color: Colors.yellow[100 * (index % 9)],
                            child: Text('grid item $index'),
                          ),
                          child: Container(
                            height: 200,
                            width: 200,
                            alignment: Alignment.center,
                            color: Colors.teal[100 * (index % 9)],
                            child: Text('grid item $index'),
                          ),
                          onDragStarted: () {
                            setState(() {
                              isDragStarted = true;
                            });
                          },
                          onDragCompleted: () {
                            setState(() {
                              isDragStarted = false;
                            });
                          },
                        );
                      },
                      childCount: 30,
                    ),
                  ),
                  !isDragStarted
                      ? Container()
                      : GridView.custom(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCountNumber(),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          childrenDelegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return SizedBox(
                                child: DragTarget<String>(
                                  builder: (_, __, ___) => Container(
                                    color: isDropped
                                        ? Colors.amber
                                        : Colors.transparent,
                                    height: 200,
                                    width: 200,
                                    child: Text(
                                        'grid items $index and $isDropped'),
                                  ),
                                  onAccept: (data) {
                                    setState(() {
                                      isDropped = true;
                                      isDragStarted = false;
                                    });
                                  },
                                  onWillAccept: (data) {
                                    return true;
                                  },
                                ),
                              );
                            },
                            childCount: 30,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
