part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class Loading extends EmployeeState {}

class Loaded extends EmployeeState {
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;

  const Loaded({required this.currentEmployee, required this.previousEmployee});

  @override
  List<Object?> get props => [currentEmployee, previousEmployee];
}

class Saving extends EmployeeState {}

class Saved extends EmployeeState {}

class Deleting extends EmployeeState {}

class Deleted extends EmployeeState {}
