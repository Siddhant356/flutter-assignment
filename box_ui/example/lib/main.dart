import 'package:flutter/material.dart';
import 'package:box_ui/box_ui.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: assignmentTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: boxAppBar(widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const BoxPrimaryButton(title: 'Save'),
            vertical12px,
            const BoxSecondaryButton(title: 'Cancel'),
            vertical12px,
            const BoxFloatingButton(icon: Icons.add),
            vertical12px,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoxInputField(leading: const Icon(Icons.person_outline_rounded),controller: controller, placeholder: 'Employee name',),
            )
          ],
        ),
      ),
    );
  }
}
