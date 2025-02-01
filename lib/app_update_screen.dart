import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:show_room/elements/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateScreen extends StatefulWidget {
  const AppUpdateScreen({super.key});

  @override
  State<AppUpdateScreen> createState() => _AppUpdateScreenState();
}

class _AppUpdateScreenState extends State<AppUpdateScreen> {

  Future<void> launchURL() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var databaseSnapshot = await databaseRef.child('Update Check').get();
    String updateUrl = databaseSnapshot.child("Link").value.toString();
    final Uri url = Uri.parse(updateUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $updateUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    
    var screen = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Color(0xff0b090a),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error,color: Colors.white54,size: 75),
              SizedBox(height: 20),
              
              Text("This application is out dated, Update to the latest Version.",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              
              SizedBox(
              height: screen.width * 0.125,
              width: screen.width * 0.5,
              child: ElevatedButton(
                style: buttonStyle(),
                onPressed: launchURL,
                child: Text("UPDATE",
                  style: TextStyle(
                    color: Color(0xff000814),
                    fontSize: 22.5,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}