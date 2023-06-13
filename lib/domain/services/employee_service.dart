import '../entities/EmployeeEntity.dart';

abstract class IEmployee {
  Future<List<EmployeeEntity>> getEmployeeList();
  Future<void> saveEmployee(EmployeeEntity employee);
  Future<void> deleteEmployee(String id);
}
