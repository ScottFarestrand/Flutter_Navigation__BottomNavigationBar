import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserProfile2 extends StatelessWidget {
  const UserProfile2({Key? key, required this.emailVerified}) : super(key: key);
  final bool emailVerified;
  @override



  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('MMM d, y');
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final cellPhoneNumberController = TextEditingController();
    final dateController = TextEditingController();
    final birthDateController = TextEditingController();
    var maskFormatter = new MaskTextInputFormatter(mask: '###.###.####', filter: { "#": RegExp(r'[0-9]') });
    DateTime birthDate = DateTime.now();
    String firstName = "";
    String lastName = "";
    String cellPhoneNumber = "";
    bool textReminders = false;
    bool emailReminders = false;
    bool cellPhoneValidated = false;
    bool _saved = true;
    String origCellPhone = "";
    bool _cellValidated = false;


    return Container(child: Text("THIS IS A TEST"),);
  }


}
