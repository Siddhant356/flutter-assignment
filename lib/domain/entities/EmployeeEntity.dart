class EmployeeEntity {

  String id;
  String name;

  String role;

  DateTime startDate;

  DateTime? endDate;

  EmployeeEntity(
      {required this.name,
        required this.role,
        required this.startDate,
        this.endDate,
        required this.id,
      });

  }
