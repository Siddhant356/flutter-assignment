import 'package:assigment/core/hivedatabase/hive_boxes.dart';
import 'package:assigment/data/models/EmployeeModel.dart';

import '../../core/hivedatabase/generic_cache.dart';

class LocalEmployeeDataSource extends GenericCache<EmployeeModel> {
  LocalEmployeeDataSource._();
  static final LocalEmployeeDataSource instance = LocalEmployeeDataSource._();

  static Future<void> saveEmployeeDetails(EmployeeModel employee) async {
      await instance.put(employee.id, employee);
  }

  static Future<List<EmployeeModel>> getEmployeeDetails() async {
    return await instance.getAll();
  }

  static Future<void> deleteEmployeeDetails(String id) async {
    return await instance.delete(id);
  }

  @override
  void setupHiveBoxName({String? boxName}) {
    super.setupHiveBoxName(boxName: employeeDetailsBox);
  }
}