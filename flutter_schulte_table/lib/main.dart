//1306170067-Esracan Gungor
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
        appBar: AppBar(
          title: Text("Schulte Table"),
        ),
        backgroundColor: Colors.amber.shade50,
        body: MyHomePage()),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> list = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25];
  int nextValue = 0;
  List<int> selectedIndexList = new List<int>();
  static const duration = const Duration(seconds: 1);
  Stopwatch watch = new Stopwatch();
  Timer timer;
  var bestScore;
  List times = new List();

  get i => this.selectedIndexList;

  @override
  void initState() {
    super.initState();
    list.shuffle();

    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    watch.start();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Best Score: $bestScore",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Time Elapsed: " +
                (watch.elapsedMilliseconds / 1000).truncate().toString(),
            style: TextStyle(fontSize: 20),
          ),
          new GridView.count(
            padding: EdgeInsets.all(9.0),
            shrinkWrap: true,
            crossAxisCount: 5,
            children: new List.generate(
              list.length,
                  (i) =>
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (nextValue + 1 == list[i]) {
                          nextValue++;
                          selectedIndexList.add(i);
                        }
                      });
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                        color: selectedIndexList.contains(i)
                            ? Colors.green
                            : Colors.black38,
                        border: Border.all(
                          color: Colors.black45,
                          width: 2.0,
                        ),
                      ),
                      child: new Center(
                        child: new Text(
                          list[i].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
            ),
          ),
          restart(i),
        ],
      ),
    );
  }

  Widget restart(i) {
    if (selectedIndexList.length == 25) {
      return RaisedButton(
        child: Text('Replay', style: TextStyle(fontSize: 20)),
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          selectedIndexList.clear();
          nextValue = 0;
          list.shuffle();
          watch.reset();
          watch.start();
        },
      );
    } else {
      return Container(height: 0);
    }
  }

  void handleTick() {
    setState(() {
      if (selectedIndexList.length == 25) {
        watch.stop();
        times.add(watch.elapsed);
        times.sort();
        bestScore = times.first;
      }
    });
  }
}
