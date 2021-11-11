import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Draggable'),
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
  List<Color> listA = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.cyan,
    Colors.green
  ];
  List<Color> listB = [Colors.white, Colors.black];

  late int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
                shrinkWrap: true,
                itemCount: listA.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, index) {
                  return Draggable<Color>(
                    data: listA[index],
                    feedback: Card(
                      child: Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(8.0),
                        color: listA[index],
                      ),
                    ),
                    child: Card(
                      child: Container(
                        height: 120,
                        width: 120,
                        color: listA[index],
                      ),
                    ),
                  );
                }),
            DragTarget<Color>(
              builder: (context, candidates, rejects) {
                return ListView.builder(
                  itemCount: listB.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    i = index;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: listB[index],
                        height: 70,
                      ),
                    );
                  },
                );
              },
              onAccept: (value) {
                setState(() {
                  listB.insert(i + 1, value);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropPreview(BuildContext context, Color value) {
    return Container(
      color: Colors.lightBlue[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
