import 'package:flutter/material.dart';
import 'package:show_room/elements/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<dynamic> stockList = [];
  static List<dynamic> customerList = [];
  static List<dynamic> dueList = [];
  static List<dynamic> paymentList = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.sizeOf(context);
    
    var customerColor = Color.fromARGB(255, 25, 35, 45);
    var dueColor = Color.fromARGB(255, 30, 25, 45);
    var stockColor = Color.fromARGB(255, 25, 25, 25);

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
            
                        SizedBox(height: screen.height * 0.03),
                
                        homeContainer("Follow Up",screen,screen.width * 0.45, customerColor,context),
            
                        SizedBox(height: screen.height * 0.03),
                
                        downloadContainer("Follow Up Excel",screen, customerColor,screen.width * 0.45,context),
                      ],
                    ),
                    
                    SizedBox(width: screen.height * 0.02),

                    Column(
                      children: [
                        homeContainer("Add Due",screen,screen.width * 0.45, dueColor, context),
            
                        SizedBox(height: screen.height * 0.03),
                
                        homeContainer("View Due",screen,screen.width * 0.45, dueColor,context),
            
                        SizedBox(height: screen.height * 0.03),
                
                        downloadContainer("Due Excel",screen, dueColor,screen.width * 0.45,context),
                      ],
                    )
                  ],
                ),

                SizedBox(height: screen.height * 0.03),
                
                downloadContainer("All Data Excel",screen, stockColor,screen.width * 0.95,context),
            
                SizedBox(height: screen.height * 0.03),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    downloadContainer("Stock",screen, stockColor,screen.width * 0.45,context),

                    SizedBox(width: screen.width * 0.05),
                    
                    downloadContainer("Sales",screen, stockColor,screen.width * 0.45,context),

                  ],
                ),

                SizedBox(height: screen.height * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeContainer("Add Stock",screen,screen.width * 0.45, stockColor,context),

                    SizedBox(width: screen.width * 0.05),
                    
                    homeContainer("Modify Stock",screen,screen.width * 0.45, stockColor,context),    
                  ],
                ),
                
                SizedBox(height: screen.height * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeContainer("Invoice",screen,screen.width * 0.45, customerColor,context),

                    SizedBox(width: screen.width * 0.05),
                    
                    homeContainer("Vehicle Number",screen,screen.width * 0.45, customerColor,context),    
                  ],
                ),

                SizedBox(height: screen.height * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeContainer("Payment",screen,screen.width * 0.45, dueColor,context),

                    SizedBox(width: screen.width * 0.05),
                    
                    downloadContainer("Payment Excel",screen, dueColor,screen.width * 0.45,context),    
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
