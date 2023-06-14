import 'package:assigment/presentation/employeeList/bloc/employee_bloc.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  DateRangePickerController datePickerStartController = DateRangePickerController();
  DateRangePickerController datePickerEndController = DateRangePickerController();

  DateTime currentDate = DateTime.now();
  DateTime? endDate;
  late DateTime selectedDate;
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
                SizedBox(
                  width: 73,
                  child: BoxSecondaryButton(
                    title: 'Cancel',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                horizontal16px,
                SizedBox(
                  width: 73,
                  child: BoxPrimaryButton(
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
                          _selectNewDate(context, startDateController, null, endDate, datePickerStartController);
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
                          _selectNewDate(context, endDateController, currentDate, endDate, datePickerEndController);
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

  Future<void> _selectNewDate(
      BuildContext context, TextEditingController controller, DateTime? firstDate, DateTime? lastDate, DateRangePickerController pickerController) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(builder: (_, constrains) {
          return StatefulBuilder(builder: (context, setStateDialog) {
            var bottomDate = (firstDate == null && pickerController.selectedDate == null)
                ? DateFormat('d MMM y').format(DateTime.now())
                : (firstDate == null && pickerController.selectedDate != null)
                    ? DateFormat('d MMM y').format(pickerController.selectedDate!)
                    : (firstDate != null && pickerController.selectedDate == null)
                        ? 'No Date'
                        : DateFormat('d MMM y').format(pickerController.selectedDate!);
            void _onChipPressed(String chipName) {
              DateTime newDate = DateTime.now();

              switch (chipName) {
                case 'Today':
                  newDate = DateTime.now();
                  break;
                case 'Next Monday':
                  DateTime date = DateTime.now();
                  int daysUntilNextWeekday = ((DateTime.monday - date.weekday + 7) % 7);
                  newDate = date.add(Duration(days: daysUntilNextWeekday));
                  break;
                case 'Next Tuesday':
                  DateTime date = DateTime.now();
                  int daysUntilNextWeekday = ((DateTime.tuesday - date.weekday + 7) % 7);
                  newDate = date.add(Duration(days: daysUntilNextWeekday));
                  break;
                case 'After 1 Week':
                  newDate = DateTime.now().add(const Duration(days: 7));
                  break;
              }

              setStateDialog(() {
                if ((lastDate != null && newDate.isAfter(lastDate)) || firstDate != null && newDate.isBefore(firstDate)) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    behavior: SnackBarBehavior.fixed,
                    duration: Duration(seconds: 3),
                    content: Text("Date can't be selected", style: TextStyle(color: Colors.white)),
                  ));
                } else {
                  pickerController.selectedDate = newDate;
                  bottomDate = DateFormat('d MMM y').format(pickerController.selectedDate!);
                }
              });
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: SizedBox(
                width: constrains.maxWidth * .8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    firstDate != null
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: BoxSecondaryButton(
                                    title: 'No Date',
                                    onTap: () {
                                      setStateDialog(() {
                                        pickerController.selectedDate = null;
                                      });
                                    },
                                  )),
                              horizontal12px,
                              Expanded(
                                  flex: 1,
                                  child: BoxSecondaryButton(
                                    title: 'Today',
                                    onTap: () => _onChipPressed('Today'),
                                  )),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: BoxSecondaryButton(
                                        title: 'Today',
                                        onTap: () => _onChipPressed('Today'),
                                      )),
                                  horizontal12px,
                                  Expanded(
                                      flex: 1,
                                      child: BoxSecondaryButton(
                                        title: 'Next Monday',
                                        onTap: () => _onChipPressed('Next Monday'),
                                      )),
                                ],
                              ),
                              vertical12px,
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: BoxSecondaryButton(
                                        title: 'Next Tuesday',
                                        onTap: () => _onChipPressed('Next Tuesday'),
                                      )),
                                  horizontal12px,
                                  Expanded(
                                      flex: 1,
                                      child: BoxSecondaryButton(
                                        title: 'After 1 Week',
                                        onTap: () => _onChipPressed('After 1 Week'),
                                      )),
                                ],
                              ),
                            ],
                          ),
                    SfDateRangePicker(
                      allowViewNavigation: false,
                      showNavigationArrow: true,
                      selectionColor: appPrimaryColor,
                      selectionMode: DateRangePickerSelectionMode.single,
                      view: DateRangePickerView.month,
                      selectionTextStyle: const TextStyle(color: Colors.white),
                      controller: pickerController,
                      minDate: firstDate,
                      maxDate: lastDate,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        enableSwipeSelection: true,
                      ),
                      onSelectionChanged: (DateRangePickerSelectionChangedArgs arg) {
                        if (arg.value is DateTime) {
                          setStateDialog(() {
                            bottomDate = DateFormat('d MMM y').format(currentDate);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Icon(TablerIcons.calendar_event, color: appPrimaryColor), Text(bottomDate)],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 73,
                      child: BoxSecondaryButton(
                        title: 'Cancel',
                        onTap: () {
                          Navigator.of(context).pop(null);
                        },
                      ),
                    ),
                    horizontal12px,
                    SizedBox(
                      width: 73,
                      child: BoxPrimaryButton(
                        title: 'Save',
                        onTap: () {
                          if (pickerController.selectedDate != null && firstDate == null) {
                            setState(() {
                              currentDate = pickerController.selectedDate!;
                              controller.text = DateFormat('d MMM y').format(currentDate);
                            });
                          } else if (pickerController.selectedDate != null && firstDate != null) {
                            setState(() {
                              endDate = pickerController.selectedDate!;
                              controller.text = DateFormat('d MMM y').format(endDate!);
                            });
                          } else if (firstDate != null) {
                            setState(() {
                              endDate = pickerController.selectedDate;
                              controller.text = '';
                            });
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                )
              ],
            );
          });
        });
      },
    );
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
