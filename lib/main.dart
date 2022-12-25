import 'package:dd_study_22_ui/data/services/database.dart';
import 'package:dd_study_22_ui/ui/app_navigator.dart';
import 'package:dd_study_22_ui/ui/roots/loader.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: AppNavigator.key,
      onGenerateRoute: (settings) =>
          AppNavigator.onGeneratedRoutes(settings, context),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderWidget.create(),
      //home: const MyHomePage(title: "Flutter Demo Home Page"));
    );
  }
}
