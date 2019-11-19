import 'package:flutter/material.dart';

/**
 * Scaffold、TabBar、底部导航
 * Scaffold是一个路由页的骨架，我们使用它可以很容易地拼装出一个完整的页面
 */

class TestScaffold extends StatefulWidget {
  _TestScaffold createState() => new _TestScaffold();
}

/**
 * 实现一个页面
 * 1.一个导航栏
 * 2.导航栏右边有一个分享按钮
 * 3.有一个抽屉菜单
 * 4.有一个底部导航
 * 5.右下角有一个悬浮的动作按钮
 */
class _TestScaffold extends State<TestScaffold>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  ///切换选项卡
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///悬浮按钮添加事件
  void _onAdd() {}

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
    //顶部tab切换监听
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          print("tab${_tabController.index}被选择了");
          break;
        case 1:
          print("tab${_tabController.index}被选择了");
          break;
        case 2:
          print("tab${_tabController.index}被选择了");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///AppBar是一个Material风格的导航栏，通过它可以设置导航栏标题、导航栏菜单、导航栏底部的Tab标题等
      appBar: AppBar(
        title: Text("Scaffold、TabBar、底部导航"),

        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),

        ///
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: Colors.blue), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              Scaffold.of(context).openDrawer();
            },
          );
        }),

        ///导航栏右侧菜单
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),

      ///抽屉
      drawer: new MyDrawer(),

      /// 底部导航
      bottomNavigationBar: _bottomNavigationBar2(_selectedIndex, _onItemTapped),

      ///悬浮按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),

      ///悬浮按钮位置
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: _tabPage(_tabController, tabs),
    );
  }
}

///创建tab页
_tabPage(TabController _tabController, List tabs) {
  return TabBarView(
    controller: _tabController,
    children: tabs.map((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(e, textScaleFactor: 5),
      );
    }).toList(),
  );
}

///底部菜单栏
_bottomNavigationBar1(_selectedIndex, _onItemTapped) {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.business), title: Text('Business')),
      BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
    ],
    currentIndex: _selectedIndex,
    fixedColor: Colors.blue,
    onTap: _onItemTapped,
  );
}

///BottomAppBar 组件，它可以和FloatingActionButton配合实现这种“打洞”效果
_bottomNavigationBar2(_selectedIndex, _onItemTapped) {
  return BottomAppBar(
    color: Colors.white,
    shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
    child: Row(
      children: [
        IconButton(
          onPressed: () {
            print("首页被点击了");
          },
          icon: Icon(Icons.home),
        ),
        SizedBox(), //中间位置空出
        IconButton(
          onPressed: () {
            print("附加页被点击了");
          },
          icon: Icon(Icons.business),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
    ),
  );
}

///Scaffold的drawer和endDrawer属性可以分别接受一个Widget来作为页面的左、右抽屉菜单
///左边抽屉类
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true, //移除抽屉菜单顶部默认留白
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/error_null.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
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
