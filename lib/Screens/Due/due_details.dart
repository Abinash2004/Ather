import 'package:flutter/material.dart';
import 'package:show_room/elements/widgets.dart';

class DueDetailsScreen extends StatefulWidget {
  const DueDetailsScreen({super.key});
  
  static var serialNumber = "";
  static var name = "";
  static var dueDate = "";
  static var phone = "";
  static var totalDue = "";
  static var remainingDue = "";
  static var dueStatus = "";
  static var paidAmount1 = "";
  static var paidDate1 = "";
  static var paidAmount2 = "";
  static var paidDate2 = "";
  static var paidAmount3 = "";
  static var paidDate3 = "";
  static var paidAmount4 = "";
  static var paidDate4 = "";
  static var paidAmount5 = "";
  static var paidDate5 = "";

  @override
  State<DueDetailsScreen> createState() => _DueDetailsScreenState();
}

class _DueDetailsScreenState extends State<DueDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xff0b090a),
      
      appBar: AppBar(
        
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.white60,height: 0.25)),
        
        title: Text("Due Information", style: TextStyle(
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
            inputContainer(Text("Serial Number : ${DueDetailsScreen.serialNumber}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Due Date : ${DueDetailsScreen.dueDate}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Name : ${DueDetailsScreen.name}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Phone Number : ${DueDetailsScreen.phone}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Total Due : ${DueDetailsScreen.totalDue}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Remaining Due : ${DueDetailsScreen.remainingDue}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Due Status : ${DueDetailsScreen.dueStatus}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Amount 1 : ${DueDetailsScreen.paidAmount1}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Date 1 : ${DueDetailsScreen.paidDate1}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Amount 2 : ${DueDetailsScreen.paidAmount2}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Date 2 : ${DueDetailsScreen.paidDate2}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Amount 3 : ${DueDetailsScreen.paidAmount3}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Date 3 : ${DueDetailsScreen.paidDate3}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Amount 4 : ${DueDetailsScreen.paidAmount4}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Date 4 : ${DueDetailsScreen.paidDate4}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Amount 5 : ${DueDetailsScreen.paidAmount5}",style: textStyle())),
            SizedBox(height: 10),
            inputContainer(Text("Paid Date 5 : ${DueDetailsScreen.paidDate5}",style: textStyle())),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}