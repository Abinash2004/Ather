import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class ModifyCustomerScreen extends StatefulWidget {
  const ModifyCustomerScreen({super.key});

  static var serial = "";
  static var visitDate = "Select a Date";
  static var customerName = TextEditingController();
  static var contactNumber = TextEditingController();
  static var address = TextEditingController();
  static var modelName = TextEditingController();
  static var variantName = TextEditingController();
  static var color = TextEditingController();
  static String? customerStatus = "Hot";
  static String? paymentType = "Cash";
  static var followUpDate = "";
  static var remark1 = TextEditingController();
  static var remark2 = TextEditingController();

  @override
  State<ModifyCustomerScreen> createState() => _ModifyCustomerScreenState();
}

class _ModifyCustomerScreenState extends State<ModifyCustomerScreen> {

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
        isVisit ? ModifyCustomerScreen.visitDate = DateFormat('dd / MM / yyyy').format(selectedDate!) : ModifyCustomerScreen.followUpDate = DateFormat('dd / MM / yyyy').format(selectedDate!);
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

              bool condition = ModifyCustomerScreen.visitDate == "Select a Date" || ModifyCustomerScreen.customerName.text.toString().isEmpty || ModifyCustomerScreen.contactNumber.text.toString().isEmpty || ModifyCustomerScreen.address.text.toString().isEmpty;

              if(condition) {
                snackbar("Fill Upto Address", context);
              } else {
                await saveCustomer(ModifyCustomerScreen.serial, ModifyCustomerScreen.visitDate, ModifyCustomerScreen.customerName, ModifyCustomerScreen.contactNumber, ModifyCustomerScreen.address, ModifyCustomerScreen.modelName, ModifyCustomerScreen.variantName, ModifyCustomerScreen.color, ModifyCustomerScreen.customerStatus, ModifyCustomerScreen.paymentType, ModifyCustomerScreen.followUpDate, ModifyCustomerScreen.remark1, ModifyCustomerScreen.remark2, true, context);
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
                
                inputContainer(Text("Serial Number : ${ModifyCustomerScreen.serial}",style: textStyle())),
                SizedBox(height: 20),
                
                inputContainer(Row(children: [
                    Text("Visit Date : \t${ModifyCustomerScreen.visitDate}",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context,true),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Customer Name", ModifyCustomerScreen.customerName, false),
                SizedBox(height: 20),

                textField("Contact Number", ModifyCustomerScreen.contactNumber, true),
                SizedBox(height: 20),

                textField("Address", ModifyCustomerScreen.address, false),
                SizedBox(height: 20),

                textField("Model Name", ModifyCustomerScreen.modelName, false),
                SizedBox(height: 20),
                
                textField("Variant Name", ModifyCustomerScreen.variantName, false),
                SizedBox(height: 20),
                
                textField("Model Color", ModifyCustomerScreen.color, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                  Text("Status : \t",style: textStyle()),
                  DropdownButton<String>(
                    dropdownColor: Color.fromARGB(255, 15, 15, 15),
                    value: ModifyCustomerScreen.customerStatus,
                    items: statusList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,style: textStyle()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {ModifyCustomerScreen.customerStatus = newValue;});
                    },
                  ),    
                ],
                )),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                  Text("Payment : \t",style: textStyle()),
                  DropdownButton<String>(
                    dropdownColor: Color.fromARGB(255, 15, 15, 15),
                    value: ModifyCustomerScreen.paymentType,
                    items: paymentList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,style: textStyle()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {ModifyCustomerScreen.paymentType = newValue;});
                    },
                  ),    
                ],
                )),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Follow Up : \t${ModifyCustomerScreen.followUpDate}",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context,false),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),
                
                textField("Remark 1", ModifyCustomerScreen.remark1, false),
                SizedBox(height: 20),
                
                textField("Remark 2", ModifyCustomerScreen.remark2, false),
                SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}