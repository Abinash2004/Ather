import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class ModifyDueScreen extends StatefulWidget {
  const ModifyDueScreen({super.key});

  static var serialNumber = "";
  static var name = TextEditingController();
  static var dueDate = "";
  static var phone = TextEditingController();
  static var totalDue = TextEditingController();
  static var remainingDue = "";
  static String? dueStatus = "Pending";
  static var paidAmount1 = TextEditingController();
  static var paidDate1 = "";
  static var paidAmount2 = TextEditingController();
  static var paidDate2 = "";
  static var paidAmount3 = TextEditingController();
  static var paidDate3 = "";
  static var paidAmount4 = TextEditingController();
  static var paidDate4 = "";
  static var paidAmount5 = TextEditingController();
  static var paidDate5 = "";

  @override
  State<ModifyDueScreen> createState() => _ModifyDueScreenState();
}

class _ModifyDueScreenState extends State<ModifyDueScreen> {

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
            ModifyDueScreen.dueDate = formattedDate;
            break;
          case "1":
            ModifyDueScreen.paidDate1 = formattedDate;
            break;
          case "2":
            ModifyDueScreen.paidDate2 = formattedDate;
            break;
          case "3":
            ModifyDueScreen.paidDate3 = formattedDate;
            break;
          case "4":
            ModifyDueScreen.paidDate4 = formattedDate;
            break;
          case "5":
            ModifyDueScreen.paidDate5 = formattedDate;
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

              bool condition = ModifyDueScreen.dueDate == "Select a Date" || ModifyDueScreen.name.text.toString().isEmpty || ModifyDueScreen.phone.text.toString().isEmpty || ModifyDueScreen.totalDue.text.toString().isEmpty;

              if(condition) {
                snackbar("Fill Upto Address", context);
              } else {
                await saveDue(ModifyDueScreen.serialNumber, ModifyDueScreen.name, ModifyDueScreen.dueDate, ModifyDueScreen.phone, ModifyDueScreen.totalDue, ModifyDueScreen.dueStatus, ModifyDueScreen.paidAmount1, ModifyDueScreen.paidDate1, ModifyDueScreen.paidAmount2, ModifyDueScreen.paidDate2, ModifyDueScreen.paidAmount3, ModifyDueScreen.paidDate3, ModifyDueScreen.paidAmount4, ModifyDueScreen.paidDate4, ModifyDueScreen.paidAmount5, ModifyDueScreen.paidDate5, true, context);
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
                
                inputContainer(Text("Serial Number : ${ModifyDueScreen.serialNumber}",style: textStyle())),
                SizedBox(height: 20),

                textField("Customer Name", ModifyDueScreen.name, false),
                SizedBox(height: 20),
                
                inputContainer(Row(children: [
                    Text("Visit Date : \t${ModifyDueScreen.dueDate}",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("0",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),


                textField("Phone Number", ModifyDueScreen.phone, true),
                SizedBox(height: 20),

                textField("Total Due", ModifyDueScreen.totalDue, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                  Text("Status : \t",style: textStyle()),
                  DropdownButton<String>(
                    dropdownColor: Color.fromARGB(255, 15, 15, 15),
                    value: ModifyDueScreen.dueStatus,
                    items: statusList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,style: textStyle()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {ModifyDueScreen.dueStatus = newValue;});
                    },
                  ),    
                ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 1", ModifyDueScreen.paidAmount1, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Paid Date 1 : \t${ModifyDueScreen.paidDate1}",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("1",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 2", ModifyDueScreen.paidAmount1, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Paid Date 1 : \t${ModifyDueScreen.paidDate2}",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("2",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 3", ModifyDueScreen.paidAmount3, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Paid Date 3 : \t${ModifyDueScreen.paidDate3}",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("3",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 4", ModifyDueScreen.paidAmount4, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Paid Date 4 : \t${ModifyDueScreen.paidDate4}",style: textStyle()),
                    IconButton(onPressed: () => _selectDate("4",context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),

                textField("Paid Amount 5", ModifyDueScreen.paidAmount1, false),
                SizedBox(height: 20),

                inputContainer(Row(children: [
                    Text("Paid Date 5 : \t${ModifyDueScreen.paidDate5}",style: textStyle()),
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