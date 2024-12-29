import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static var error = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.sizeOf(context);
    return Scaffold(
      
      backgroundColor: Color(0xff0b090a),
      
      body: Padding(
        
        padding: const EdgeInsets.all(25.0),
        
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            Align(
              alignment: Alignment.bottomLeft,
              child: Text("Sign In",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 50,
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
            SizedBox(height: 10),

            Align(
              alignment: Alignment.bottomLeft,
              child: Text("Enter your sign in code",
                style: TextStyle(color: Colors.white54, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),

            pinPutOTP(code),
            SizedBox(height: 10),

            (LoginScreen.error.isEmpty) ? const SizedBox() : Text(LoginScreen.error,
            style:const TextStyle(color: Colors.redAccent, fontSize: 15)),
            const SizedBox(height: 20),
            
            SizedBox(
              height: screen.width * 0.125,
              width: screen.width * 0.75,
              child: ElevatedButton(
                style: buttonStyle(),
                onPressed: () async {
                  if (code.text.isEmpty || code.length < 6) {
                    setState(() {
                      LoginScreen.error = "Incorrect Code";
                    });
                  } else {
                    await login(code.text, context);
                  }
                },
                child: Text("SUBMIT",
                  style: TextStyle(
                    color: Color(0xff000814),
                    fontSize: 22.5,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ),
            )
          ]
        )),
      ),
    );
  }
}
