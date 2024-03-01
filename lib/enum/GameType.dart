enum GameType {
  MineSweeper,
  MahJong,
}

extension GameTypeExtension on GameType {
  String get getTitle {
    switch (this) {
      case GameType.MineSweeper:
        return 'MineSweeper';
      case GameType.MahJong:
        return 'MahJong';
      default:
        return 'No title';
    }
  }

  String get getImagePath {
    switch (this) {
      case GameType.MineSweeper:
        return 'assets/img/gameIcon/bomb.png';
      case GameType.MahJong:
        return 'assets/img/gameIcon/mahjong.png';
      default:
        return 'assets/img/east.png';
    }
  }
}