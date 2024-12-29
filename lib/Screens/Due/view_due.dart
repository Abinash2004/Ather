import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:show_room/Screens/Due/due_details.dart';
import 'package:show_room/Screens/Due/modify_due.dart';
import 'package:show_room/elements/widgets.dart';

class ViewDueScreen extends StatefulWidget {
  const ViewDueScreen({super.key});

  @override
  State<ViewDueScreen> createState() => _ViewDueScreenState();
}

class _ViewDueScreenState extends State<ViewDueScreen> {

  String? month = "All";
  List<String> monthList = ["All", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  String? status = "All";
  List<String> statusList = ["All", "Pending", "Paid"];

  @override
  Widget build(BuildContext context) {
    final databaseRef = FirebaseDatabase.instance.ref('Due');
    return Scaffold(
      backgroundColor: Color(0xff0b090a),
      
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.white60,height: 0.25)),
        
        title: Text("Due List", style: TextStyle(
          color: Colors.white60,
          fontSize: 25,
          fontWeight: FontWeight.w600
        )),
        
        backgroundColor: Color(0xff0b090a),
        automaticallyImplyLeading: false,
        
        actions: [
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          SizedBox(width: 20),
          
          appBarInputContainer(DropdownButton<String>(
            dropdownColor: Color.fromARGB(255, 30, 30, 30),
            value: status,
            items: statusList.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: textStyle()),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {status = newValue;});
            },
          )),
            ],
          ),
          SizedBox(height: 20),

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
                      bool isExist = false;
                      if(month == "All" && status == "All") {
                        isExist = true;
                      } else if(status == "All" && month == DateFormat.MMM().format(DateFormat("dd / MM / yyyy").parse(list[index]['Date']))) {
                        isExist = true;
                      } else if(status == list[index]['Due Status'] && month == "All") {
                        isExist = true;
                      } else if(status == list[index]['Due Status'] && month == DateFormat.MMM().format(DateFormat("dd / MM / yyyy").parse(list[index]['Date']))) {
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
                          
                          title: customerListTitle('${list[index]['Customer Name']} - ${list[index]['Phone Number']}'),
                          subtitle: customerListSubTitle('Initial Due - ${list[index]['Date']} - ${list[index]['Due Status']}'),

                          onTap: () {
                            DueDetailsScreen.serialNumber = list[index]['Serial Number'];
                            DueDetailsScreen.dueDate = list[index]['Date'];
                            DueDetailsScreen.name = list[index]['Customer Name'];
                            DueDetailsScreen.phone = list[index]['Phone Number'];
                            DueDetailsScreen.totalDue = list[index]['Total Due'];
                            DueDetailsScreen.remainingDue = list[index]['Remaining Due'];
                            DueDetailsScreen.dueStatus = list[index]['Due Status'];
                            DueDetailsScreen.paidAmount1 = list[index]['Paid Amount 1'];
                            DueDetailsScreen.paidDate1 = list[index]['Paid Date 1'];
                            DueDetailsScreen.paidAmount2 = list[index]['Paid Amount 2'];
                            DueDetailsScreen.paidDate2 = list[index]['Paid Date 2'];
                            DueDetailsScreen.paidAmount3 = list[index]['Paid Amount 3'];
                            DueDetailsScreen.paidDate3 = list[index]['Paid Date 3'];
                            DueDetailsScreen.paidAmount4 = list[index]['Paid Amount 4'];
                            DueDetailsScreen.paidDate4 = list[index]['Paid Date 4'];
                            DueDetailsScreen.paidAmount5 = list[index]['Paid Amount 5'];
                            DueDetailsScreen.paidDate5 = list[index]['Paid Date 5'];
                            Navigator.push(context,MaterialPageRoute(builder: (context) => const DueDetailsScreen()));
                          },

                          onLongPress: () {
                            ModifyDueScreen.serialNumber = list[index]['Serial Number'];
                            ModifyDueScreen.name.setText(list[index]['Customer Name']);
                            ModifyDueScreen.dueDate = list[index]['Date'];
                            ModifyDueScreen.phone.setText(list[index]['Phone Number']);
                            ModifyDueScreen.totalDue.setText(list[index]['Total Due']);
                            ModifyDueScreen.remainingDue = list[index]['Remaining Due'];
                            ModifyDueScreen.dueStatus = list[index]['Due Status'];
                            ModifyDueScreen.paidAmount1.setText(list[index]['Paid Amount 1']);
                            ModifyDueScreen.paidDate1 = list[index]['Paid Date 1'];
                            ModifyDueScreen.paidAmount2.setText(list[index]['Paid Amount 3']);
                            ModifyDueScreen.paidDate2 = list[index]['Paid Date 2'];
                            ModifyDueScreen.paidAmount3.setText(list[index]['Paid Amount 3']);
                            ModifyDueScreen.paidDate3 = list[index]['Paid Date 3'];
                            ModifyDueScreen.paidAmount4.setText(list[index]['Paid Amount 4']);
                            ModifyDueScreen.paidDate4 = list[index]['Paid Date 4'];
                            ModifyDueScreen.paidAmount5.setText(list[index]['Paid Amount 5']);
                            ModifyDueScreen.paidDate5 = list[index]['Paid Date 5'];

                            Navigator.push(context,MaterialPageRoute(builder: (context) => const ModifyDueScreen()));
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