class MJModel {
  int num;
  MJType type;

  MJModel({this.num,this.type});

  String getFileName(){
    return '${type.getText}_$num';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['type'] = this.type.getText;
    return data;
  }

  int getIndex(){
    int result;
    if(type.isNotText){
      result = type.index * 10 + num;
    }else{
      result = type.index * 10 + 1;
    }
    return result;
  }
}

enum MJType {
  wan, //萬
  ton , //筒
  tiao, //條
  east, //東
  south, //南
  west, //西
  north, //北
  red, //中
  green, //發
  white, //白
}

class MJTypeHelper {
  static MJType getMJType(String typeName) {
    return MJType.values
        .firstWhere((element) => element.getText == typeName ,orElse: ()=>null);
  }
}

extension MJTypeExtension on MJType {
  bool get isNotText {
    switch (this) {
      case MJType.wan:
        return true;
      case MJType.ton:
        return true;
      case MJType.tiao:
        return true;
      default:
        return false;
    }
  }

  String get getText {
    switch (this) {
      case MJType.east:
        return 'east';
      case MJType.south:
        return 'south';
      case MJType.west:
        return 'west';
      case MJType.north:
        return 'north';
      case MJType.red:
        return 'red';
      case MJType.green:
        return 'green';
      case MJType.white:
        return 'white';
      case MJType.wan:
        return 'wan';
      case MJType.ton:
        return 'ton';
      case MJType.tiao:
        return 'tiao';
      default:
        return '';
    }
  }

  String get getTCText {
    switch (this) {
      case MJType.east:
        return '東';
      case MJType.south:
        return '南';
      case MJType.west:
        return '西';
      case MJType.north:
        return '北';
      case MJType.red:
        return '紅中';
      case MJType.green:
        return '發財';
      case MJType.white:
        return '白板';
      case MJType.wan:
        return '萬';
      case MJType.ton:
        return '筒';
      case MJType.tiao:
        return '條';
      default:
        return '';
    }
  }
}

enum PatternType {
  Straight, //三張依照順序
  pong, //三張一樣
  pair, //兩張一樣
}

enum Level {
  high, //高
  medium, //中
  low, //低
}

extension LevelExtension on Level {
  String get getText {
    switch (this) {
      case Level.high:
        return 'high';
      case Level.medium:
        return 'medium';
      case Level.low:
        return 'low';
      default:
        return '';
    }
  }

  String get getTCText {
    switch (this) {
      case Level.high:
        return '高';
      case Level.medium:
        return '中';
      case Level.low:
        return '低';
      default:
        return '';
    }
  }
}

class LevelHelper {
  static Level getLevel(String typeName) {
    return Level.values
        .firstWhere((element) => element.getText == typeName ,orElse: ()=>null);
  }
}