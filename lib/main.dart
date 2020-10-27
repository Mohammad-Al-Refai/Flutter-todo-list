import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Todo list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> data = [];
  var text;
  var edit;
  void add() {
    Navigator.pop(context);
    setState(() {
      data.add(text);
      text = null;
    });
  }

  void update(index, value) {
    var x = data.indexOf(index);

    if (data.length == 1) {
      if (x - 1 != -1) {
        data[x - 1] = value;
      }
    }
    if (x != -1) {
      if (data.length == 1) {
        data[x - 1] = value;
      } else {
        data[x] = value;
      }
    }
  }

  void alert(c) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: ListView(
                children: [
                  TextField(
                    onChanged: (c) {
                      setState(() {
                        edit = c;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Enter change", hintText: "text"),
                  ),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          update(c, edit);
                          Navigator.pop(context);
                        });
                      },
                      child: Text("edit"))
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ListView(
              children: data
                  .map((e) => item(e, e, (i) {
                        setState(() {
                          data.remove(i);
                        });
                      }))
                  .toList()),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => showDialog(
                  context: context,
                  builder: (e) => AlertDialog(
                    title: Text("add item"),
                    content: Container(
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                labelText: "text", hintText: text),
                            onChanged: (v) {
                              setState(() {
                                text = v;
                              });
                            },
                          ),
                          FlatButton(onPressed: () => add(), child: Text("add"))
                        ],
                      ),
                    ),
                  ),
                )));
  }

  Widget item(String text, _id, void id(String i)) {
    var getId = _id;

    if (text == null) {
      text = "0";
    }
    return (Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
      height: 50,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () => {alert(getId)}),
              IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  onPressed: () => id(getId)),
            ],
          )
        ],
      ),
    ));
  }
}
