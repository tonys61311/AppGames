# AppGames

## 簡介

**AppGames** 是一個多功能遊戲應用，包含以下兩種遊戲模式：
1. **MineSweeper (踩地雷)**：經典邏輯益智遊戲，挑戰避免點擊到隱藏炸彈的格子。
2. **MahJong (猜麻將)**：結合記憶與策略的麻將遊戲，模擬麻將的洗牌與猜牌過程。

此應用基於 **Flutter**，使用 **BLoC 狀態管理**，具備簡潔的界面和高效的邏輯處理。

---

## Demo

[AppGames - Demo](https://tonys61311.github.io/AppGames)

## 功能特性

### MineSweeper
- **自動生成遊戲地圖**：基於行列數量和炸彈數生成地圖。
- **點擊格子檢測**：支持普通點擊與長按插旗。
- **炸彈檢測**：第一步確保不會點擊到炸彈。
- **自動掃描空白區域**：點擊空白區域會自動展開相鄰安全格子。
- **勝負判斷**：點擊到所有安全格子即勝利，點擊到炸彈則失敗。

### MahJong
- **模擬洗牌與發牌**：隨機生成麻將牌面。
- **雙人競技模式**：分為玩家 A 與玩家 B，依次猜測與記憶牌組。
- **自定義難度**：支持簡單、中等和高難度，影響牌組規則和生成邏輯。
- **牌組校驗**：判斷玩家是否匹配出正確的牌組。

---

## 技術棧

- **框架**：Flutter
- **狀態管理**：BLoC (flutter_bloc)
- **音效**：AudioPlayers
- **多平台支持**：
    - **網頁**: AudioManager 中實現了網頁音效管理。
    - **行動裝置**: 使用 AudioManager 處理音效播放與資源加載。
- **遊戲邏輯**：
    - 使用 `GameBloc` 管理踩地雷遊戲邏輯。
    - 使用 `MahJongBloc` 管理麻將遊戲邏輯。

---

## 專案結構

```plaintext
lib/
├── audio/                 # 音效管理
├── enum/                  # 遊戲相關枚舉
├── gamePage/              # 踩地雷遊戲邏輯
│   ├── bloc/              # 踩地雷的 BLoC 狀態管理
├── mahJong/               # 麻將遊戲邏輯
│   ├── bloc/              # 麻將的 BLoC 狀態管理
├── model/                 # 數據模型 (CubeModel, MJModel)
├── page/                  # 遊戲主頁
├── widget/                # 通用組件 (Cube, MahJong 等)
└── main.dart              # 入口文件
```

## 安裝與使用

### 環境需求
- Flutter：版本 >= 3.1.0
- Dart：版本 >= 2.18.0


### 安裝步驟
1. **克隆專案：**

        git clone https://github.com/tonys61311/AppGames.git

2. **進入專案目錄：**

        cd AppGames

3. **安裝依賴：**

        flutter pub get

4. **運行應用：**

        flutter run

### 使用方法
1. 運行應用後，進入主頁。
2. 選擇遊戲模式：
    - 點擊 **MineSweeper** 進入踩地雷。
    - 點擊 **MahJong** 進入猜麻將。
3. 開始遊戲！

