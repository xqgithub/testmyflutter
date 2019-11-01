import 'package:flutter/material.dart';

/**
 * 图片和ICON
 */

class ImageAndIcon extends StatefulWidget {
  @override
  _ImageAndIcon createState() => new _ImageAndIcon();
}

class _ImageAndIcon extends State<ImageAndIcon> {
  var imagepath = "http://img.jf258.com/uploads/2014-08-19/025742864.jpg";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("图片和ICON"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///从assets中加载图片
            new Container(
              child: new Image(
                image: new AssetImage("assets/images/error_null.png"),
                width: 150.0,
                height: 150.0,
              ),
            ),

            ///从网络中加载图片
            new Container(
              child: new Image(
                image: new NetworkImage(imagepath),
                width: 150.0,
                height: 150.0,
              ),
            ),

            ///ICON
            new Container(
              margin: EdgeInsets.only(top: 15.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.accessible,
                    color: Colors.green,
                    size: 50.0,
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.fingerprint,
                    color: Colors.purple,
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
