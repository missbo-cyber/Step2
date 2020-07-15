import 'package:app/screens/appLoading.dart';
import 'package:flutter/material.dart';
import 'package:app/services/point_service.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Color dark = Color(0xff1F1F1F);
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: dark, // navigation bar color
    statusBarColor: dark, // status bar color
  ));
  runApp(StepByStep());
}

class StepByStep extends StatelessWidget {
  static bool darkMode = true;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(dark);
    return MultiProvider(
      providers: [StreamProvider(create: (ctx) => PointService().getPoints())],
      child: MaterialApp(
      title: 'Step By Step',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        //brightness: Brightness.dark,
        fontFamily: "Segoe UI",
        primaryColor: Color(0xff024b30),
        scaffoldBackgroundColor: StepByStep.darkMode ? dark : Color(0xffffffff),
        accentColor: Colors.green,
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppLoading(), //Authenticate(),
    ),
    );
  }
}
