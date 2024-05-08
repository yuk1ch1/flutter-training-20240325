
## アーキテクチャ
presentation(screen or screen + controller) - model

### presentation
画面への表示、表示ロジックを担当

- screen: 各画面とその表示に必要なものの集まり。
    - modelとのやりとりが発生、肥大化する場合はscreenだけでなく別途controllerクラスを用意
    - 状態管理が必要な場合はRiverpodで行う
- components: 特定の画面に依存しないUIのパーツ


```mermaid
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px;
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px;
  end
  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end

  weatherScreenStateControllerProvider[["weatherScreenStateControllerProvider"]];
  WeatherDisplay((WeatherDisplay));
  WeatherScreen((WeatherScreen));

  weatherScreenStateControllerProvider ==> WeatherDisplay;
  weatherScreenStateControllerProvider --> WeatherScreen;
  weatherScreenStateControllerProvider -.-> WeatherScreen;
```

### model
特定の画面に依存しない、アプリ内で利用するデータやそのデータに関する処理、またデータの取得を担当