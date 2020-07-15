import 'package:app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:app/helper/authenticate.dart';
class AppLoading extends StatefulWidget {
  @override
  _AppLoadingState createState() => _AppLoadingState();
}
class _AppLoadingState extends State<AppLoading> {
  @override
  void initState() {
    super.initState();
    switchScreen();
  }
  void switchScreen() async {
    await new Future.delayed(const Duration(seconds: 5));
      //Navigator.push(context, new MaterialPageRoute(builder: (__) => new SecondView()));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Authenticate()//Home()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/stepbystep.png'), 
            ),
            SizedBox(height: 150),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.5,
              )
            ),
          ],
        )
      ),
    );
  }
}