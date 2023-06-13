part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class SaveEmployeeEvent extends EmployeeEvent {
  final EmployeeEntity employee;

  const SaveEmployeeEvent({required this.employee});
  @override
  List<Object?> get props => [employee];
}




class DeleteEmployeeEvent extends EmployeeEvent {
  final String employeeId;

  const DeleteEmployeeEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class GetAllEmployeeEvent extends EmployeeEvent {
  const GetAllEmployeeEvent();

  @override
  List<Object?> get props => [];
}
