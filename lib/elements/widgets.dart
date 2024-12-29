import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:show_room/Screens/Customer/add_customer.dart';
import 'package:show_room/Screens/Due/add_due.dart';
import 'package:show_room/Screens/Due/view_due.dart';
import 'package:show_room/Screens/Stock/add_stock.dart';
import 'package:show_room/Screens/Stock/after_sales.dart';
import 'package:show_room/Screens/Stock/vehicle_number.dart';
import 'package:show_room/Screens/home.dart';
import 'package:show_room/Screens/Stock/modify_stock.dart';
import 'package:show_room/Screens/Customer/view_customer.dart';
import 'package:show_room/elements/functions.dart';

//Root
var accentColor1 = Color.fromARGB(255, 25, 25, 25);

TextStyle textStyle() {
  return TextStyle(
    fontSize: 18,
    color: Colors.white54,
    fontWeight: FontWeight.w500
  );
}

ButtonStyle buttonStyle() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) => states.contains(WidgetState.pressed) ? null : Colors.white60),
  );
}

ButtonStyle homeButtonStyle(var color) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) => states.contains(WidgetState.pressed) ? null : color),
  );
}

Widget customerListTitle(String text) {
  return Text(text, 
    style: TextStyle(
      color: Colors.white60,
      fontSize: 18,
      fontWeight: FontWeight.w500
    )
  );
}

Widget customerListSubTitle(String text) {
  return Text(text, 
    style: TextStyle(
      color: Colors.white30,
      fontSize: 16,
      fontWeight: FontWeight.w500
    )
  );
}

Pinput pinPutOTP(var otpCode) {
  final defaultPinTheme = PinTheme(
    width: 45,
    height: 45,
    textStyle: TextStyle(
      color: Colors.white70,
      fontSize: 25,
      fontWeight: FontWeight.w900
    ),
    decoration: BoxDecoration(
      color: accentColor1,
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Colors.grey, width: 2.5),
    borderRadius: BorderRadius.circular(10),
  );

  return Pinput(
    length: 6,
    defaultPinTheme: defaultPinTheme,
    focusedPinTheme: focusedPinTheme,
    controller: otpCode,
    showCursor: true,
  );
}

Widget homeContainer(var title, var screen, var size, var color, var context) {
  return SizedBox(
    height: 50,
    width: size,
    child:ElevatedButton(
      style: homeButtonStyle(color),
      onPressed: () async {
        if(title == "Add Stock") {
          await getStockSerialNumber();
          Navigator.push(context,MaterialPageRoute(builder: (context) => const AddStockScreen()));
        } else if(title == "Modify Stock") {
          showDialog(context: context,builder: (context) {return passwordModifyBox(context);});
        } else if(title == "New Follow Up") {
          await getCustomerSerialNumber();
          Navigator.push(context,MaterialPageRoute(builder: (context) => const AddCustomerScreen()));
        } else if(title == "Follow Up") {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const ViewCustomerScreen()));
        } else if(title == "Add Due") {
          await getDueSerialNumber();
          Navigator.push(context,MaterialPageRoute(builder: (context) => const AddDueScreen()));
        } else if(title == "Invoice") {
          clearStockData();
          Navigator.push(context,MaterialPageRoute(builder: (context) => const AfterSalesScreen()));
        } else if(title == "Vehicle Number") {
          clearStockData();
          Navigator.push(context,MaterialPageRoute(builder: (context) => const VehicleNumberScreen()));
        } else if(title == "View Due") {
          showDialog(context: context,builder: (context) {return passwordDueBox(context);});
        }
      },
      child: Text(title,
      style: TextStyle(
        color: accentColor1,
        fontSize: screen.width * 0.04,
        fontWeight: FontWeight.w700
      ),)
    )
  );
}

Widget downloadContainer(var title, var screen,var color,var size, var context) {

  var databaseRef = FirebaseDatabase.instance.ref();

  if(title == "All Data Excel" || title == "Stock" || title == "Sales") {
    databaseRef = FirebaseDatabase.instance.ref('Stock');
  } else if(title == "Follow Up Excel") {
    databaseRef = FirebaseDatabase.instance.ref('Customer');
  } else if(title == "Due Excel") {
    databaseRef = FirebaseDatabase.instance.ref('Due');
  }

  return SizedBox(
    height: 50,
    width: size,
    child:ElevatedButton(
      style: homeButtonStyle(color),
      onPressed: () async {
        if(title == "All Data Excel") {
          showDialog(context: context,builder: (context) {return passwordReportBox(context);});
        } else if(title == "Stock") {
          await createViewStockExcel();
        } else if(title == "Sales") {
          await createViewSalesExcel();
        } else if(title == "Follow Up Excel"){
          await createCustomerExcel();
        } else if(title == "Due Excel"){
          await createDueExcel();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: databaseRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
                  if(title == "All Data Excel" || title == "Stock" || title == "Sales") {
                    HomeScreen.stockList = map.values.toList();
                  } else if(title == "Follow Up Excel") {
                    HomeScreen.customerList = map.values.toList();
                  } else if(title == "Due Excel") {
                    HomeScreen.dueList = map.values.toList();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(title,
                      style: TextStyle(
                        color: accentColor1,
                        fontSize: screen.width * 0.04,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          )
        ],
      )
    )
  );
}

Widget textField(var text,var controller, bool isDigit) {

  var defaultBorder = const OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.solid, width: 0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      );

  return TextFormField(
    controller: controller,
    keyboardType: isDigit ? TextInputType.number : TextInputType.text,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.w600 ),

    decoration: InputDecoration(
      
      contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
      filled: true,
      fillColor: accentColor1,
      labelText: text,
      labelStyle:  textStyle(),
      floatingLabelStyle: TextStyle(color: Colors.white38, fontSize: 20),
      
      enabledBorder: defaultBorder,
      errorBorder: defaultBorder,
      focusedErrorBorder: defaultBorder,
      focusedBorder: defaultBorder,
    ), 
  );
}

Widget stockTextField(var controller, var fun) {

  var defaultBorder = const OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.solid, width: 0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      );

  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.w600 ),

    decoration: InputDecoration(
      
      contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
      filled: true,
      fillColor: accentColor1,
      labelText: "Stock Serial Number",
      labelStyle:  textStyle(),
      floatingLabelStyle: TextStyle(color: Colors.white38, fontSize: 20),
      suffixIcon: IconButton(onPressed: fun, icon: Icon(Icons.search_rounded, color: Colors.white60, size: 25)),
      
      enabledBorder: defaultBorder,
      errorBorder: defaultBorder,
      focusedErrorBorder: defaultBorder,
      focusedBorder: defaultBorder,
    ), 
  );
}

AlertDialog passwordReportBox(var context) {
  var otpCode = TextEditingController();
  return AlertDialog(
    backgroundColor: Color(0xff0b090a),
    title: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter The Code",style: textStyle()),
          const SizedBox(height: 20),
          pinPutOTP(otpCode),
          const SizedBox(height: 20),
          ElevatedButton(
            style: buttonStyle(),
            onPressed: () async{
              
              final databaseRef = FirebaseDatabase.instance.ref();
              var databaseSnapshot = await databaseRef.child('Password').get();

              if(otpCode.text == databaseSnapshot.child("Stock Report Password").value.toString()) {
                Navigator.pop(context);
                await createStockExcel();
              } else {
                Navigator.pop(context);
                snackbar("Incorrect Code", context);
              }
            },
            child: Text("NEXT",style: TextStyle(
              color: Color.fromARGB(255, 25, 25, 25),
              fontSize: 15,
              fontWeight: FontWeight.w700
            ))
          )
        ],
      ),
    ),
  );
}

AlertDialog passwordDueBox(var context) {
  var otpCode = TextEditingController();
  return AlertDialog(
    backgroundColor: Color(0xff0b090a),
    title: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter The Code",style: textStyle()),
          const SizedBox(height: 20),
          pinPutOTP(otpCode),
          const SizedBox(height: 20),
          ElevatedButton(
            style: buttonStyle(),
            onPressed: () async{
              
              final databaseRef = FirebaseDatabase.instance.ref();
              var databaseSnapshot = await databaseRef.child('Password').get();

              if(otpCode.text == databaseSnapshot.child("Due Report Password").value.toString()) {
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => const ViewDueScreen()));
              } else {
                Navigator.pop(context);
                snackbar("Incorrect Code", context);
              }
            },
            child: Text("NEXT",style: TextStyle(
              color: Color.fromARGB(255, 25, 25, 25),
              fontSize: 15,
              fontWeight: FontWeight.w700
            ))
          )
        ],
      ),
    ),
  );
}

AlertDialog passwordModifyBox(var context) {
  var otpCode = TextEditingController();
  return AlertDialog(
    backgroundColor: Color(0xff0b090a),
    title: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter The Code",style: textStyle()),
          const SizedBox(height: 20),
          pinPutOTP(otpCode),
          const SizedBox(height: 20),
          ElevatedButton(
            style: buttonStyle(),
            onPressed: () async {

              final databaseRef = FirebaseDatabase.instance.ref();
              var databaseSnapshot = await databaseRef.child('Password').get();
              
              if(otpCode.text == databaseSnapshot.child("Modify Stock Password").value.toString()) {
                clearStockData();
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => const ModifyStockScreen()));
              }
              else {
                Navigator.pop(context);
                snackbar("Incorrect Code", context);
              }
            },
            child: Text("NEXT",style: TextStyle(
              color: Color.fromARGB(255, 25, 25, 25),
              fontSize: 15,
              fontWeight: FontWeight.w700
            ))
          )
        ],
      ),
    ),
  );
}

Widget inputContainer(var widget) {
  return Container(
    height: 60,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 25, 25, 25),
      borderRadius: BorderRadius.circular(30), // Circular radius
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: widget,
      )
    )
  );
}

Widget appBarInputContainer(var widget) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Container(
      height: 40,
      width: 130,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 25, 25, 25),
        borderRadius: BorderRadius.circular(30), // Circular radius
      ),
      child: Align(
        alignment: Alignment.center,
        child: widget
      )
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(var text, var context) {
  return  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 150, 150, 150),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // Rounded corners
      ),
      content: Center(
        child: Text(text,
          style: TextStyle(
            color: Color.fromARGB(255, 25, 25, 25),
            fontSize: 22,
            fontWeight: FontWeight.w800
          ),
        ),
      )
    )
  );
}