import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/enum/GameType.dart';
import 'package:games/gamePage/bloc/game_bloc.dart';
import 'package:games/gamePage/gamePage.dart';
import 'package:games/mahJong/bloc/mah_jong_bloc.dart';
import 'package:games/mahJong/mahJongPage.dart';
import 'package:games/widget/GameCardWidget.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GameBloc _gameBloc;
  MahJongBloc _mahJongBloc;
  @override
  void initState() {
    _gameBloc = GameBloc();
    _mahJongBloc = MahJongBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //踩地雷
    Widget bombWidget = BlocProvider(
      create: (BuildContext context) => _gameBloc,
      child: BlocBuilder<GameBloc, GameState>(
          builder: (BuildContext context, GameState state) {
            return Scaffold(
              appBar: AppBar(
                title: Container(
                  child: GestureDetector(
                    child: Icon(_gameBloc.gameOver?Icons.mood_bad:Icons.mood,size: 50,color: Colors.black,),
                    onTap: (){
                      _gameBloc.add(InitialGameData());
                    },
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    border: Border(
                      top: BorderSide(width: 4,color: Colors.white),
                      left: BorderSide(width: 4,color: Colors.white),
                      right: BorderSide(width: 4,color: Colors.black26),
                      bottom: BorderSide(width: 4,color: Colors.black26),
                    ),
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.grey,
              ),
              body: Center(
                child: GamePage(),
              ),
            );
          }),
    );

    //麻將
    Widget mahJong = BlocProvider(
        create: (BuildContext context) => _mahJongBloc,
        child: BlocBuilder<MahJongBloc, MahJongState>(
            builder: (BuildContext context, MahJongState state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: MahJongPage(),
                    // child: test,
                  ),
                ),// This trailing comma makes auto-formatting nicer for build methods.
              );
            }));



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
            for (GameType gameType in GameType.values)
            Expanded(
                child: GameCardWidget(gameType: gameType,)
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