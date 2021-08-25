import 'package:assignment/Model/transModel.dart';
import 'package:assignment/Provider/transprovider.dart';
import 'package:assignment/view/secondscreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<TransactionProvider?>(context, listen: false)!.getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<TransactionProvider>(builder: (_, myModel, child) {
        return ModalProgressHUD(
          inAsyncCall: myModel.loading,
          progressIndicator: CircularProgressIndicator(),
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: myModel.transactionModel!.length,
                        itemBuilder: (context, index) {
                          String? date =
                              myModel.transactionModel![index]!.date.toString();
                          String? amount = myModel
                              .transactionModel![index]!.amount
                              .toString();
                          String? type = myModel.transactionModel![index]!.type
                              .toString()
                              .toUpperCase();
                          String? currency = myModel
                              .transactionModel![index]!.currencyCode
                              .toString();
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            transactionModel: myModel
                                                .transactionModel![index],
                                          )),
                                );
                              },
                              title: Text(amount),
                              leading: Text(date),
                              trailing: Text(type),
                              subtitle: Text(currency),
                            ),
                          );
                        }))
              ],
            ),
          ),
        );
      }),
    );
  }
}
