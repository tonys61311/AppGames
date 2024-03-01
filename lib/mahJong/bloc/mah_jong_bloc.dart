import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:games/model/MJModel.dart';
import 'package:meta/meta.dart';

part 'mah_jong_event.dart';
part 'mah_jong_state.dart';

class MahJongBloc extends Bloc<MahJongEvent, MahJongState> {
  //發完的牌
  List<MJModel> mJData = [];
  //聽取的牌
  List<MJModel> resultKeyCard = [];
  //A的答案
  List<MJModel> aAnswer = [];
  //B的答案
  List<MJModel> bAnswer = [];
  //難度
  Level level = Level.medium;
  //難度為高時，固定的花色
  MJType highLevelMJType;

  @override
  Stream<MahJongState> mapEventToState(
    MahJongEvent event,
  ) async* {
    if(event is InitialMJData){
      yield* mapInitialMJDataToState();
    }else if(event is GetKeyCards){
      yield* mapGetKeyCardsToState();
    }else if(event is ChangeField){
      yield ChangeFieldState(field: event.field, val: event.val);
    }else if(event is DoRenderPages){
      yield RenderPages();
    }else if(event is CheckAnswer){
      yield* mapCheckAnswerToState(event.role);
    }
  }

  @override
  // TODO: implement initialState
  MahJongState get initialState => MahJongInitial();

  Stream<MahJongState> mapGetKeyCardsToState() async*{
    List<MJModel> resultKeyCard = [];
    MJType.values.forEach((mJType) {
      if(mJType.isNotText){
        for(int i = 1 ; i<=9 ; i++){
          MJModel keyCard = MJModel(num: i, type: mJType);
          //若此牌在牌裡已有四張，則return
          if(mJData.where((card) => card.type == keyCard.type && card.num == keyCard.num).length>3) continue;
          if(checkKeyCard(mJData, keyCard)){
            resultKeyCard.add(keyCard);
          }
        }
      }else{
        MJModel keyCard = MJModel(num: 0, type: mJType);
        if(checkKeyCard(mJData, keyCard)){
          resultKeyCard.add(keyCard);
        }
      }
    });

    print('聽取的牌');
    print(resultKeyCard.map((e) => e.toJson()).toList());

    yield RestartState();
  }

  Stream<MahJongState> mapInitialMJDataToState() async*{
    mJData.clear();
    aAnswer.clear();
    bAnswer.clear();
    resultKeyCard.clear();
    //若為高難度，則固定花色
    highLevelMJType = MJType.values[Random().nextInt(3)];
    Random random = Random();
    for(int i = 0; i<5 ; i++){
      int rdNum = random.nextInt(PatternType.values.length - 1);
      PatternType patternType = PatternType.values[rdNum];
      mJData += getMJModel(mJData,patternType);
    }

    mJData += getMJModel(mJData,PatternType.pair);

    print('發完的牌');
    print(mJData.map((e) => e.toJson()).toList());

    //取出任一張牌
    MJModel card = mJData.removeAt(random.nextInt(17));
    print('任意取出的一張牌');
    print(card.toJson());

    MJType.values.forEach((mJType) {
      if(mJType.isNotText){
        for(int i = 1 ; i<=9 ; i++){
          MJModel keyCard = MJModel(num: i, type: mJType);
          //若此牌在牌裡已有四張，則return
          if(mJData.where((card) => card.type == keyCard.type && card.num == keyCard.num).length>3) continue;
          if(checkKeyCard(mJData, keyCard)){
            resultKeyCard.add(keyCard);
          }
        }
      }else{
        MJModel keyCard = MJModel(num: 0, type: mJType);
        if(checkKeyCard(mJData, keyCard)){
          resultKeyCard.add(keyCard);
        }
      }
    });

    print('聽取的牌');
    print(resultKeyCard.map((e) => e.toJson()).toList());

    //將牌排序
    mJData.sort((MJModel a, MJModel b){
      return a.getIndex().compareTo(b.getIndex());
    });

    yield RestartState();
  }

  bool isSame(List<MJModel> resultKeyCard, List<MJModel> answer){
    if(resultKeyCard.length != answer.length) return false;
    return resultKeyCard.every((e){
      return answer.any((ele) => ele.type == e.type && ele.num == e.num);
    });
  }

  Stream<MahJongState> mapCheckAnswerToState(String role) async*{
    bool result = false;
    if(role == 'A'){
      result = isSame(resultKeyCard, aAnswer);
    }else if(role == 'B'){
      result = isSame(resultKeyCard, bAnswer);
    }
    yield CheckAnswerState(bingo: result,winner: role);
  }

  //是否聽此牌
  bool checkKeyCard(List<MJModel> mJData, MJModel keyCard){
    bool result = false;
    List<MJModel> data = [...mJData, keyCard];

    //有兩張以上一樣的牌
    List<MJModel> twoSameCard = getSameCards(data, 2);
    //若無眼睛，則無聽牌
    if(twoSameCard.isEmpty) return result;

    twoSameCard.forEach((e) {
      //取出眼睛後的牌
      List<MJModel> data1 = clearSameCards(data, e, 2);
      //取出順子或三張相同
      data1 = checkCards(data1);
      //取出三張相同
//      data1 = checkThreeSameCards(data1);
      result = result || data1.isEmpty;

//      //取出眼睛後的牌
//      List<MJModel> data2 = clearSameCards(data, e, 2);
//      //取出順子
//      data2 = checkCards(data2);
//      //取出三張相同
//      data2 = checkThreeSameCards(data2);
//      result = result || data2.isEmpty;
    });
    return result;
  }

  List<MJModel> checkCards(List<MJModel> data1) {
    MJType.values.forEach((mJType) {
      for(int i = 1 ; i <= 9; i++){
        MJModel card = MJModel(type: mJType, num: mJType.isNotText ? i : 0);
        if(checkCard(data1, card, 3)){
          data1 = clearSameCards(data1, card, 3);
        }
        bool flag = true;
        while(flag){
          List<MJModel> data2 = clearStraightCards(data1, card);
          flag = flag && data1.length != data2.length;
          data1 = data2;
        }
      }
    });
    return data1;
  }

  //取出三張相同
  List<MJModel> checkThreeSameCards(List<MJModel> data1) {
    //有三張以上一樣的牌
    List<MJModel> sameCard = getSameCards(data1, 3);
    sameCard.forEach((card) {
      data1 = clearSameCards(data1, card, 3);
    });
    return data1;
  }

  //檢查此牌是否在data裡
  bool checkCard(List<MJModel> data, MJModel card, int count){
    return data.where((ele) => ele.type == card.type && ele.num == card.num).length >= count;
  }

  List<MJModel> clearStraightCards(List<MJModel> data, MJModel e) {
    MJModel card1 = e;
    MJModel card2 = MJModel(type: e.type, num: e.num + 1);
    MJModel card3 = MJModel(type: e.type, num: e.num + 2);
    if(checkCard(data, card1, 1) && checkCard(data, card2, 1) && checkCard(data, card3, 1)){
      data = clearSameCards(data, card1, 1);
      data = clearSameCards(data, card2, 1);
      data = clearSameCards(data, card3, 1);
      return data;
    }
    return data;
  }

  List<MJModel> clearSameCards(List<MJModel> data, MJModel e, int count /* 移除張數 */) {
    int sameCount = 0;
    return data.where((ele){
      bool flag = e.type != ele.type || e.num != ele.num;
      sameCount = !flag ? sameCount + 1 : sameCount;
      return flag || sameCount > count;
    }).toList();
  }

  //取得相同的牌
  List<MJModel> getSameCards(List<MJModel> data, int count /* 幾張以上相同 */) {
    List<MJModel> sameCard = [];
    data.forEach((e) {
      if(sameCard.any((card) => card.type == e.type && card.num == e.num)) return;
      if(data.where((ele) => e.type == ele.type && e.num == ele.num).length >= count){
        sameCard.add(e);
      }
    });
    return sameCard;
  }

  //取得隨機花色
  MJType getRandomMJType(){
    int levelNum = level == Level.low ? 5 : 4;
    int rdNum = Random().nextInt(levelNum);
    switch(rdNum){
      case 0:
      case 1:
      case 2:
      case 3:
        rdNum = Random().nextInt(3);
        //若為高難度，則固定花色
        return level == Level.high ? highLevelMJType : MJType.values[rdNum];
      case 4:
        rdNum = Random().nextInt(MJType.values.length-3) + 3;
        return MJType.values[rdNum];
      default:
        return MJType.values[0];
    }
  }
  //取得一組model(一對、碰、順子)
  List<MJModel> getMJModel(List<MJModel> mJData, PatternType patternType) {
    List<MJModel> result = [];
    MJType type = getRandomMJType();
    //如果為順子且為文字，則須重取
    while(!type.isNotText && patternType == PatternType.Straight){
      type = getRandomMJType();
    }

    int num = type.isNotText ? Random().nextInt(9) + 1 : 0;
    //取三張一樣走這裡
    if(patternType == PatternType.pong){
      int count = mJData.where((e) => e.num == num && e.type == type).length;
      //若張數不夠，再取一次
      if(count > 1){
        result = getMJModel(mJData,patternType);
      }else{
        result = List.generate(3, (index) => MJModel(num: num, type: type));
      }
    }else if(patternType == PatternType.Straight){ //取順子走這裡
      num = Random().nextInt(7) + 1;
      result = List.generate(3, (index) => MJModel(num: num + index, type: type));
      bool flag = result.any((e){
        int count = mJData.where((ele) => ele.num == e.num && ele.type == e.type).length;
        return count > 3;
      });
      //若張數不夠，再取一次
      if(flag){
        result = getMJModel(mJData,patternType);
      }
    }else if(patternType == PatternType.pair){ //取一對走這裡
      int count = mJData.where((e) => e.num == num && e.type == type).length;
      result = List.generate(2, (index) => MJModel(num: num, type: type));
      if(count > 2){
        result = getMJModel(mJData,patternType);
      }
    }
    return result;
  }

}
