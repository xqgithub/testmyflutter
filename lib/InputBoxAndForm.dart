import 'package:flutter/material.dart';

/**
 * 输入框和表单
 */

class InputBox extends StatefulWidget {
  @override
  _InputBoxState createState() => new _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  TextEditingController _unameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _unameController.addListener(() {
      print('input ${_unameController.text}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("输入框"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "请输入用户名",
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  prefixIcon: Icon(Icons.person),
//                  // 未获得焦点下划线设为灰色
//                  enabledBorder: UnderlineInputBorder(
//                    borderSide: BorderSide(color: Colors.grey),
//                  ),
//                  //获得焦点下划线设为蓝色
//                  focusedBorder: UnderlineInputBorder(
//                    borderSide: BorderSide(color: Colors.blue),
//                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                controller: _unameController, //设置controller,
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "您的登录密码",
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  prefixIcon: Icon(Icons.lock),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  //获得焦点下划线设为蓝色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                obscureText: true,
              ),
            ),
            buildTextField1(),
            new Container(
              width: 200.0,
              height: 50.0,
              margin: EdgeInsets.only(top: 20.0),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  "确定",
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.amber,
                highlightColor: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: new BorderSide(
                    color: Colors.indigoAccent,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///------------------------- 自定义TextFormField 设定border大小  ----------------------------------
Widget buildTextField() {
  return new Container(
    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
    padding: const EdgeInsets.all(8.0),
    alignment: Alignment.center,
    height: 60.0,
    decoration: new BoxDecoration(
      color: Colors.blueGrey,
      border: new Border.all(color: Colors.black54, width: 1.0),
      borderRadius: new BorderRadius.circular(12.0),
    ),
    child: new TextFormField(
      decoration: InputDecoration.collapsed(
        hintText: 'hello',
      ),
    ),
  );
}

///------------------------- 自定义TextField  ----------------------------------
Widget buildTextField1() {
  return new Theme(
    data: new ThemeData(primaryColor: Colors.red, hintColor: Colors.blue),
    child: new Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
  );
}

/**
 * 输入框验证
 */
class TextForm extends StatefulWidget {
  _TextFormState createState() => new _TextFormState();
}

class _TextFormState extends State<TextForm> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("输入框表单"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState,
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person),
                ),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                //校验密码
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
//                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                            print(
                                "用户名：${_unameController.text} =-= 密码：${_pwdController.text}");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
