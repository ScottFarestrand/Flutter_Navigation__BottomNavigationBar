import 'dart:io';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../model/user_profile.dart';
class UserProfile extends StatefulWidget {

  const UserProfile({Key? key}) : super(key: key);
  // final bool emailVerified;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final dateFormat = new DateFormat('MMM d, y');
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cellPhoneNumberController = TextEditingController();
  final dateController = TextEditingController();
  final birthDateController = TextEditingController();
  // MaskTextInputFormatter formatter();
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
  bool _alerted = false;



  Future<void> _selectDate(BuildContext context, TextEditingController selectedDate) async {
    final dateFormat = new DateFormat('MMM d, y');
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(DateTime.now().year - 125),
      lastDate: DateTime(DateTime.now().year + 1),);
    if (pickedDate != null && pickedDate != birthDate)
      setState(() {
        birthDate = pickedDate;
        selectedDate.text = dateFormat.format(birthDate);
      });
  }

  @override

  Widget build(BuildContext context) {
    final user =  FirebaseAuth.instance.currentUser!;
    // await getUser();
    print("Building");
    final formKey = GlobalKey<FormState>();
    if (!user.emailVerified && !_alerted) {
      _alerted = true;
      Future.delayed(Duration.zero, () => _showMyDialog());
    }


    String tempDate;
    int _seconds;
    int _nanoseconds;
    if (_saved) {
      print(_saved);
      FirebaseFirestore.instance.collection('Users').
      doc(FirebaseAuth.instance.currentUser!.uid).
      get().then((snapshot) =>
      {
        print(snapshot['BirthDate'].toString()),
        tempDate = snapshot['BirthDate'].toString(),
        _seconds = int.parse(tempDate.substring(18, 28)),
        _nanoseconds =
            int.parse(tempDate.substring(42, tempDate.lastIndexOf(')'))),
        birthDate = Timestamp(_seconds, _nanoseconds).toDate(),
        firstNameController.text = snapshot['FirstName'],
        lastNameController.text = snapshot['LastName'],
        emailReminders = snapshot["SendEmailReminders"],
        textReminders = snapshot["SendTextReminders"],
        cellPhoneNumberController.text = snapshot["CellPhone"],
        origCellPhone = snapshot["CellPhone"],
        cellPhoneValidated = snapshot["CellPhoneValidated"],
        _cellValidated = cellPhoneValidated,
        _saved = true,
      });
    }


    birthDateController.text = dateFormat.format(birthDate);
    print("Building Profile Form");
    print(firstNameController.text);
    print("that was the last name");
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),

            TextFormField(
                controller: firstNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "First Name",
                  labelStyle: TextStyle(fontStyle: FontStyle.italic),
                ),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter First Name";
                  }
                  return null;
                }
            ),
            TextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  labelStyle: TextStyle(fontStyle: FontStyle.italic),
                ),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Last Name";
                  }
                  return null;
                }
            ),
            TextFormField(
              onTap: () {_selectDate(context, dateController);},
              decoration: InputDecoration(
                labelText: "Birth Date",
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
              style: TextStyle(fontSize: 20),
              controller: birthDateController,
              keyboardType: TextInputType.none,
            ),
            TextFormField(
              // inputFormatters: [MaskedInputFormater('(###) ###-####')],
              inputFormatters: [maskFormatter],
              controller: cellPhoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Cell Phone Number",
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Row(children: [
              Text('Send Text Reminders', style: TextStyle(fontSize: 20),),
              SizedBox(width: 10,),
              FlutterSwitch(
                  activeToggleColor: Colors.white,
                  inactiveColor: Colors.blueGrey,
                  height: 25,
                  width: 50,
                  value: textReminders,
                  onToggle: (bool? value) { // This is where we update the state when the checkbox is tapped
                    print(textReminders);
                    print(emailReminders);
                    print("setting");
                    setState(() {
                      _saved = false;
                      textReminders = !textReminders;
                    });
                    print("set");
                    print(textReminders);
                    print(emailReminders);

                  })
            ],),
            Row(children: [SizedBox(height: 10,)],),
            Row(children: [

              Text('Send Email Reminders', style: TextStyle(fontSize: 20), ),
              SizedBox(width: 10,),
              // ToggleButtons(children: [Text("Yes"),Text("no")], isSelected: (){}),
              FlutterSwitch(
                  activeToggleColor: Colors.white,
                  inactiveColor: Colors.blueGrey,
                  height: 25,
                  width: 50,
                  value: emailReminders,
                  onToggle: (bool? value) { // This is where we update the state when the checkbox is tapped

                    setState(() {
                      _saved = false;
                      emailReminders = !emailReminders;
                    });
                  })
            ],),
            ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, child: Text("Log out")),
            ElevatedButton(onPressed: (){
              final userprofile = User_Profile(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  cellPhone: cellPhoneNumberController.text,
                  birthDate: birthDate,
                  sendTextReminders: textReminders,
                  sendEmailReminders: emailReminders,
                  cellphonevalidated: _cellValidated);
              updateUser(userprofile);
              // addRecord(firstNameController.text, lastNameController.text, birthDate);
            }, child: Text("Save")),
            Visibility(
              visible: ( !cellPhoneValidated && _saved),
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Validate Cell Number"),),
            ),
          ],
        ),
      ),
    );
  }
  //
  // Future  getUser() async{
  //
  //   user =  FirebaseAuth.instance.currentUser!;
  // }
  Future updateUser(User_Profile userprofile) async {
    final myID = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('Users').doc(
        myID);
    final json =userprofile.toJson();
    await docUser.set(json);
  }
  addRecord (String firstName, String lastName, DateTime birthDate  )  {
    final myID = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('Users').doc(
        myID);

    print("Saving");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Saving User")),
    );
    if (cellPhoneNumberController.text != origCellPhone) {
      cellPhoneValidated  = false;
    }
    print(textReminders);
    if (cellPhoneNumberController.text != origCellPhone) {
      cellPhoneValidated = false;
    }
    // FirebaseAuth.instance.signOut();
    final json = {
      'FirstName': firstNameController.text,
      'LastName': lastNameController.text,
      'BirthDate': birthDate,
      'SendTextReminders': textReminders,
      'SendEmailReminders': emailReminders,
      'CellPhone': cellPhoneNumberController.text,
      'CellPhoneValidated': cellPhoneValidated,
    };
    try {
      print("Trying");
      docUser.set(json)
          .then((stuff) {
        print("saved");
      })
          .catchError((e) {
        print("Error Caught");
        print(e.code);
        print(e.message);

        // print(Err.toString());
        if (e.code == "permission-denied") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You Do not have necessary permission",
                style: TextStyle(backgroundColor: Colors.red),),
            ),
          );}
      });
    } on FirebaseException catch (err){
      print(err.toString());
    } on IOException catch(err) {
      print(err.toString());
    }



    setState((){
      _saved = true;
    });


  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email Not Validated'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('To ensure your email address was correct, we just sent you an email to verify you entered your email address correctly. Please check your email and click the link to validate your email address'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;

                Navigator.of(context).pop();

                user!.sendEmailVerification()
                    .whenComplete(() => print("Success"))
                    .onError((error, stackTrace) {print(error);});
              },
            ),
          ],
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// class UserProfile extends StatefulWidget {
//   const UserProfile({Key? key}) : super(key: key);
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Text("Profile"),);
//   }
// }
