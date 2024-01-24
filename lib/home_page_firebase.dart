import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:truckpenny/create_bottomSheet.dart';
import 'google_sheets_api.dart';
import 'loading_circle.dart';
import 'plus_button.dart';
import 'top_card.dart';
import 'transaction.dart';

class HomePageFirebase extends StatefulWidget {
  const HomePageFirebase({Key? key}) : super(key: key);

  @override
  _HomePageFirebaseState createState() => _HomePageFirebaseState();
}

class _HomePageFirebaseState extends State<HomePageFirebase> {
  final databaseRef = FirebaseDatabase.instance.ref('Amount');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TopNeuCard(),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Date'),
                          Text('Vehicle Details'),
                          Text('Weight'),
                          Text('Rate'),
                          Text('Amount'),
                          Text('B/N'),
                          Text('Received'),
                        ],
                      ),
                      Expanded(
                          child: FirebaseAnimatedList(
                        query: databaseRef,
                        itemBuilder: (context, snapshot, animation, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(snapshot.child('date').value.toString()),
                                  Text(snapshot
                                      .child('vehicleDetails')
                                      .value
                                      .toString()),
                                  Text(snapshot
                                      .child('weight')
                                      .value
                                      .toString()),
                                  Text(snapshot.child('rate').value.toString()),
                                  Text(snapshot
                                      .child('amount')
                                      .value
                                      .toString()),
                                  Text(snapshot.child('BN').value.toString()),
                                  Text(snapshot
                                      .child('received')
                                      .value
                                      .toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                      // Expanded(
                      //   child: Container(
                      //     child: Center(
                      //       child: Column(
                      //         children: [
                      //           SizedBox(
                      //             height: 20,
                      //           ),
                      //           Expanded(
                      //             child: GoogleSheetsApi.loading == true
                      //                 ? LoadingCircle()
                      //                 : ListView.builder(
                      //                     itemCount:
                      //                         GoogleSheetsApi.currentTransactions.length,
                      //                     itemBuilder: (context, index) {
                      //                       return MyTransaction(
                      //                         transactionName: GoogleSheetsApi
                      //                             .currentTransactions[index][0],
                      //                         money: GoogleSheetsApi
                      //                             .currentTransactions[index][1],
                      //                         expenseOrIncome: GoogleSheetsApi
                      //                             .currentTransactions[index][2],
                      //                       );
                      //                     }),
                      //           )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBottomSheet(),
                    ));
              },
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
