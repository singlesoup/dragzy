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

  List<String> images = [
    "https://images.pexels.com/photos/10757932/pexels-photo-10757932.png?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
    "https://images.pexels.com/photos/10754454/pexels-photo-10754454.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/10510039/pexels-photo-10510039.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    "https://images.pexels.com/photos/10561071/pexels-photo-10561071.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    "https://images.pexels.com/photos/10436202/pexels-photo-10436202.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    "https://images.pexels.com/photos/10053725/pexels-photo-10053725.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
    "https://images.pexels.com/photos/10551258/pexels-photo-10551258.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    "https://images.pexels.com/photos/7189274/pexels-photo-7189274.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    "https://images.pexels.com/photos/5372826/pexels-photo-5372826.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    "https://images.pexels.com/photos/10661402/pexels-photo-10661402.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
    "https://images.pexels.com/photos/4311512/pexels-photo-4311512.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    "https://images.pexels.com/photos/10204555/pexels-photo-10204555.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  ];

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
                        return Draggable<int>(
                          data: index,
                          feedback: Material(
                            child: GridTile(
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                                height: 400,
                                width: 300,
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            height: 400,
                            width: 300,
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            // child: Text('grid item $index'),
                          ),
                          child: GridTile(
                            child: Image.network(
                              images[index],
                              fit: BoxFit.cover,
                              // height: 200,
                              // width: 200,
                            ),
                          ),
                          onDragStarted: () {
                            setState(() {
                              isDragStarted = true;
                            });
                          },
                          onDragEnd: (val) {
                            setState(() {
                              // print("was accepted: ${val.wasAccepted}");
                              // print("\n isDragStarted :$isDragStarted \n");
                              isDragStarted = false;

                              // print("\n isDropped : $isDropped \n");
                            });
                          },
                          onDragCompleted: () {
                            setState(() {
                              isDragStarted = false;
                            });
                          },
                        );
                      },
                      childCount: images.length,
                    ),
                  ),
                  !isDragStarted
                      ? Container(
                          // color: Colors.green,
                          // height: 400,
                          // width: 300,
                          )
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
                                child: DragTarget<int>(
                                  builder: (_, __, ___) => Container(
                                    // color: Colors.amber,
                                    height: 400,
                                    width: 300,
                                    // child: Text(
                                    //     'grid items $index and $isDropped'),
                                  ),
                                  onAccept: (data) {
                                    // print("Ayay");
                                    // print("\n data : $data \n");

                                    final temp = images[index];
                                    images[index] = images[data];
                                    images[data] = temp;

                                    // data is index on dragging Image
                                    // final temp = index;

                                    // newindex = data;

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
