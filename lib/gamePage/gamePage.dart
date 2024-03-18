import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/gamePage/bloc/game_bloc.dart';
import 'package:games/widget/Cube.dart';
import 'package:flutter/services.dart';
import 'package:games/widget/widget.dart';

class GamePage extends StatefulWidget {

  const GamePage(
      {Key key,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return GamePageState();
  }
}

class GamePageState extends State<GamePage> {
  GameBloc _gameBloc;
  @override
  void initState() {
    _gameBloc = GameBloc();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
// TODO: implement build
    return BlocProvider(
      create: (BuildContext context) => _gameBloc,
      child: BlocListener<GameBloc, GameState>(
          listener: (BuildContext context, GameState state) {
            if(state is RenderPages){

            } else if (state is WinDialog){
              showAppDialog(context,AppDialog(
                title: '提示訊息',
                width: 750,
                height: 380,
                closeIcon: false,
                actionButtons: <Widget>[
                  PrimaryButton(
                    label: 'Restart', //'重新開始',
                    color: Color(0xFF26ACA9),
                    onPressed: () {
                      _gameBloc.add(InitialGameData());
                      Navigator.of(context).pop();
                    },
                  )
                ],
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text('Congratulations You Win', // Text('恭喜${state.winner}勝利',
                      style: TextStyle(
                        color: Color(0xff373a3c),
                        fontSize: 30 ,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ),
              ));
            }
          },
          child: BlocBuilder<GameBloc, GameState>(
              builder: (BuildContext context, GameState state) {
                if(state is GameInitial){
                  _gameBloc.add(InitialGameData());
                }
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
                  body: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "MineSweeper", // 游戏标题
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // 标题文字颜色
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 314,
                            height: 314,
                            decoration: new BoxDecoration(
                              color: Colors.grey,
                              border: Border(
                                top: BorderSide(width: 4,color: Colors.white),
                                left: BorderSide(width: 4,color: Colors.white),
                                right: BorderSide(width: 4,color: Colors.black26),
                                bottom: BorderSide(width: 4,color: Colors.black26),
                              ),
                            ),
                            child: Column(
                              children: [
                                for(var datas in _gameBloc.cubeModels)
                                Row(
                                  children: [
                                    for(var data in datas)
                                      Cube(
                                        data: data,
                                        onTap: (){
                                          if(!data.haveFlag && !_gameBloc.gameOver){
                                            _gameBloc.add(ClickCube(data: data));
                                          }
                                        },
                                        onLongPress: (){
                                          if(!_gameBloc.gameOver){
                                            _gameBloc.add(LongPressCube(data: data));
                                          }
                                        },
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox())
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
      ),
    );
  }
}

