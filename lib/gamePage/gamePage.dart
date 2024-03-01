import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/gamePage/bloc/game_bloc.dart';
import 'package:games/widget/Cube.dart';
import 'package:flutter/services.dart';

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
                    padding: EdgeInsets.all(3),
                    width: screenSize.width,
                    height: screenSize.height,
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
                );
              }
          ),
      ),
    );
  }
}

