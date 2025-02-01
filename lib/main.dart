import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:show_room/Auth/login.dart';
import 'package:show_room/app_update_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _updateCheckFuture;

  @override
  void initState() {
    super.initState();
    _updateCheckFuture = updateCheck();
  }

  Future<bool> updateCheck() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var databaseSnapshot = await databaseRef.child('Update Check').get();
    return databaseSnapshot.child("Version").value.toString() == "1.0";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _updateCheckFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color(0xff0b090a),
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color(0xff0b090a),
              body: Center(child: Text("Error checking for update")),
            ),
          );
        } else {
          bool needsUpdate = snapshot.data ?? true;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: needsUpdate ?  LoginScreen() : AppUpdateScreen(),
          );
        }
      },
    );
  }
}
