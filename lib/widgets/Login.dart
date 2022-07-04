import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Register.dart';
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    emailController.text = "ScottFarestrand@gmail.com";
    passwordController.text = "Jlj#980507";
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(fontStyle: FontStyle.italic),
                ),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value.toString())) {
                    return null;
                  }
                  return 'Please enter a valid email address';
                }
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                print("Log in Pressed");
                try {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()
                  ).then((value) {
                    print("popping");
                    Navigator.pop(context);
                  });
                } on FirebaseAuthException catch (e){
                  print(e.code.toString());
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Creating User")),
                );
              },
              child: const Text('Login'),
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Register()),
              );
            }, child: Text("Register")),
          ],
        ),
      ),

    );
  }

}