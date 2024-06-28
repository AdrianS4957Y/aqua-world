import "dart:isolate";
import "dart:math";

import "package:uuid/uuid.dart";

import "aquarium.dart";
import "enum.dart";
import "names.dart";

class Fish {
  String id = Uuid().v1();
  //milliseconds
  Duration lifespan = Duration();
  int _max_life = 1;
  String _firstName = '';
  String _lastName = '';
  // int timeToBreed = 0xFFFFFFFF;
  // bool breedable = false;
  LifeStatus isAlive = LifeStatus.alive;
  Gender gender = Random().nextBool() ? Gender.male : Gender.female;
  SendPort? sender;
  Aquarium? aquarium;
  Fish(SendPort sender, Aquarium aquarium) {
    this._max_life = Random().nextInt(aquarium.timeList["fishLife"] *
        aquarium.maxFishes ~/
        (aquarium.fishList.length != 0 ? aquarium.fishList.length : 1));
    this.sender = sender;
    this.aquarium = aquarium;
    Fullname fullname = Fullname(gender);
    _firstName = fullname.firstName;
    _lastName = fullname.lastName;
    aquarium.fishList.add(this);
    // aquarium.fishList = aquarium.fishList;
    print(
        "Рыбка ${_firstName} ${_lastName} добавлена в аквариум?! Время жизни: ${_max_life}");

    // this.timeToBreed = Random().nextInt(this._max_life ~/ 3);
  }
  addToAquarium(Aquarium aquarium, {mute = false}) {
    List<Fish> list = aquarium.fishList;
    list.add(this);
    aquarium.fishList = list;
    if (!mute)
      print(
          "Рыбка ${_firstName} ${_lastName} добавлена в аквариум?! Время жизни: ${_max_life}");
  }

  updateLifeTime(int time) {
    this.lifespan += Duration(milliseconds: time);
    aquarium!.listPopulationTime.update(this.id, (i) {
      // int life = aquarium!.listPopulationTime[this.id]!;
      return i - time;
    });
    // if(this.timeToBreed == 0){
    // 	sender!.send("Breedable");
    // 	this.timeToBreed = Random().nextInt(this._max_life ~/ 3);
    // }
    // print(this.status);
    if (this._max_life <= this.lifespan.inMilliseconds) _die();
  }

  _die() async {
    sender!.send("RIP");
  }

  eaten() {
    print("Акула сожрала бедного ${firstName} ${lastName}");
    _die();
  }

  String get status {
    return "id: ${this.id}, ${this.gender}, age: ${this.lifespan}, ${this.isAlive}";
  }

  get firstName {
    return _firstName;
  }

  get lastName {
    return _lastName;
  }
}
