import 'dart:isolate';
import 'dart:math';

import 'package:uuid/uuid.dart';

import 'aquarium.dart';

class Shark {
  String id = Uuid().v1();
  int huntTime = 0;
  SendPort? sender;
  bool _waiting = true;
  Aquarium? aquarium;
  Shark(Aquarium aquarium, SendPort sender) {
    this.aquarium = aquarium;
    this.sender = sender;
  }
  eatRandom() {
    _waiting = false;
    int randomFish = Random().nextInt(aquarium!.fishList.length);
    print("Акула хочет кушать");
    aquarium!.removeFish(aquarium!.fishList.elementAt(randomFish));
    generateRandomTime();
  }

  get waiting {
    return _waiting;
  }

  generateRandomTime() {
    this.huntTime = Random().nextInt(aquarium!.timeList["fishLife"]);
  }
}
