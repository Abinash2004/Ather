import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:show_room/Screens/Customer/customer_details.dart';
import 'package:show_room/Screens/Customer/modify_customer.dart';
import 'package:show_room/elements/widgets.dart';

class ViewCustomerScreen extends StatefulWidget {
  const ViewCustomerScreen({super.key});

  @override
  State<ViewCustomerScreen> createState() => _ViewCustomerScreenState();
}

class _ViewCustomerScreenState extends State<ViewCustomerScreen> {

  String? month = "All";
  List<String> monthList = ["All", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  @override
  Widget build(BuildContext context) {
    
    final databaseRef = FirebaseDatabase.instance.ref('Customer');
    
    return Scaffold(
      backgroundColor: Color(0xff0b090a),
      
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.white60,height: 0.25)),
        
        title: Text("Customer List", style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,
        
        actions: [
          appBarInputContainer(DropdownButton<String>(
            dropdownColor: Color.fromARGB(255, 30, 30, 30),
            value: month,
            items: monthList.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: textStyle()),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {month = newValue;});
            },
          )),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: StreamBuilder(
              stream:databaseRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (snapshot.data!.snapshot.children.isEmpty) {
                  return const Center(child: Text('No Fees Recieved',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)));
                }
                else {  
                  Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> list = [];
                  list.clear();
                  list = map.values.toList();

                  return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context,index) {
                      bool isExist = true;
                      if(month == "All") {
                        isExist = true;
                      } else if(month == DateFormat.MMM().format(DateFormat("dd / MM / yyyy").parse(list[index]['Visit Date']))) {
                        isExist = true;
                      } else {
                        isExist = false;
                      }
                      return isExist ? Card(
                        color: Color.fromARGB(255, 25, 25, 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ListTile(
                          
                          title: customerListTitle('${list[index]['Customer Name']} - ${list[index]['Contact Number']}'),
                          subtitle: customerListSubTitle('Visited - ${list[index]['Visit Date']} - ${list[index]['Customer Status']}'),

                          onTap: () {
                            CustomerDetailScreen.serialNumber = list[index]['Serial Number'];
                            CustomerDetailScreen.visitDate = list[index]['Visit Date'];
                            CustomerDetailScreen.customerName = list[index]['Customer Name'];
                            CustomerDetailScreen.contactNumber = list[index]['Contact Number'];
                            CustomerDetailScreen.address = list[index]['Address'];
                            CustomerDetailScreen.modelName = list[index]['Model Name'];
                            CustomerDetailScreen.variantName = list[index]['Variant Name'];
                            CustomerDetailScreen.modelColor = list[index]['Model Color'];
                            CustomerDetailScreen.customerStatus = list[index]['Customer Status'];
                            CustomerDetailScreen.paymentType = list[index]['Payment Type'];
                            CustomerDetailScreen.followUpDate = list[index]['Follow Up Date'];
                            CustomerDetailScreen.remark1 = list[index]['Remark 1'];
                            CustomerDetailScreen.remark2 = list[index]['Remark 2'];
                            Navigator.push(context,MaterialPageRoute(builder: (context) => const CustomerDetailScreen()));
                          },

                          onLongPress: () {
                            ModifyCustomerScreen.serial = list[index]['Serial Number'];
                            ModifyCustomerScreen.visitDate = list[index]['Visit Date'];
                            ModifyCustomerScreen.customerName.setText(list[index]['Customer Name']);
                            ModifyCustomerScreen.contactNumber.setText(list[index]['Contact Number']);
                            ModifyCustomerScreen.address.setText(list[index]['Address']);
                            ModifyCustomerScreen.modelName.setText(list[index]['Model Name']);
                            ModifyCustomerScreen.variantName.setText(list[index]['Variant Name']);
                            ModifyCustomerScreen.color.setText(list[index]['Model Color']);
                            ModifyCustomerScreen.customerStatus = list[index]['Customer Status'];
                            ModifyCustomerScreen.paymentType = list[index]['Payment Type'];
                            ModifyCustomerScreen.followUpDate = list[index]['Follow Up Date'];
                            ModifyCustomerScreen.remark1.setText(list[index]['Remark 1']);
                            ModifyCustomerScreen.remark2.setText(list[index]['Remark 2']);
                            Navigator.push(context,MaterialPageRoute(builder: (context) => const ModifyCustomerScreen()));
                          },
                        ),
                      // ignore: dead_code
                      ) : const SizedBox();
                    }
                  );
                }
              }
            )
          )
        ],
      )
    );
  }
}