import 'package:flutter/material.dart';

/**
 * 尺寸限制类容器1
 */

class SizeLimitContainer extends StatefulWidget {
  _SizeLimitContainer createState() => new _SizeLimitContainer();
}

class _SizeLimitContainer extends State<SizeLimitContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("尺寸限制类容器"),
      ),
      body: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
                minHeight: 50.0 //最小高度为50像素
                ),
            child: Container(
              height: 5.0,
              child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
            ),
          ),

          ///实际上SizedBox只是ConstrainedBox的一个定制
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Container(
              height: 5.0,
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
            ),
          ),

          ///多重限制,对于minWidth和minHeight来说，是取父子中相应数值较大的
          ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                //子
                child: Container(
                  height: 5.0,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.amber)),
                ),
              )),
        ],
      ),
    );
  }
}
