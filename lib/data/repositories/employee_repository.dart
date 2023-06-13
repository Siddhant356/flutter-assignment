import 'package:assigment/data/datasources/employee_data_source.dart';
import 'package:assigment/data/models/EmployeeModel.dart';
import 'package:assigment/domain/entities/EmployeeEntity.dart' as entity;
import 'package:assigment/domain/services/employee_service.dart';

class EmployeeImpl implements IEmployee{

  @override
  Future<void> deleteEmployee(String id) async {
    return await LocalEmployeeDataSource.deleteEmployeeDetails(id);
  }

  @override
  Future<List<entity.EmployeeEntity>> getEmployeeList() async {
    List<EmployeeModel> employees= await LocalEmployeeDataSource.getEmployeeDetails();
    return employees.map((employee) => EmployeeModel.toEntity(employee)).toList();
  }

  @override
  Future<void> saveEmployee(entity.EmployeeEntity employee) async {
    return await LocalEmployeeDataSource.saveEmployeeDetails(EmployeeModel.fromEntity(employee));
  }

}