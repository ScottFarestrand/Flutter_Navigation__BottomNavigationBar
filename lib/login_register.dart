import 'package:flutter/material.dart';
import './widgets/Login.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  
  @override
  Widget build(BuildContext context) {
    print("Showing Login");
    return Login();
  }
}
