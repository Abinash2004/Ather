import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});
  static var serial = "0";

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  
  var date = "Select a Date";
  String? import = "By Load";
  var chassis = TextEditingController();
  var model = TextEditingController();
  var variant = TextEditingController();
  var color = TextEditingController();
  var exShowRoom = TextEditingController();
  var insurance = TextEditingController();
  var rto = TextEditingController();
  var hp = TextEditingController();
  var proPack = TextEditingController();
  String stockStatus = "Stock";
  
  DateTime? selectedDate;
  final List<String> importList = ["By Load", "By Road"];

  Future<void> _selectDate(BuildContext context) async {
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
        date = DateFormat('dd / MM / yyyy').format(selectedDate!);
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
        title: Text("Add Stock",style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {

              bool condition = date == "Select a Date" || chassis.text.toString().isEmpty || model.text.toString().isEmpty || variant.text.toString().isEmpty || color.text.toString().isEmpty || exShowRoom.text.toString().isEmpty || insurance.text.toString().isEmpty || rto.text.toString().isEmpty || hp.text.toString().isEmpty || proPack.text.toString().isEmpty;
              
              if(condition) {
                snackbar("Incomplete Data", context);
                
              } else {
                await saveStock(AddStockScreen.serial,date, import, chassis.text, model, variant, color, exShowRoom, insurance, rto, hp, proPack, stockStatus, false, context);
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
                
                inputContainer(Text("Serial Number : ${AddStockScreen.serial}",style: textStyle())),
                SizedBox(height: 20),
                
                inputContainer(Row(children: [
                    Text("Date : \t$date",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),
                
                inputContainer(Row(children: [
                    Text("Import Method : \t",style: textStyle()),
                    DropdownButton<String>(
                      dropdownColor: Color.fromARGB(255, 15, 15, 15),
                      value: import,
                      items: importList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,style: textStyle()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {import = newValue;});
                      },
                    ),    
                  ],
                )),
                SizedBox(height: 20),

                textField("Chassis Number", chassis, false),
                SizedBox(height: 20),

                textField("Model Name", model, false),
                SizedBox(height: 20),

                textField("Variant Name", variant, false),
                SizedBox(height: 20),
                
                textField("Model Color", color, false),
                SizedBox(height: 20),
                
                textField("Ex-Showroom Amount", exShowRoom, true),
                SizedBox(height: 20),
                
                textField("Insurance Amount", insurance, true),
                SizedBox(height: 20),
                
                textField("RTO Amount", rto, true),
                SizedBox(height: 20),
                
                textField("HP Amount", hp, true),
                SizedBox(height: 20),
                
                textField("Pro Pack Amount", proPack, true),
                SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}