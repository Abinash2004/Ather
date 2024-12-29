import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class AddDueScreen extends StatefulWidget {
  const AddDueScreen({super.key});
  
  static var serial = 0;

  @override
  State<AddDueScreen> createState() => _AddDueScreenState();
}

class _AddDueScreenState extends State<AddDueScreen> {

  var name = TextEditingController();
  var dueDate = "Select a Date";
  var phone = TextEditingController();
  var totalDue = TextEditingController();
  String? dueStatus = "Pending";
  var paidAmount1 = TextEditingController();
  var paidDate1 = "";
  var paidAmount2 = TextEditingController();
  var paidDate2 = "";
  var paidAmount3 = TextEditingController();
  var paidDate3 = "";
  var paidAmount4 = TextEditingController();
  var paidDate4 = "";
  var paidAmount5 = TextEditingController();
  var paidDate5 = "";

  DateTime? selectedDate;
  final List<String> statusList = ["Pending", "Paid"];

  Future<void> _selectDate( var temp, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(data: ThemeData.dark(),child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        final formattedDate = DateFormat('dd / MM / yyyy').format(picked);
        switch (temp) {
          case "0":
            dueDate = formattedDate;
            break;
          case "1":
            paidDate1 = formattedDate;
            break;
          case "2":
            paidDate2 = formattedDate;
            break;
          case "3":
            paidDate3 = formattedDate;
            break;
          case "4":
            paidDate4 = formattedDate;
            break;
          case "5":
            paidDate5 = formattedDate;
            break;
          default:
            break;
        }
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
        title: Text("Add Due",style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {

              bool condition = dueDate == "Select a Date" || name.text.toString().isEmpty || phone.text.toString().isEmpty || totalDue.text.toString().isEmpty || dueStatus.toString().isEmpty ;
              
              if(condition) {
                snackbar("Incomplete Data", context);
                
              } else {
                await saveDue(AddDueScreen.serial, name, dueDate, phone, totalDue, dueStatus, paidAmount1, paidDate1, paidAmount2, paidDate2, paidAmount3, paidDate3, paidAmount4, paidDate4, paidAmount5, paidDate5, false, context);
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
                inputContainer(Text("Serial Number : ${AddDueScreen.serial}",style: textStyle())),
                SizedBox(height: 20),

                textField("Customer Name", name, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Date : \t$dueDate",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("0",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Phone Number", phone, true),
                SizedBox(height: 20),

                textField("Total Due", totalDue, true),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Due Status : \t",style: textStyle()),
                    DropdownButton<String>(
                      dropdownColor: Color.fromARGB(255, 15, 15, 15),
                      value: dueStatus,
                      items: statusList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,style: textStyle()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {dueStatus = newValue;});
                      },
                    ),    
                  ],
                )),
                SizedBox(height: 20),
                
                textField("Paid Amount 1st", paidAmount1, true),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Date 1st : \t$paidDate1",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("1",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 2nd", paidAmount2, true),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Date 2nd : \t$paidDate2",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("2",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 3rd", paidAmount3, true),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Date 3rd : \t$paidDate3",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("3",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 4th", paidAmount4, true),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Date 4th : \t$paidDate4",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("4",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 5th", paidAmount5, true),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Date 5th : \t$paidDate5",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("5",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
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