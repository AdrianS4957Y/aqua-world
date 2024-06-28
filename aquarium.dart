import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

import 'enum.dart';
import 'fish.dart';

class Aquarium {
  double height = 1;
  double width = 1;
  double length = 1;
  int maxFishes = 1;
  List<Fish> fishList = [];
  Map<String, int> listPopulationTime = {};
  // SendPort? sender;
  Aquarium({double? height, double? width, double? length, int? fishesCount}) {
    height = double.parse(
        (height ?? math.Random().nextDouble() * 50).toStringAsFixed(4));
    width = double.parse(
        (width ?? math.Random().nextDouble() * 50).toStringAsFixed(4));
    length = double.parse(
        (length ?? math.Random().nextDouble() * 50).toStringAsFixed(4));
    // sender = sender;
    final random = fishesCount ?? (math.pow(volume, 1 / 3) * 10).floor();
    maxFishes = random < 10 ? 10 : random;
    print(
        "У вас теперь есть аквариум c размерами ${height}*${width}*${length}. В нём могут поместится ${maxFishes} рыбок");
    initFishes();
    final timerReceiver = ReceivePort();
    final timerIsolate = Isolate.spawn((SendPort sender) async {
      print("Создаем таймер");
      // final timer =
      await Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
        sender.send({"name": "time", "value": 10, "tick": timer.tick});
      });
      // killer(){
      // 	print("Killing timer");
      // 	timer.cancel();
      // }
      // sender.send({ "name": "killer", "value": killer });
    }, timerReceiver.sendPort);
    timerReceiver.listen((message) {
      Map<Gender, List<String>> listOfBreedables = {
        Gender.male: [],
        Gender.female: [],
      };
      try {
        if (message["name"] == "time") {
          this
              .listPopulationTime
              .updateAll((id, time) => time + (message["value"] as int));
          fishList.forEach((Fish fish) {
            fish.updateLifeTime(message["value"]);
            if (listPopulationTime[fish.id]! >= breedTime) {
              listOfBreedables[fish.gender]!.add(fish.id);
            }
          });
          // if((listOfBreedables[Gender.male]!.length+listOfBreedables[Gender.female]!.length) > maxFishes)print((listOfBreedables[Gender.male]!.length+listOfBreedables[Gender.female]!.length));
          if (listOfBreedables[Gender.male]!.length <
              listOfBreedables[Gender.female]!.length) {
            for (String id in listOfBreedables[Gender.male]!) {
              if (fishList.length >= maxFishes) break;
              listPopulationTime.update(
                  listOfBreedables[Gender.female]!.first, (i) => 0);
              listPopulationTime.update(id, (i) => 0);
              addFish();
              // listOfBreedables[Gender.male]!.remove(id);
              listOfBreedables[Gender.female]!
                  .remove(listOfBreedables[Gender.female]!.first);
            }
          } else {
            for (String id in listOfBreedables[Gender.female]!) {
              if (fishList.length >= maxFishes) break;
              listPopulationTime.update(
                  listOfBreedables[Gender.male]!.first, (i) => 0);
              listPopulationTime.update(id, (i) => 0);
              addFish();
              // listOfBreedables[Gender.female]!.remove(id);
              listOfBreedables[Gender.male]!
                  .remove(listOfBreedables[Gender.male]!.first);
            }
          }
          // if(fish.gender == Gender.male){
          // 	if(listOfBreedables[Gender.female]!.length == 0)
          // 		return listOfBreedables[Gender.male]!.add(fish.id);
          // 	// listOfBreedables[Gender.female]!.shuffle();
          // 	// listOfBreedables[Gender.female]!.remove(listOfBreedables[Gender.female]!.first);
          // 	addFish();
          // }else{
          // 	if(listOfBreedables[Gender.male]!.length == 0)
          // 		return listOfBreedables[Gender.female]!.add(fish.id);
          // 	listOfBreedables[Gender.male]!.shuffle();
          // 	listOfBreedables[Gender.male]!.remove(listOfBreedables[Gender.female]!.first);
          // 	return addFish();
          // }
          // }
        }
        if (fishList.length == 0) {
          timerIsolate.then((isolate) => isolate.kill());
          timerReceiver.close();
        }
        if ((message["tick"] * message["value"]) % 1000 == 0) {
          print(status);
        }
      } catch (e) {
        print(message);
        print(e);
      }
    });
  }
  get volume {
    return height * width * length;
  }

  initFishes() {
    int initialValue = math.Random().nextInt(maxFishes);
    for (int i = 0; i < (initialValue < 4 ? 4 : initialValue); i++) {
      addFish();
    }
  }

  fishIsolate(SendPort sender) async {
    final fish = await Fish(sender, this);
    this.listPopulationTime[fish.id] = breedRandomizer();
    sender.send("id: fish.id");
  }

  addFish() async {
    final receiver = ReceivePort();
    final isolate = await Isolate.spawn(fishIsolate, receiver.sendPort);
    String? fishId;
    receiver.listen((message) async {
      if (message.toString().startsWith("id:")) {
        // await message.addToAquarium(this);
        fishId = message.toString().replaceFirst("id: ", '');
        listPopulationTime[fishId!] = 0;
      }
      switch (message) {
        case "RIP":
          // removeFish(fishId!);
          isolate.kill();
          receiver.close();
          fishList.removeWhere((Fish can) => can.id == fishId!);
          await this.listPopulationTime.remove(fishId!);
          break;
      }
    });
    // fishList.add(fish);
    // print("${fishList.length}-я рыбка с id ${fish.id} добавлена в аквариум");
    // print(fish.status);
  }

  removeFish(Fish fish, {deathSource}) async {
    if (deathSource == "eaten") return fish.eaten();
    print("Рыбка ${fish.firstName} ${fish.lastName} покинула этот мир =(");
    // print("Произошла ошибка и рыбка не убрана");
    // return false;
  }

  String get status {
    List sorted = this.listPopulationTime.entries.toList();
    sorted.sort((a, b) =>
        (b as MapEntry<String, int>).value -
        (a as MapEntry<String, int>).value);
    String str =
        "Кол-во рыбок ${fishList.length} ${listPopulationTime.length} ";
    // print(sorted.toString());
    for (int i = 0; i < (sorted.length > 10 ? 5 : sorted.length); i++) {
      // print(sorted[i]);
      str = "$str | ${this.listPopulationTime[sorted[i].key]} ";
    }
    return str;
  }

  get breedTime {
    if (maxFishes < fishList.length) return 0xFFFFFFFF;
    int random = math.Random().nextInt(timeList["fishLife"] ~/
        2 *
        maxFishes ~/
        (fishList.length == 0 ? 1 : fishList.length));
    return random > timeList["fishLife"] ~/ 4 ? random : breedTime;
  }

  int breedRandomizer() {
    return math.Random().nextInt(timeList["fishLife"] ~/ 2);
  }

  get timeList {
    return {"fishLife": 10000};
  }
}
