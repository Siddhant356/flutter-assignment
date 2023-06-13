import 'package:assigment/data/repositories/employee_repository.dart';
import 'package:assigment/domain/services/employee_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerSingleton<IEmployee>(EmployeeImpl());
}
