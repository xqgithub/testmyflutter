import 'dart:convert' show json;
import 'package:flutter/material.dart';

/**
 * 加载assets文件中的内容
 */
class LoadAssets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('LoadAssets'),
      ),
      body: new Column(
        children: <Widget>[
          new Image.asset("assets/images/iocn_diqiu.png"),
          new Image(image: new AssetImage("assets/images/iocn_diqiu.png")),
          new Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: new Text(
              "A red flair silhouetted the jagged edge of a wing.",
              style: new TextStyle(
                fontFamily: "Charmonman",
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "\u{e7d7}",
                style: new TextStyle(
                  fontFamily: "Iconfont",
                  fontSize: 37.0,
                ),
              ),
              new Text(
                "\u{e7d9}",
                style: new TextStyle(
                  fontFamily: "Iconfont",
                  fontSize: 36.0,
                ),
              ),
              new Text(
                "\u{e7df}",
                style: new TextStyle(
                  fontFamily: "Iconfont",
                  fontSize: 36.0,
                ),
              ),
            ],
          ),
          new Container(
            height: 500.0, // must
            child: new JsonView(),
          ),
        ],
      ),
    );
  }
}

///加载json文件
class JsonView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _JsonViewState();
  }
}

class _JsonViewState extends State<JsonView> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString("assets/country.json"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text("Name: ${data[index]["name"]}"),
                      new Text("Age: ${data[index]["age"]}"),
                      new Text("Height: ${data[index]["height"]}"),
                      new Text("Gender: ${data[index]["gender"]}"),
                    ],
                  ),
                );
              },
            );
          }
          return new CircularProgressIndicator();
        });
  }
}
