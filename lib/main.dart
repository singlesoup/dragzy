
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:dragzy/withoutPackage.dart';
// import 'package:dragzy/trail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
          // Trail(),
          // const MyHomePage(title: 'Drag And Drop'),
      const MyHomePageWithoutPackage(title: 'Drag And Drop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? layout = "2x2";
  List<String> layouts = ["2x2", "4x4", "6x4"];
  ScrollController? _scrollController;

  double? height;
  double? width;
  int test = 0;
  int? pos;

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
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    if (_scrollController != null) {
      _scrollController!.dispose();
    }
    super.dispose();
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
              child: DragAndDropGridView(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCountNumber(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4.5,
                  ),
                  padding: const EdgeInsets.all(20),
                  itemCount: images.length,
                  itemBuilder: (context, index) => LayoutBuilder(
                    builder: (context, constraints) {
                      // height = MediaQuery.of(context).size.height * 0.8;
                      // width = MediaQuery.of(context).size.width * 0.4;
                      if (test == 0) {
                        if (layout == "2x2") {
                          height = constraints.maxHeight;
                          width = constraints.maxWidth;
                        } else if (layout == "4x4") {
                          height = constraints.maxHeight * 0.5;
                          width = constraints.maxWidth * 0.5;
                          print("height: $height");
                        } else {
                          height = constraints.minHeight;
                          width = constraints.minWidth;
                        }
                        test++;
                      }
                      return GridTile(
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          height: height,
                          width: width,
                        ),
                      );
                    },
                  ),
                  onWillAccept: (oldIndex, newIndex) {
                    return true;
                  },
                  onReorder: (oldIndex, newIndex) {
                    final temp = images[oldIndex];
                    images[oldIndex] = images[newIndex];
                    images[newIndex] = temp;

                    setState(() {});
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
