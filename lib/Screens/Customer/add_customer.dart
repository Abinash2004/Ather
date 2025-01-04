import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});
  static var serial = "0";

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {

  var visitDate = "Select a Date";
  var customerName = TextEditingController();
  var contactNumber = TextEditingController();
  var address = TextEditingController();
  var modelName = TextEditingController();
  var variantName = TextEditingController();
  var color = TextEditingController();
  String? customerStatus = "Hot";
  String? paymentType = "Cash";
  var followUpDate = "Select a Date";
  var remark1 = TextEditingController();
  var remark2 = TextEditingController();

  final List<String> statusList = ["Hot", "Warm", "Cold", "Purchased", "Closed"];
  final List<String> paymentList = ["Cash", "Finance", "Finance (No HP)"];

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context, bool isVisit) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(data: ThemeData.dark(),child: child!);
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
        isVisit ? visitDate = DateFormat('dd / MM / yyyy').format(selectedDate!) : followUpDate = DateFormat('dd / MM / yyyy').format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0b090a),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.white60,height: 0.25)),
        title: Text("Add Customer",style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {

              bool condition = visitDate == "Select a Date" || customerName.text.toString().isEmpty || contactNumber.text.toString().isEmpty || address.text.toString().isEmpty;

              if(condition) {
                snackbar("Fill Upto Address", context);
              } else {
                await saveCustomer(AddCustomerScreen.serial, visitDate, customerName, contactNumber, address, modelName, variantName, color, customerStatus, paymentType, followUpDate, remark1, remark2, false, context);
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
                
                inputContainer(Text("Serial Number : ${AddCustomerScreen.serial}",style: textStyle())),
                SizedBox(height: 20),
                
                inputContainer(Row(children: [
                    Text("Visit Date : \t$visitDate",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context,true),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Customer Name", customerName, false),
                SizedBox(height: 20),

                textField("Contact Number", contactNumber, true),
                SizedBox(height: 20),

                textField("Address", address, false),
                SizedBox(height: 20),

                textField("Model Name", modelName, false),
                SizedBox(height: 20),
                
                textField("Variant Name", variantName, false),
                SizedBox(height: 20),
                
                textField("Model Color", color, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                  Text("Status : \t",style: textStyle()),
                  DropdownButton<String>(
                    dropdownColor: Color.fromARGB(255, 15, 15, 15),
                    value: customerStatus,
                    items: statusList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,style: textStyle()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {customerStatus = newValue;});
                    },
                  ),    
                ],
                )),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                  Text("Payment : \t",style: textStyle()),
                  DropdownButton<String>(
                    dropdownColor: Color.fromARGB(255, 15, 15, 15),
                    value: paymentType,
                    items: paymentList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,style: textStyle()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {paymentType = newValue;});
                    },
                  ),    
                ],
                )),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Follow Up : \t$followUpDate",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context,false),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),
                
                textField("Remark 1", remark1, false),
                SizedBox(height: 20),
                
                textField("Remark 2", remark2, false),
                SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}