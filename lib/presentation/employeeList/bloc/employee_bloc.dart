
import 'package:assigment/domain/entities/EmployeeEntity.dart';
import 'package:assigment/domain/services/employee_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../bloc_providers.dart';
import '../../../locator.dart';


part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {

  EmployeeBloc() : super(EmployeeInitial()) {
    on<SaveEmployeeEvent>((event, emit) async {
      emit(Saving());
      await locator<IEmployee>().saveEmployee(event.employee);
      emit(Saved());
      employeeGlobalBloc.add(const GetAllEmployeeEvent());
    });

    on<DeleteEmployeeEvent>((event, emit) async {
      emit(Deleting());
      await locator<IEmployee>().deleteEmployee(event.employeeId);
      emit(Deleted());
      employeeGlobalBloc.add(const GetAllEmployeeEvent());
    });

    on<GetAllEmployeeEvent>((event, emit) async {
      emit(Loading());
      List<EmployeeEntity> allEmp = await locator<IEmployee>().getEmployeeList();
      final prevEmp = <EmployeeEntity>[];
      final currentEmp = <EmployeeEntity>[];
      for (var emp in allEmp) {
        if( emp.endDate!=null && emp.endDate!.isBefore(DateTime.now())){
          prevEmp.add(emp);
        } else{
          currentEmp.add(emp);
        }
      }
      currentEmp.sort((a,b)=>a.startDate.compareTo(b.startDate));
      prevEmp.sort((a,b)=>a.startDate.compareTo(b.startDate));
      emit(Loaded(currentEmployee: currentEmp, previousEmployee: prevEmp));
    });
  }
}
