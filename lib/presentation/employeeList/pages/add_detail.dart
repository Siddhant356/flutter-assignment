import 'package:assigment/presentation/employeeList/bloc/employee_bloc.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:uuid/uuid.dart';

import '../../../bloc_providers.dart';
import '../../../domain/entities/EmployeeEntity.dart';

class AddDetail extends StatefulWidget {
  const AddDetail({Key? key}) : super(key: key);

  @override
  State<AddDetail> createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> {
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool nameError = false;
  bool roleError = false;
  DateTime currentDate = DateTime.now();
  DateTime? endDate;
  final _formKey = GlobalKey<FormState>();
  var items = ['Product Designer', 'Flutter Developer', 'QA Tester', 'Product Owner'];

  @override
  void initState() {
    startDateController.text = 'Today';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: boxAppBar('Add Employee Details'),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              height: 1,
            ),
            vertical12px,
            Row(
              children: [
                const Spacer(),
                BoxSecondaryButton(
                  title: 'Cancel',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                horizontal16px,
                BoxPrimaryButton(
                  title: 'Save',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      var employee = EmployeeEntity(
                          startDate: currentDate, endDate: endDate, name: employeeNameController.text, role: roleController.text, id: const Uuid().v4());
                      employeeGlobalBloc.add(SaveEmployeeEvent(employee: employee));
                      Navigator.pop(context);
                    }
                  },
                ),
                horizontal16px
              ],
            ),
            vertical12px,
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                vertical24px,
                BoxInputField(
                  leading: const Icon(Icons.person_outline_rounded),
                  controller: employeeNameController,
                  placeholder: 'Employee name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter employee name';
                    }
                    return null;
                  },
                ),
                vertical24px,
                BoxInputField(
                  leading: const Icon(Icons.work_outline_rounded),
                  dismissKeyboard: true,
                  controller: roleController,
                  placeholder: 'Select Role',
                  trailing: const Icon(Icons.arrow_drop_down_rounded),
                  onTap: () {
                    showModal(context, roleController);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select role';
                    }
                    return null;
                  },
                ),
                vertical24px,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: BoxInputField(
                        leading: const Icon(TablerIcons.calendar_event),
                        dismissKeyboard: true,
                        controller: startDateController,
                        onTap: () {
                          _selectDate(context, startDateController, null);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: const Icon(
                        TablerIcons.arrow_narrow_right,
                        color: appPrimaryColor,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: BoxInputField(
                        leading: const Icon(TablerIcons.calendar_event),
                        dismissKeyboard: true,
                        placeholder: 'End Date',
                        controller: endDateController,
                        onTap: () {
                          _selectDate(context, endDateController, currentDate);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller, DateTime? firstDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(16)))),
            colorScheme: const ColorScheme.light(
              primary: appPrimaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: appPrimaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: appPrimaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != currentDate && firstDate == null) {
      setState(() {
        currentDate = pickedDate;
        controller.text = DateFormat('d MMM y').format(currentDate);
      });
    } else if (pickedDate != null && firstDate != null) {
      setState(() {
        endDate = pickedDate;
        controller.text = DateFormat('d MMM y').format(endDate!);
      });
    }
  }

  void showModal(context, TextEditingController controller) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (context) {
          return SizedBox(
            height: 52 * 4,
            child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, _) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          items[index],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                        ),
                      )),
                      onTap: () {
                        setState(() {
                          controller.text = items[index];
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
