import 'package:flutter/material.dart';
import 'package:games/models/game_type/index.dart';
import 'package:games/widget/GameCardWidget.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<GameType> games = [MineSweeperGame(), MahJongGame()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.lightBlue.shade100,
              Colors.blue.shade900,
            ],
            stops: [0.2, 0.5, 0.8],
          ),
        ),
        // child: buildGameCardView(context, bombWidget, mahJong),
        child: Row(
          children: [
            for (GameType gameType in games)
            Expanded(
                child: GameCardWidget(gameType: gameType)
            ),
          ],
        ),
      ),
    );
  }

  Center buildGameCardView(BuildContext context, Widget bombWidget, Widget mahJong) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // 跳转到踩地雷游戏页面
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => bombWidget),
                );
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.warning, size: 100), // 使用适当的图标
                  Text('踩地雷')
                ],
              ),
            ),
            SizedBox(height: 50), // 添加一些间距
            GestureDetector(
              onTap: () {
                // 跳转到猜麻将游戏页面
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => mahJong),
                );
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.casino, size: 100), // 使用适当的图标
                  Text('猜麻将')
                ],
              ),
            ),
          ],
        ),
      );
  }
}