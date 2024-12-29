import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class AfterSalesScreen extends StatefulWidget {
  const AfterSalesScreen({super.key});

  static var serial = "";
  static var customerName = "";

  @override
  State<AfterSalesScreen> createState() => _AfterSalesScreenState();
}

class _AfterSalesScreenState extends State<AfterSalesScreen> {
  
  var serial = TextEditingController();
  var invoiceNumber = TextEditingController();
  var invoiceDate = "Select a Date";

  DateTime? selectedStockDate;

  Future<void> _selectDate(BuildContext context, bool isSold) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(data: ThemeData.dark(),child: child!);
      },
    );
    if (picked != null && picked != selectedStockDate) {
      setState(() {
        selectedStockDate = DateTime(picked.year, picked.month, picked.day);
        (isSold) ? invoiceDate = DateFormat('dd / MM / yyyy').format(selectedStockDate!) : invoiceDate = DateFormat('dd / MM / yyyy').format(selectedStockDate!);
      });
    }
  }
  
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

              bool condition =  invoiceDate == "Select a Date" || invoiceNumber.text.isEmpty ;

              if(condition) {
                snackbar("Incomplete Data", context);
              }
              else {
                await saveInvoice(AfterSalesScreen.serial, invoiceNumber, invoiceDate, context);
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
                    await getStockInvoice(serial, context);
                    setState(() {});
                  }
                }),
                SizedBox(height: 20),

                inputContainer(Text("Customer Name : ${AfterSalesScreen.customerName}",style: textStyle())),
                SizedBox(height: 20),

                textField("Invoice Number", invoiceNumber, false),
                SizedBox(height: 20),

                inputContainer(Row( children: [
                    Text("Invoice Date : \t$invoiceDate",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context,false),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}