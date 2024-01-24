import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TopNeuCard extends StatefulWidget {
  TopNeuCard({Key? key}) : super(key: key);

  @override
  State<TopNeuCard> createState() => _TopNeuCardState();
}

class _TopNeuCardState extends State<TopNeuCard> {
  final databaseTotalAmountRef =
      FirebaseDatabase.instance.ref('TotalAmount').child('totalAmount');
  final databaseIncomeAmountRef =
      FirebaseDatabase.instance.ref('IncomeAmount').child('incomeAmount');
  final databaseExpenseAmountRef =
      FirebaseDatabase.instance.ref('ExpenseAmount').child('expenseAmount');

  String balance = "0";
  String income = "0";
  String expense = "0";

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    fetchData();

    // Set up listeners for real-time updates
    databaseTotalAmountRef.onValue.listen((event) {
      setState(() {
        balance = event.snapshot.value.toString();
      });
    });

    databaseIncomeAmountRef.onValue.listen((event) {
      setState(() {
        income = event.snapshot.value.toString();
      });
    });

    databaseExpenseAmountRef.onValue.listen((event) {
      setState(() {
        expense = event.snapshot.value.toString();
      });
    });
  }

  Future<void> fetchData() async {
    // Fetch initial data
    final totalAmountSnapshot = await databaseTotalAmountRef.once();
    final incomeAmountSnapshot = await databaseIncomeAmountRef.once();
    final expenseAmountSnapshot = await databaseExpenseAmountRef.once();

    setState(() {
      balance = totalAmountSnapshot.snapshot.value.toString();
      income = incomeAmountSnapshot.snapshot.value.toString();
      expense = expenseAmountSnapshot.snapshot.value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("=================================== ${balance}");

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('B A L A N C E',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16)),
              Text(
                '\$ ${balance}',
                style: TextStyle(color: Colors.grey[800], fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Income',
                                style: TextStyle(color: Colors.grey[500])),
                            SizedBox(
                              height: 5,
                            ),
                            Text('\$ ${income}',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expense',
                                style: TextStyle(color: Colors.grey[500])),
                            SizedBox(
                              height: 5,
                            ),
                            Text('\$ ${expense}',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]),
      ),
    );
  }
}
