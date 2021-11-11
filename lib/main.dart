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
  List<Color> listB = [];
  List<String> listText = ['A', 'B', 'C', 'D'];
  List<String> text = [];

  late int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: listA.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.35, crossAxisCount: 3),
                    itemBuilder: (BuildContext context, index) {
                      return Draggable<Color>(
                        data: listA[index],
                        feedback: Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.all(8.0),
                          color: listA[index],
                        ),
                        child: Container(
                          height: 120,
                          width: 120,
                          color: listA[index],
                        ),
                      );
                    }),
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: listText.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.35, crossAxisCount: 3),
                    itemBuilder: (BuildContext context, index) {
                      return Draggable<String>(
                        data: listText[index],
                        feedback: Container(
                          height: 120,
                          width: 120,
                          color: Colors.teal,
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(listText[index])),
                        ),
                        child: Container(
                          height: 120,
                          width: 120,
                          color: Colors.teal,
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(listText[index])),
                        ),
                      );
                    }),
              ],
            ),
          ),
          Expanded(
            child: DragTarget<Color>(
              builder: (context, candidates, rejects) {
                return Stack(
                  children: [
                    Container(
                      child: ListView.builder(
                        itemCount: listB.isEmpty ? 1 : listB.length,
                        itemBuilder: (BuildContext context, int index) {
                          i = index;
                          return listB.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: Text('Drag here')),
                                )
                              : DragTarget<String>(
                                  builder: (context, accept, rejects) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: listB[index],
                                        child: text.isEmpty
                                            ? const Text('')
                                            : Center(child: Text(text[index])),
                                        height: 70,
                                      ),
                                    );
                                  },
                                  onAccept: (value) {
                                    setState(() {
                                      text[index] = value;
                                    });
                                  },
                                );
                        },
                      ),
                    ),
                    if (candidates.isNotEmpty)
                      Container(
                        color: Color(int.parse('0xff3aa9f78f')),
                        height: MediaQuery.of(context).size.shortestSide,
                      )
                  ],
                );
              },
              onAccept: (value) {
                setState(() {
                  listB.add(value);
                  text.add('');
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
