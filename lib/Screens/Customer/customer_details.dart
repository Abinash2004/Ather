import 'package:flutter/material.dart';
import 'package:show_room/elements/widgets.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({super.key});

  static var serialNumber = "";
  static var visitDate = "";
  static var customerName = "";
  static var contactNumber = "";
  static var address = "";
  static var modelName = "";
  static var variantName = "";
  static var modelColor = "";
  static var customerStatus = "";
  static var paymentType = "";
  static var followUpDate = "";
  static var remark1 = "";
  static var remark2 = "";

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xff0b090a),
      
      appBar: AppBar(
        
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.white60,height: 0.25)),
        
        title: Text("Customer Information", style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            inputContainer(Text("Serial Number : ${CustomerDetailScreen.serialNumber}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Visit Date : ${CustomerDetailScreen.visitDate}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Name : ${CustomerDetailScreen.customerName}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Contact Number : ${CustomerDetailScreen.contactNumber}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Address : ${CustomerDetailScreen.address}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Model Name : ${CustomerDetailScreen.modelName}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Variant Name : ${CustomerDetailScreen.variantName}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Model Color : ${CustomerDetailScreen.modelColor}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Customer Status : ${CustomerDetailScreen.customerStatus}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Payment Type : ${CustomerDetailScreen.paymentType}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Follow Up Date : ${CustomerDetailScreen.followUpDate}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Remark 1 : ${CustomerDetailScreen.remark1}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Remark 2 : ${CustomerDetailScreen.remark2}",style: textStyle())),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
