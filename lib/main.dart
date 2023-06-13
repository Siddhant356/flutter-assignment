import 'package:assigment/bloc_providers.dart';
import 'package:assigment/presentation/employeeList/pages/employee_listing_page.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_strategy/url_strategy.dart';
import 'core/hivedatabase/hive_database.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await HiveDatabase.initialize();
  setPathUrlStrategy();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [employeeBlocProvider],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Home',
            theme: assignmentTheme,
            home: const EmployeeListingPage(),
          ),
        );
      }
    );
    // return MultiBlocProvider(
    //   providers: [],
    //   child: MaterialApp.router(
    //     title: 'Home',
    //     theme: assignmentTheme,
    //     routerConfig: NyAppRouter.router,
    //     // home: const LoginScreen(),
    //   ),
    // );
  }
}
