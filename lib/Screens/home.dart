import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:show_room/Auth/login.dart';
import 'package:show_room/elements/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<dynamic> stockList = [];
  static List<dynamic> customerList = [];
  static List<dynamic> dueList = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.sizeOf(context);
    
    var customerColor = const Color(0xFF415a77);
    var dueColor = const Color(0xFF3a5a40);
    var stockColor = Colors.white38;

    return Scaffold(
      
      backgroundColor: Color(0xff0b090a),
      
      appBar: AppBar(
        
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.white60,height: 0.25)),
        
        title: Text("Dashboard", style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        
        backgroundColor: Color(0xff0b090a),
        
        automaticallyImplyLeading: false,
        
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value,) {
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginScreen()),(Route<dynamic> route) => false);
              });
            },
            icon: Icon(Icons.logout, color: Colors.white60)
          )
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    
                    Column(
                      children: [
                        homeContainer("New Follow Up",screen,screen.width * 0.45, customerColor, context),
            
                        SizedBox(height: screen.height * 0.04),
                
                        homeContainer("Follow Up",screen,screen.width * 0.45, customerColor,context),
            
                        SizedBox(height: screen.height * 0.04),
                
                        downloadContainer("Follow Up Excel",screen, customerColor,screen.width * 0.45,context),
                      ],
                    ),
                    
                    SizedBox(width: screen.height * 0.02),

                    Column(
                      children: [
                        homeContainer("Add Due",screen,screen.width * 0.45, dueColor, context),
            
                        SizedBox(height: screen.height * 0.04),
                
                        homeContainer("View Due",screen,screen.width * 0.45, dueColor,context),
            
                        SizedBox(height: screen.height * 0.04),
                
                        downloadContainer("Due Excel",screen, dueColor,screen.width * 0.45,context),
                      ],
                    )
                  ],
                ),

                SizedBox(height: screen.height * 0.04),
                
                downloadContainer("All Data Excel",screen, stockColor,screen.width * 0.95,context),
            
                SizedBox(height: screen.height * 0.04),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    downloadContainer("Stock",screen, stockColor,screen.width * 0.45,context),

                    SizedBox(width: screen.width * 0.05),
                    
                    downloadContainer("Sales",screen, stockColor,screen.width * 0.45,context),

                  ],
                ),

                SizedBox(height: screen.height * 0.04),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeContainer("Add Stock",screen,screen.width * 0.45, stockColor,context),

                    SizedBox(width: screen.width * 0.05),
                    
                    homeContainer("Modify Stock",screen,screen.width * 0.45, stockColor,context),    
                  ],
                ),
                
                SizedBox(height: screen.height * 0.04),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeContainer("Invoice",screen,screen.width * 0.45, customerColor,context),

                    SizedBox(width: screen.width * 0.05),
                    
                    homeContainer("Vehicle Number",screen,screen.width * 0.45, dueColor,context),    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
