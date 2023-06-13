import 'package:assigment/presentation/employeeList/bloc/employee_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final employeeBlocProvider = BlocProvider<EmployeeBloc>(create: (context) => EmployeeBloc());
final employeeGlobalBloc = EmployeeBloc();