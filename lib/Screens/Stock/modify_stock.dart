import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:show_room/elements/functions.dart';
import 'package:show_room/elements/widgets.dart';

class ModifyStockScreen extends StatefulWidget {
  const ModifyStockScreen({super.key});

  static var serial = "";
  static var stockDate = "";
  static var import = "By Load";
  static var chassis = "";
  static var model = "";
  static var variant = "";
  static var color = "";
  static var exShowRoom = "";
  static var insurance = "";
  static var rto = "";
  static var hp = "";
  static var proPack = "";
  static var stockStatus = "Stock";
  static var salesDate = "";
  static var paymentType = "Cash";
  static var disAmount = "";
  static var customerName = "";
  static var receviedAmount = "";

  @override
  State<ModifyStockScreen> createState() => _ModifyStockScreenState();
}

class _ModifyStockScreenState extends State<ModifyStockScreen> {

  var serial = TextEditingController();
  var stockDate = "Select a Date";
  String? import = "By Load";
  var model = TextEditingController();
  var variant = TextEditingController();
  var color = TextEditingController();
  var exShowRoom = TextEditingController();
  var insurance = TextEditingController();
  var rto = TextEditingController();
  var hp = TextEditingController();
  var proPack = TextEditingController();
  String? stockStatus = "Stock";
  var salesDate = "Select a Date";
  String? paymentType = "Cash";
  var disAmount = TextEditingController();
  var customerName = TextEditingController();
  var receivedAmount = TextEditingController();

  
  DateTime? selectedStockDate;
  final List<String> importList = ["By Load", "By Road"];
  final List<String> stockStatusList = ["Stock", "Sold", "Returned"];
  final List<String> paymentList = ["Cash", "Finance", "Finance (No HP)"];

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
        (isSold) ? salesDate = DateFormat('dd / MM / yyyy').format(selectedStockDate!) : stockDate = DateFormat('dd / MM / yyyy').format(selectedStockDate!);
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
        title: Text("Modify Stock", style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,
        actions: [

          IconButton(
            onPressed: () async {

              bool condition1 = (stockDate == "Select a Date" || model.text.isEmpty || variant.text.isEmpty || color.text.isEmpty || exShowRoom.text.isEmpty || insurance.text.isEmpty || rto.text.isEmpty || hp.text.isEmpty || proPack.text.isEmpty);

              bool condition2 = (stockStatus != "Stock" && (salesDate == "Select a Date" || customerName.text.isEmpty));

              bool condition3 = (stockStatus == "Sold" && (disAmount.text.isEmpty  || receivedAmount.text.isEmpty));

              bool condition =  condition1 || condition2 || condition3;

              if(condition) {
                snackbar("Incomplete Data", context);
              }
              else {
                if(stockStatus == "Stock") {
                  saveStock(ModifyStockScreen.serial, stockDate, import, ModifyStockScreen.chassis, model, variant, color, exShowRoom, insurance, rto, hp, proPack, stockStatus,true, context);
                } else {
                  
                  saveSales(ModifyStockScreen.serial, stockDate, import, ModifyStockScreen.chassis, model, variant, color, exShowRoom, insurance, rto, hp, proPack, stockStatus, salesDate, paymentType, disAmount, customerName, receivedAmount, context);
                }
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
                  if(serial.text.isNotEmpty) {
                    await getStockReport(serial, context);
                  }
                  if(ModifyStockScreen.stockDate == "") {
                    snackbar("Stock Not Found", context);
                  }
                  setState(() {
                    stockDate = ModifyStockScreen.stockDate;
                    model.setText(ModifyStockScreen.model);
                    variant.setText(ModifyStockScreen.variant);
                    color.setText(ModifyStockScreen.color);
                    exShowRoom.setText(ModifyStockScreen.exShowRoom);
                    insurance.setText(ModifyStockScreen.insurance);
                    rto.setText(ModifyStockScreen.rto);
                    hp.setText(ModifyStockScreen.hp);
                    proPack.setText(ModifyStockScreen.proPack);
                    stockStatus = ModifyStockScreen.stockStatus;
                    salesDate = ModifyStockScreen.salesDate;
                    paymentType = ModifyStockScreen.paymentType;
                    disAmount.setText(ModifyStockScreen.disAmount);
                    customerName.setText(ModifyStockScreen.customerName);
                    receivedAmount.setText(ModifyStockScreen.receviedAmount);

                  });
                }),
                SizedBox(height: 20),
                
                inputContainer(Row( children: [
                    Text("Date : \t$stockDate",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context,false),icon: Icon(Icons.calendar_month, color: Colors.white60,size: 25)),
                  ],
                )),
                SizedBox(height: 20),
                
                inputContainer(Row(children: [
                    Text("Import Method : \t",style: textStyle()),
                    DropdownButton<String>(
                      dropdownColor: Color.fromARGB(255, 30, 30, 30),
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

                inputContainer(Text("Chassis Number : ${ModifyStockScreen.chassis}",style: textStyle())),
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
                
                inputContainer(Row(children: [
                    Text("Stock Status : \t",style: textStyle()),
                    DropdownButton<String>(
                      dropdownColor: Color.fromARGB(255, 30, 30, 30),
                      value: stockStatus,
                      items: stockStatusList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,style: textStyle()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {stockStatus = newValue;});
                        
                        if (stockStatus != "Sold") {
                          salesDate = "Select a Date";
                          paymentType = "Cash";
                          disAmount.setText("");
                          receivedAmount.setText("");
                        } if (stockStatus == "Stock") {
                          customerName.setText("");
                        }
                      },
                    ),    
                  ],
                )),
                SizedBox(height: 20),

                (stockStatus != "Stock") ? inputContainer(Row(children: [
                    Text("Sales Date : \t$salesDate",style: textStyle()),
                    IconButton(onPressed: () => _selectDate(context,true),icon: Icon(Icons.calendar_month,size: 25)),
                  ],
                )) : SizedBox(),
                (stockStatus != "Stock") ? SizedBox(height: 20) : SizedBox(),

                (stockStatus == "Sold") ? inputContainer(Row(children: [
                    Text("Payment : \t",style: textStyle()),
                    DropdownButton<String>(
                      dropdownColor: Color.fromARGB(255, 30, 30, 30),
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
                )) : SizedBox(),
                (stockStatus == "Sold") ? SizedBox(height: 20) : SizedBox(),
                
                (stockStatus == "Sold") ? textField("Dis Amount", disAmount, true) : SizedBox(),
                (stockStatus == "Sold") ? SizedBox(height: 20) : SizedBox(),

                (stockStatus != "Stock") ? textField("Customer Name", customerName, false) : SizedBox(),
                (stockStatus != "Stock") ? SizedBox(height: 20) : SizedBox(),

                (stockStatus == "Sold") ? textField("Received Amount", receivedAmount, true) : SizedBox(),
                (stockStatus == "Sold") ? SizedBox(height: 20) : SizedBox(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}