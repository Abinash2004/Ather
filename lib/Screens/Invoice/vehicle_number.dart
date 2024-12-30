import 'package:flutter/material.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class VehicleNumberScreen extends StatefulWidget {
  const VehicleNumberScreen({super.key});

  static var serial = "";
  static var customerName = "";

  @override
  State<VehicleNumberScreen> createState() => _VehicleNumberScreenState();
}

class _VehicleNumberScreenState extends State<VehicleNumberScreen> {
  
  var serial = TextEditingController();
  var vehicleNumber = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.white60,height: 0.25)),
        title: Text("Add Invoice", style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,
        actions: [

          IconButton(
            onPressed: () async {

              if(vehicleNumber.text.isEmpty || VehicleNumberScreen.customerName.isEmpty) {
                snackbar("Incomplete Data", context);
              }
              else {
                await saveVehicleNumber(VehicleNumberScreen.serial, vehicleNumber, context);
              }
            },
            icon: Icon(Icons.upload_rounded, color: Colors.white60, size: 30))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(height: 20),
                stockTextField(serial, () async {
                  setState(() {
                    clearStockData();
                  });
                  if(serial.text.isEmpty) {
                    snackbar("Serial Number is Required", context);
                  }
                  if(serial.text.isNotEmpty) {
                    await getStockVehicle(serial, context);
                    setState(() {});
                  }
                }),
                SizedBox(height: 20),

                inputContainer(Text("Customer Name : ${VehicleNumberScreen.customerName}",style: textStyle())),
                SizedBox(height: 20),

                textField("Vehicle Number", vehicleNumber, false),
                SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}