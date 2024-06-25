// import 'dart:async';
// import 'dart:isolate';
// import 'dart:math';
// import 'aquarium.dart';
// import 'fish.dart';
// main() async {
// 	Aquarium aquarium = await Aquarium();
// 	topLevelFunction(SendPort send) async{
// 		// var fish = Fish(send);
// 		// print(fish.id);
// 		// aquarium.addFish(fish);
// 	}
// 	// Map<String, dynamic> isolates = {};
// 	// receiver.listen((message){
// 	// 	print(message);
// 	// });
// 	int timeCounter = 0;
// 	var fishCount = (Random().nextDouble()*aquarium.maxFishes).floor();
// 	Timer.periodic(const Duration(seconds: 1), (timer){
// 		print(++timeCounter);
// 		aquarium.fishes.forEach((Fish fish){
// 			fish.updateLifeTime(1);
// 		});
// 		print("${aquarium.fishes} ${aquarium.fishes.length}");
// 		if(aquarium.fishes.length == 0) timer.cancel(); 
// 	});
// 	for(var i = 0; i < fishCount; i++){
// 		final receiver = ReceivePort();
// 		final isolate = await Isolate.spawn(topLevelFunction, receiver.sendPort);
// 		receiver.listen((message){
// 			if(message == "RIP"){
// 				isolate.kill();
// 				receiver.close();
// 				return;
// 			}
// 			print(message);
// 		});
// 		// (){ aquarium.removeFish(fish.id); };
// 		// const id = UuidV1();
// 		// final fish = Fish((){});
// 		// fish.dieFunction = ()async{
// 		// 	await aquarium.removeFish(fish.id);
// 		// };
// 		// aquarium.addFish(fish);
// 	}
// }