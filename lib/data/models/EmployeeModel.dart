import 'package:assigment/core/hivedatabase/hive_type_ids.dart';
import 'package:assigment/domain/entities/EmployeeEntity.dart' as entity;
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EmployeeModel.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: HiveTypeIds.employeeDetailsHiveId)
class EmployeeModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String role;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime? endDate;

  @HiveField(4)
  String id;

  EmployeeModel({required this.name, required this.role, required this.startDate, this.endDate, required this.id});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  factory EmployeeModel.fromEntity(entity.EmployeeEntity employee) {
    return EmployeeModel(name: employee.name, role: employee.role, startDate: employee.startDate, endDate: employee.endDate, id: employee.id);
  }

  static entity.EmployeeEntity toEntity(EmployeeModel employee) {
    return entity.EmployeeEntity(name: employee.name, role: employee.role, startDate: employee.startDate, endDate: employee.endDate, id: employee.id);
  }

  @override
  String toString() {
    return 'EmployeeModel{name: $name, role: $role, startDate: $startDate, endDate: $endDate, id: $id}';
  }
}
