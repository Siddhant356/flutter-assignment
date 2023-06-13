import 'package:assigment/domain/entities/EmployeeEntity.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../../../bloc_providers.dart';
import '../../employeeList/pages/add_detail.dart';
import '../bloc/employee_bloc.dart';
import 'edit_detail.dart';

class EmployeeListingPage extends StatefulWidget {
  const EmployeeListingPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListingPage> createState() => _EmployeeListingPageState();
}

class _EmployeeListingPageState extends State<EmployeeListingPage> {
  final transactionIdTextController = TextEditingController();
  @override
  initState() {
    employeeGlobalBloc.add(const GetAllEmployeeEvent());
    super.initState();
  }

  @override
  void dispose() {
    transactionIdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: boxAppBar('Employee List'),
      bottomNavigationBar: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Swipe left to delete',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Roboto', color: Colors.black.withOpacity(0.5))),
                BoxFloatingButton(
                  icon: Icons.add,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDetail()));
                  },
                ),
              ],
            ),
          )),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
          bloc: employeeGlobalBloc,
          builder: (context, state) {
            if (state is Loaded) {
              var prevEmp = state.previousEmployee;
              var currEmp = state.currentEmployee;
              if (currEmp.isEmpty && prevEmp.isEmpty) {
                return Center(child: SvgPicture.asset('assets/employeeListNotFound.svg'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Current employees',
                          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: appPrimaryColor),
                        ),
                      ),
                      currEmp.isEmpty
                          ? const Center(
                              child: Text(
                              'N/A',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ))
                          : list(currEmp),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Previous employees',
                          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: appPrimaryColor),
                        ),
                      ),
                      prevEmp.isEmpty
                          ? const Center(
                              child: Text(
                              'N/A',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ))
                          : list(prevEmp),
                    ],
                  ),
                );
              }
            } else {
              return const CircularProgressIndicator.adaptive();
            }
          }),
    );
  }

  Widget list(List<EmployeeEntity> data) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(right: 16),
              alignment: AlignmentDirectional.centerEnd,
              child: const Icon(TablerIcons.trash, color: Colors.white),
            ),
            key: ValueKey<EmployeeEntity>(data[index]),
            onDismissed: (DismissDirection direction) {
              var employeeId = data[index].id;
              setState(() {
                data.removeAt(index);
              });
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.fixed,
                      duration: const Duration(seconds: 3),
                      content: const Text("Employee data has been deleted", style: TextStyle(color: Colors.white)),
                      action: SnackBarAction(textColor: appPrimaryColor, label: "Undo", onPressed: () {})))
                  .closed
                  .then((value) {
                if (value == SnackBarClosedReason.action) {
                  employeeGlobalBloc.add(const GetAllEmployeeEvent());
                } else {
                  employeeGlobalBloc.add(DeleteEmployeeEvent(employeeId: employeeId));
                }
              });
            },
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditDetail(employee: data[index])));
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: screenWidth(context),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index].name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Roboto')),
                      vertical6px,
                      Text(data[index].role,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Roboto', color: Colors.black.withOpacity(0.5))),
                      vertical6px,
                      data[index].endDate == null
                          ? Text('From ${DateFormat('d MMM, y').format(data[index].startDate)}',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Roboto', color: Colors.black.withOpacity(0.5)))
                          : Text('${DateFormat('d MMM, y').format(data[index].startDate)} - ${DateFormat('d MMM, y').format(data[index].endDate!)}',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Roboto', color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                ),
              ),
            ));
      },
      separatorBuilder: (context, _) {
        return const Divider(
          height: 1,
        );
      },
    );
  }
}
