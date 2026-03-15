import 'package:flutter/material.dart';

class AppWidget{
static TextStyle heading(){
return TextStyle(
  color: const Color.fromARGB(255, 3, 3, 3), fontSize: 45.0, fontWeight: FontWeight.bold);
}

static TextStyle subhead(){
return TextStyle(
  color: const Color.fromARGB(174, 3, 3, 3), fontSize: 25.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
}
}