import 'status.dart';
import 'trashs.dart';
// キャラクターの状態に応じたゴミの配置を定義するエクステンション
extension LifeStateLayout on LifeState {

  List<TrashObject> get trashLayout {

    switch (this) {
      // RIP
      case LifeState.rip:
        return [

          TrashObject(
            image: '',
            x: 0.5,
            y: 0.82,
            width: 260,
            height: 260,
          ),

          TrashObject(
            image: '',
            x: 0.2,
            y: 0.85,
            width: 90,
            height: 90,
            rotation: -0.3,
          ),

          TrashObject(
            image: '',
            x: 0.8,
            y: 0.83,
            width: 100,
            height: 100,
            rotation: 0.4,
          ),
        ];

      // critical
      case LifeState.critical:
        return [

          TrashObject(
            image: '',
            x: 0.5,
            y: 0.84,
            width: 180,
            height: 180,
          ),

          TrashObject(
            image: '',
            x: 0.25,
            y: 0.8,
            width: 70,
            height: 70,
          ),
        ];

      // danger
      case LifeState.danger:
        return [

          TrashObject(
            image: '',
            x: 0.7,
            y: 0.82,
            width: 60,
            height: 60,
          ),
        ];

      // dirty
      case LifeState.dirty:
        return [

          TrashObject(
            image: '',
            x: 0.7,
            y: 0.82,
            width: 60,
            height: 60,
          ),
        ];

      // normal
      case LifeState.normal:
        return [

          TrashObject(
            image: '',
            x: 0.7,
            y: 0.82,
            width: 60,
            height: 60,
          ),
        ];
      
      // slightlyDirty
      case LifeState.slightlyDirty:
        return [

          TrashObject(
            image: '',
            x: 0.7,
            y: 0.82,
            width: 60,
            height: 60,
          ),
        ];
      
      // clean
      case LifeState.clean:
        return [];
      
      // perfect
      case LifeState.perfect:
        return [];

      // god
      case LifeState.god:
        return [];
    }
  }
}