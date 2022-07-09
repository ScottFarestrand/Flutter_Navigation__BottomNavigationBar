import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './widgets/People.dart';
import './widgets/UserProfile.dart';
// import './widgets/Calendar.dart';
// import './widgets/user_profile.dart';
import 'login_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bottom Navigation Bar Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _emailValidated = false;
  bool _BottomNavVisible = false;

  @override
  Widget build(BuildContext context) {
    final widgets = [
      // UserProfile2(emailVerified: _emailValidated),
      UserProfile(),
      People(),
      // Calendar()
    ];
    // final user = FirebaseAuth.instance.currentUser!;
    // if (user!.uid == null) {
    //   print("Null");
    // } else {
    //   print("not null");
    //   // print(user!.uid);
    // };

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("Stream Builder");
          print(_currentIndex);
          if (snapshot.hasData) {
            _BottomNavVisible = true;
            final user = FirebaseAuth.instance.currentUser!;
            _emailValidated = user.emailVerified;

            print("returning widget");
            print(widgets[_currentIndex]);
            // return widgets[_currentIndex];
            return UserProfile();
          } else {
            return LoginRegister();
          }
        },
      ),
      bottomNavigationBar: Visibility(
        visible: _BottomNavVisible,
        child: BottomNavigationBar( 
          onTap: (index) => setState(() => _currentIndex = index),
          currentIndex: _currentIndex,
          backgroundColor: Colors.blue,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,


          items:[
            BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.person),
                label: "Profile"),
            BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.people),
                label: "People"),
            BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.schedule),
                label: "Reminders"),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
