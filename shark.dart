import 'dart:isolate';

import 'package:uuid/uuid.dart';

import 'aquarium.dart';

class Shark{
	String id = Uuid().v1();
  int huntTime = 0;
  SendPort? sender;
  bool _waiting = true;
  Aquarium? aquarium;
  Shark(Aquarium aquarium, SendPort sender){
    this.aquarium = aquarium;
    this.sender = sender;
  }
}