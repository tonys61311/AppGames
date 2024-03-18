import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:games/model/CubeModel.dart';
import 'package:meta/meta.dart';
import 'dart:math';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  List<List<CubeModel>> cubeModels = [];
  int maxX = 10;
  int maxY = 10;
  int bombCount = 20;
  List<int> bombList = [];
  bool gameOver = false;
  bool isGameTouched = false; //該局遊戲是否已經點擊過，用於預防第一次點擊就點到炸彈

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if(event is InitialGameData){
      yield* mapInitialGameDataToState();
    }else if(event is ClickCube){
      yield* mapClickCubeToState(event.data);
    }else if(event is LongPressCube){
      yield* mapLongPressCubeToState(event.data);
    }
  }

  @override
  GameState get initialState => GameInitial();

  Stream<GameState> mapInitialGameDataToState() async*{
    reshuffle();

    yield RenderPages();
  }

  void reshuffle(){
    gameOver = false;
    cubeModels.clear();
    bombList.clear();
    isGameTouched = false;

    for(int i = 0 ; i < bombCount ; i++){
      int num = getNum(bombList);
      bombList.add(num);
    }

    //Initial格子model
    cubeModels = getCubeModels();
  }

  //Initial格子model
  List<List<CubeModel>> getCubeModels() {
    return List.generate(maxY, (indexY){
      return List.generate(maxX, (indexX){
        int i = indexY * maxX + indexX+1;
        return CubeModel(x: indexX+1,y: indexY+1,haveBomb: bombList.contains(i),count: getBombCount(indexX+1,indexY+1),id: i);
      });
    });
  }

  //取得周圍炸彈數量
  int getBombCount(int x,int y){
    List<int> aroundCubeId = getAroundCubeId(x,y);
    List result = bombList.where((e) => aroundCubeId.contains(e)).toList();
    return result.length;
  }

  //取得亂數編號
  int getNum(List<int> bombList){
    Random random = new Random();
    int totalCube = maxX * maxY;
    int num = random.nextInt(totalCube);
    if(bombList.contains(num)){
      num = getNum(bombList);
    }
    return num;
  }

  //第一次點擊，且點擊到炸彈，則將該cube之炸彈移除，並隨機挑選其他剩餘之cube放置炸彈，並回傳更新後的cube
  CubeModel doFistClick(CubeModel data){
    int num = getNum(bombList);
    bombList.remove(data.id);
    bombList.add(num);
    cubeModels = getCubeModels();
    return cubeModels[data.y-1][data.x-1];
  }

  //點擊格子並回傳是否勝利
  bool doClickCube(CubeModel data){
    print(isGameTouched);
    print(data);
    //若是第一次點擊，且點擊到炸彈，則將該cube之炸彈移除，並隨機挑選其他剩餘之cube放置炸彈
    if(!isGameTouched){
      //第一次點擊，需確保該格子無炸彈
      if(data.haveBomb){
        data = doFistClick(data);
      }
      isGameTouched = true;
    }

    data.isClick = true;
    //若點擊到炸彈，則顯示所有炸彈的位置
    if(data.haveBomb){
      gameOver = true;
      cubeModels.forEach((models) {
        models.forEach((model) {
          if(model.haveBomb){
            model.isClick = true;
          }
        });
      });
    }

    List<int> aroundId = getAroundCubeId(data.x,data.y);
    List<CubeModel> aroundModel = getAroundCubeModel(aroundId);
    //若點擊周圍皆無炸彈的格子，自動點擊周圍的所有格子
    if(data.  count == 0){
//      cubeModels.forEach((models) {
//        models.forEach((model) {
//          if(aroundId.contains(model.id) && !model.isClick){
//            doClickCube(model);
//          }
//        });
//      });
      aroundModel.forEach((model) {
        if(!model.isClick){
          doClickCube(model);
        }
      });

    }
    //點擊周圍有炸彈的格子，且周圍有炸彈的格子都正確插上旗子，則自動點擊其他沒有炸彈的格子
    if(aroundModel.every((e) => (e.haveBomb && e.haveFlag) || (!e.haveBomb && !e.haveFlag))){
      aroundModel.forEach((model) {
        if(!model.isClick && !model.haveFlag){
          doClickCube(model);
        }
      });
    }

    //若點擊到所有沒有炸彈的格子則將剩餘格子插上旗子，並顯示勝利視窗
    if(cubeModels.every((models) => models.every((model) => model.isClick || model.haveBomb))){
      cubeModels.forEach((models) {
        models.forEach((model) {
          if(!model.isClick){
            model.haveFlag = true;
          }
        });
      });
      return true;
    }
    return false;
  }

  Stream<GameState> mapClickCubeToState(CubeModel data) async*{
    yield doClickCube(data) ? WinDialog() : RenderPages();
  }

  Stream<GameState> mapLongPressCubeToState(CubeModel data) async*{
    data.haveFlag = !data.haveFlag;
    yield RenderPages();
  }

  //取得周圍格子id
  List<int> getAroundCubeId(int x,int y){
    List<int> aroundNum = [];
    for(int j = -1 ; j<2 ; j++){
      int indexY = y + j;
      if(indexY < 1 || indexY > maxY) continue;
      for(int i = -1 ; i<2 ; i++){
        int indexX = x + i;
        if(indexX < 1 || indexX > maxY) continue;
        aroundNum.add((indexY-1) * maxX + indexX);
      }
    }
    return aroundNum;
  }

  //取得周圍格子model
  List<CubeModel> getAroundCubeModel(List<int> aroundNum){
    List<CubeModel> aroundModel = [];
    cubeModels.forEach((models) {
      models.forEach((model) {
        if(aroundNum.contains(model.id)){
          aroundModel.add(model);
        }
      });
    });
    return aroundModel;
  }
}
