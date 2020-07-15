import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/helper/helperFunction.dart';
import '../services/auth.dart';
import '../screens/home.dart';
import '../widgets/widget.dart';
class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}
bool passwordVisible = true;
String _password;
@override
  void initState() {
    passwordVisible = false;
}
class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  //DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController surnameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp() async {
    if(formKey.currentState.validate()){
      Map<String, String> userInfoMap = {
        "email": emailTextEditingController.text,
      };
      
      setState(() {
        isLoading = true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        //print("${val.uid}");
        //databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserEmailInSharedPreference(emailTextEditingController.text);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Home()
          )
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 165.0,
                          child: TextFormField(
                            validator: (val){
                              return val.isEmpty || val.length <= 2 ? "Podaj poprawne imię" : null;
                            },
                            controller: nameTextEditingController,
                            style: defTextFieldStyle(),
                            decoration: defFieldDecoration("Imię"),
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp("[a-zA-Z]"))
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 165.0,
                          child: TextFormField(
                            validator: (val){
                              return val.isEmpty || val.length <= 1 ? "Podaj poprawne nazwisko" : null;
                            },
                            controller: surnameTextEditingController,
                            style: defTextFieldStyle(),
                            decoration: defFieldDecoration("Nazwisko"),
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp("[a-zA-Z]"))
                            ],
                          ),
                        ),
                      ],
                    ),
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
                      //controller: _userPasswordController,
                      decoration: InputDecoration(
                        hintText: "Hasło",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontFamily: "Segoe UI",
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: (){
                            setState(
                              (){
                              passwordVisible = !passwordVisible;
                              }
                            );
                          },
                        ),
                      ),
                      //validator: (val) => val.length < 6 ? 'Zbyt krótkie hasło...' : null,
                      validator: (val){
                        return val.length <= 6 ? "Podaj poprawne hasło" : null;
                      },
                      onSaved: (val) => _password = val,
                      obscureText: passwordVisible,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  signMeUp();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Zarejestruj Się".toUpperCase(), style: defButtonStyle(),),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Zarejestruj przez Google".toUpperCase(), style: TextStyle(
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
                  Text("Masz już konto? ", style: defTextFieldStyle(),),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Zaloguj się", style: defHyperlinkStyle(context),),
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      )
    );
  }
}