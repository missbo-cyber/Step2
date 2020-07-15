import 'package:flutter/material.dart';
InputDecoration defFieldDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
  );
}
TextStyle defTextFieldStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 16
  );
}
TextStyle defButtonStyle(){
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16
  );
}
TextStyle defHyperlinkStyle(context){
  return TextStyle(
    color: Theme.of(context).primaryColor,
    fontSize: 16
  );
}