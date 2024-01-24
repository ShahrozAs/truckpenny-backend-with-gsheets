import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateBottomSheet extends StatefulWidget {
  const CreateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

final databaseRef = FirebaseDatabase.instance.ref('Amount');
final databaseTotalAmountRef = FirebaseDatabase.instance.ref('TotalAmount');
final databaseIncomeAmountRef = FirebaseDatabase.instance.ref('IncomeAmount');
final databaseExpenseAmountRef = FirebaseDatabase.instance.ref('ExpenseAmount');

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  String vehicleDetail = "";
  String weight = "";
  String rate = "";
  String received = "0";
  String bN = "";
  double amount = 0;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  Future<void> fetchData() async {
    try {
      print("=========================================FETCH TOTAL INCOME");

      final event = await databaseTotalAmountRef.once();
      final snapshot = event.snapshot; // Access the snapshot from the event
      final amountMap = snapshot.value as Map<dynamic, dynamic>;
      // Map<dynamic, dynamic> amountMap = event.value;

      if (amountMap != null) {
        // Assuming totalAmount is a child key of TotalAmount
        dynamic totalAmountData = amountMap['totalAmount'];
        if (totalAmountData != null) {
          print("========================$totalAmountData");

          final result = (totalAmountData + amount) - double.parse(received);

          await databaseTotalAmountRef.update({
            "totalAmount": result,
          });
        } else {
          print("Key 'totalAmount' not found under TotalAmount");
        }
      } else {
        print("Key 'TotalAmount' not found in the database");
      }
    } catch (error) {
      await databaseTotalAmountRef.set({
        "totalAmount": amount,
      });
      print("Error fetching data: $error");
    }
  }

  Future<void> fetchIcome() async {
    try {
      print("=========================================FETCH INCOME");
      final event = await databaseIncomeAmountRef.once();
      final snapshot = event.snapshot; // Access the snapshot from the event
      final amountMap = snapshot.value as Map<dynamic, dynamic>;
      // Map<dynamic, dynamic> amountMap = event.value;

      if (amountMap != null) {
        // Assuming totalAmount is a child key of TotalAmount
        dynamic totalAmountData = amountMap['incomeAmount'];
        if (totalAmountData != null) {
          print("========================$totalAmountData");

          final result = (totalAmountData + amount);

          await databaseIncomeAmountRef.update({
            "incomeAmount": result,
          });
        } else {
          print("Key 'incomeAmount' not found under TotalAmount");
        }
      } else {
        print("Key 'incomeAmount' not found in the database");
      }
    } catch (error) {
      await databaseIncomeAmountRef.set({
        "incomeAmount": amount,
      });
      print("Error fetching data: $error");
    }
  }

  Future<void> fetchExpence() async {
    try {
      print("=========================================FETCH EXPENCE");
      final event = await databaseExpenseAmountRef.once();
      final snapshot = event.snapshot; // Access the snapshot from the event
      final amountMap = snapshot.value as Map<dynamic, dynamic>;
      // Map<dynamic, dynamic> amountMap = event.value;

      if (amountMap != null) {
        // Assuming totalAmount is a child key of TotalAmount
        dynamic totalAmountData = amountMap['expenseAmount'];
        if (totalAmountData != null) {
          print("========================$totalAmountData");

          final result =totalAmountData +double.parse(received);

          await databaseExpenseAmountRef.update({
            "expenseAmount": result,
          });
        } else {
          print("Key 'expenseAmount' not found under TotalAmount");
        }
      } else {
        print("Key 'expenseAmount' not found in the database");
      }
    } catch (error) {
      final updateReceive=double.parse(received);
      await databaseExpenseAmountRef.set({
        "expenseAmount": updateReceive,
      });
      print("Error fetching data: $error");
    }
  }

  // Future<void> fetchData() async {
  //   try {
  //     final event = await databaseTotalAmountRef.once();
  //     final snapshot = event.snapshot; // Access the snapshot from the event
  //     final amountMap = snapshot.value as Map<dynamic, dynamic>;

  //     // ... rest of your code
  //     print("=======================================$amountMap");
  //   } catch (error) {
  //     // ...
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[200],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 3.0,
                      width: 35,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    initialValue: vehicleDetail,
                    decoration: InputDecoration(labelText: 'Vehicle Detail'),
                    onChanged: (value) => setState(() => vehicleDetail = value),
                  ),
                  TextFormField(
                    initialValue: weight,
                    decoration: InputDecoration(labelText: 'Weight'),
                    onChanged: (value) => setState(() => weight = value),
                  ),
                  TextFormField(
                    initialValue: rate,
                    decoration: InputDecoration(labelText: 'Rate'),
                    onChanged: (value) => setState(() => rate = value),
                  ),

                  TextFormField(
                    initialValue: received,
                    decoration: InputDecoration(labelText: 'Received'),
                    onChanged: (value) => setState(() => received = value),
                    // Allow multiple lines for received
                  ),

                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: Icon(Icons.calendar_today)),
                    controller: TextEditingController(
                        text: selectedDate != null
                            ? selectedDate.toString().substring(0, 10)
                            : ''),
                  ),
                  // bN selection
                  Row(
                    children: [
                      Text('B/N:'),
                      SizedBox(width: 10),
                      // Radio buttons for common options
                      Row(
                        children: [
                          Radio<String>(
                            value: 'B',
                            groupValue: bN,
                            onChanged: (value) => setState(() => bN = value!),
                          ),
                          Text('B'),
                          SizedBox(width: 10),
                          Radio<String>(
                            value: 'N',
                            groupValue: bN,
                            onChanged: (value) => setState(() => bN = value!),
                          ),
                          Text('N'),
                        ],
                      ),
                      // Additional option for custom bN
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        amount = double.parse(weight) * double.parse(rate);
                        await databaseRef
                            .child(DateTime.now()
                                .microsecondsSinceEpoch
                                .toString())
                            .set(
                          {
                            'vehicleDetails': vehicleDetail,
                            'weight': weight,
                            'rate': rate,
                            'amount': amount,
                            'received': received,
                            'date':
                                DateFormat('dd-MM-yyyy').format(selectedDate!),
                            'BN': bN
                          },
                        );
                        fetchData();
                        fetchIcome();
                        fetchExpence();

                        // await databaseTotalAmountRef.set({
                        //   'totalAmount': amount,
                        // });
                        print("Data stored successfully!");
                        Navigator.pop(context);
                      } catch (error) {
                        print(
                            "Error storing data:==================================== $error");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
