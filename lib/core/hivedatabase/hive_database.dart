import 'package:assigment/data/models/EmployeeModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_boxes.dart';

class HiveDatabase {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    registerAdapters();
    await openHiveBoxes();

    //TODO:listening to sign out events to clear hive data
        // clearHiveBoxes();
  }

  static void registerAdapters() {
    Hive.registerAdapter(EmployeeModelAdapter()); //typeId-11

  }

  static Future<void> openHiveBoxes() async {
    await Hive.openBox<EmployeeModel>(employeeDetailsBox);

  }

  static void clearHiveBoxes() async {
    await Hive.box<EmployeeModel>(employeeDetailsBox).clear();

  }
}
