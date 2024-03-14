import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:games/enum/GameType.dart';
import 'package:games/mahJong/bloc/mah_jong_bloc.dart';
import 'package:games/model/MJModel.dart';
import 'package:games/widget/ChoiseCard.dart';
import 'package:games/widget/MahJong.dart';
import 'package:games/widget/newDropDown.dart';
import 'package:games/widget/widget.dart';
import '../audio/audio_manager.dart';


class MahJongPage extends StatefulWidget {

  const MahJongPage(
      {Key key,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return MJPageState();
  }
}

class MJPageState extends State<MahJongPage> {
  MahJongBloc _mahJongBloc; // 麻將遊戲的BLoC
  AudioManager audioManager = getAudioManager();
  // AudioCache mainPlayer = AudioCache(prefix: 'assets/audio/'); // 音效播放器
  bool back = true; // 是否顯示牌背
  bool side = false; // 是否顯示牌側面
  int time = 0; // 時間計數器
  bool start = false; // 遊戲是否開始
  List<int> posNum; // 位置編號列表
  List<int> turnsNum; // 旋轉編號列表
  List align = [ // 對齊方式列表
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.center,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];

  @override
  void initState() {
    super.initState();
    _mahJongBloc = MahJongBloc();
    doShuffle(); // 初始化時進行洗牌
  }

  void doShuffle() {
    time = 0;
    start = false;
    posNum = List.generate(30, (index) => 3); // 生成初始位置編號
    turnsNum = List.generate(30, (index) => 0); // 生成初始旋轉編號
    audioManager.preloadSound('shuffle.mp3'); // 預載音效
    audioManager.preloadSound('8002.mp3'); // 預載音效
    // mainPlayer.loadAll(['shuffle.mp3', '8002.mp3']); // 預載音效

    // 洗牌動畫
    Future.delayed(Duration(milliseconds: 50), () async {
      var player = await audioManager.playSound('8002.mp3'); // 播放音效
      Timer.periodic(Duration(milliseconds: 300), (timer) async {
        if (time > 4000) {
          timer.cancel();
          start = true;
          await audioManager.stopSound(player);
          await audioManager.playSound('shuffle.mp3');
          _mahJongBloc.add(InitialMJData()); // 初始化麻將數據
        }
        time += 300;
        setState(() {
          posNum = List.from(random(1, 6, 30)); // 隨機生成位置編號
          turnsNum = List.from(random(1, 5, 30)); // 隨機生成旋轉編號
        });
      });
    });

    // 麻將側面和背面的顯示控制
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        side = true;
      });
    });
    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        side = false;
        back = false;
      });
    });
  }

  List<Map> getLevelData() {
    // 獲取難度等級數據
    return Level.values.map((e) => {'display': e.getTCText, 'value': e.getText}).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cWidth = size.width;
    final cHeight = size.height;
// TODO: implement build
    return BlocProvider(
      create: (BuildContext context) => _mahJongBloc,
      child: BlocListener<MahJongBloc, MahJongState>(
        listener: (BuildContext context, MahJongState state) {
          if(state is RestartState){
            audioManager.playSound('shuffle.mp3');
            back = true;
            Future.delayed(Duration(milliseconds: 1000),(){
              setState(() {
                side = true;
              });
            });
            Future.delayed(Duration(milliseconds: 1200),(){
              setState(() {
                side = false;
                back = false;
              });
            });
          }else if(state is CheckAnswerState){
            if(state.bingo){
              showAppDialog(context,AppDialog(
                title: '提示訊息',
                width: 750,
                height: 380,
                closeIcon: false,
                actionButtons: <Widget>[
                  PrimaryButton(
                    label: '重新發牌',
                    color: Color(0xFF26ACA9),
                    onPressed: () {
                      doShuffle();
                      Navigator.of(context).pop();
                    },
                  )
                ],
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text('恭喜${state.winner}勝利',
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
          }
//        else if(state is ChangeFieldState){
//          switch(state.field){
//            case 'patternA':
//              patternA = state.val;
//              break;
//            case 'numberA':
//              numberA = state.val;
//              break;
//            case 'patternB':
//              patternB = state.val;
//              break;
//            case 'numberB':
//              numberB = state.val;
//              break;
//          }
//        }
        },
        child: BlocBuilder<MahJongBloc, MahJongState>(
            builder: (BuildContext context, MahJongState state) {
//            if(state is MahJongInitial){
//              _mahJongBloc.add(InitialMJData());
//            }
              return Scaffold(
                appBar: AppBar(
                  title: Text(GameType.MahJong.getTitle),
                ),
                body: Container(
                    padding: EdgeInsets.only(top:30,bottom: 30,right: 15,left:15),
                    width: cWidth,
                    height: cHeight,
                    child: start ?  buildGameView(cWidth) :
                    buildShuffleView(cWidth, cHeight)

                ),
              );
            }
        ),
      ),
    );
  }

  Column buildGameView(double cWidth) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Expanded(
                      child: RotatedBox(
                        quarterTurns: 2,
                        child:  buildOnePlayerView('A'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryButton(
                          label: '重新發牌',
                          onPressed: (){
                            doShuffle();
//                          _mahJongBloc.add(InitialMJData());
                          },
                        ),
                        Container(
                          width: 110,
                          padding: EdgeInsets.all(16),
                          child: NewDropDownFormField(
                            titleText: '難度',
                            hintText: '選擇難度',
                            value: _mahJongBloc.level.getText,
                            onChanged: (value) {
                              _mahJongBloc.level = LevelHelper.getLevel(value);
                              _mahJongBloc.add(DoRenderPages());
                            },
                            dataSource: getLevelData(),
                            textField: 'display',
                            valueField: 'value',
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: buildOnePlayerView('B'),
                    )
                  ]
              );
  }

  Column buildOnePlayerView(String role) {
    List<MJModel> answers;
    if (role == 'A') {
      answers = _mahJongBloc.aAnswer;
    } else if (role == 'B') {
      answers = _mahJongBloc.bAnswer;
    } else {
      // 默认或错误处理，根据需要添加
      answers = [];
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              border: Border(
                right: BorderSide(width: 5, color: Colors.white),
                bottom: BorderSide(width: 5, color: Colors.white),
                left: BorderSide(width: 4, color: Colors.grey[300]),
                top: BorderSide(width: 4, color: Colors.grey[300]),
              ),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  children: [
                    for (var i = 0; i < answers.length; i++)
                      MJView(
                        margin: EdgeInsets.only(left: 4, right: 4),
                        back: false,
                        model: answers[i],
                        hasDel: true,
                        onDel: () {
                          // 删除
                          MJModel mod = answers[i];
                          answers.removeWhere((e) => e.type == mod.type && e.num == mod.num);
                          _mahJongBloc.add(CheckAnswer(role: role));
                        },
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
        ChoiseCard(
          onConfirm: (MJModel model) {
            if (answers.every((e) => e.type != model.type || e.num != model.num)) {
              answers.add(model);
            }
            _mahJongBloc.add(CheckAnswer(role: role));
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < _mahJongBloc.mJData.length; i++)
                Flexible(
                  child: MJView(
                    back: back,
                    side: side,
                    model: _mahJongBloc.mJData[i],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Center buildShuffleView(double cWidth, double cHeight) {
    double smallSide = cWidth > cHeight ? cHeight : cWidth;
    return Center(
                  child: Container(
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black,width: 10),
                        //shape: BoxShape.circle,
                      ),
                      child:Stack(
                        children: [
                          for(var i in posNum)
                            AnimatedContainer(
                              alignment: align[posNum[posNum.indexOf(i)]-1],
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 500),
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 500),
                                child: RotatedBox(
                                    quarterTurns:turnsNum[posNum[posNum.indexOf(i)]],
                                    child: SizedBox(
                                      width: smallSide/5,
                                      height: smallSide/5 * 1.4,
                                      child: MJView(
                                        back: true,
                                        side:false,
                                      ),
                                    )
                                ),// 设置时间
                              ),
                            ),
                        ],
                      )
                  )
              );
  }
}

List<int> random(int min, int max, int num) {
  List<int> numList = [];
  while (numList.length <= num) {
    var rn = new Random();
    if(numList.length>0){
      var x = min + rn.nextInt(max - min);
      if(x != numList.last){
        numList.add(x);
      }
    }else{
      numList.add(min + rn.nextInt(max - min));
    }
  }
  return numList;
}

