import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/helper/helperFunction.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../widgets/widget.dart';
import '../screens/home.dart';
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}
bool _passwordVisible = true;
String _password;
@override
  void initState() {
    _passwordVisible = false;
}
class _SignInState extends State<SignIn> {
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  /*
  signMeIn() async {
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      databaseMethods.getUserInfo(emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserEmailInSharedPreference(snapshotUserInfo.documents[0].data["userEmailKey"]);
      });
      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        if (val != null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home()
          ));
        }
      });
      
    }
  }*/
  signMeIn() async {
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        if (val != null){
          //print("${val.uid}");
          //databaseMethods.uploadUserInfo(userInfoMap);
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserEmailInSharedPreference(emailTextEditingController.text);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home()
            )
          );
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }}
      );
    }
  }
/*
  @override
    Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new SecondPage());
  }
*/@override
    Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xff1F1F1F));
    return new Scaffold(
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator())
      ) : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Podaj poprawny email";
                      },
                      controller: emailTextEditingController,
                      style: defTextFieldStyle(),
                      decoration: defFieldDecoration("Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      controller: passwordTextEditingController,
                      style: defTextFieldStyle(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Hasło",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontFamily: "Segoe UI",
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: (){
                            setState(
                              (){
                              _passwordVisible = !_passwordVisible;
                              }
                            );
                          },
                        ),
                      ),
                      validator: (val){
                        return val.length <= 6 ? "Podaj poprawne hasło" : null;
                      },
                      onSaved: (val) => _password = val,
                      obscureText: _passwordVisible,
                    ),
                  ],
                ),
              ),
              
            
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Nie pamiętasz hasła?", style: defTextFieldStyle())
                )
              ),
              SizedBox(height: 10),
              Material(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xff024b30),
                child: InkWell(
                  splashColor: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  onTap: (){
                    signMeIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("Zaloguj".toUpperCase(), style: defButtonStyle(),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                )
              ),
              
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Zaloguj przez Google".toUpperCase(), style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Segoe UI",
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      )
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: ExactAssetImage('assets/google.png'),
                            fit: BoxFit.contain,
                            ),
                        )
                    )
                  ]
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nie masz konta? ", style: defTextFieldStyle(),),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Zarejestruj się", style: defHyperlinkStyle(context),),
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}