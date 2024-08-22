import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/home_screen.dart';
import 'package:ingeconomica/screens/login.dart';
import 'package:ingeconomica/screens/register.dart';

var routes=<String,WidgetBuilder>{
  "/":(_) =>const  HomeScreen(),
   "/login":(_) =>const  Login(),
   "/register":(_) => const Register(),
   };