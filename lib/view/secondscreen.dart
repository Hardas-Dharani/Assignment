import 'dart:ui';

import 'package:assignment/Model/transModel.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final TransactionModel? transactionModel;
  DetailPage({Key? key, this.transactionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            height: 300,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 130),
                      child: Text(
                        "Transaction Detail",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(transactionModel!.description.toString()),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                          "Amount : ${transactionModel!.amount.toString()}"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child:
                          Text("Date : ${transactionModel!.date.toString()}"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                          "Curency : ${transactionModel!.currencyCode.toString()}"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child:
                          Text("IBAN : ${transactionModel!.iban.toString()}"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Type : ${transactionModel!.type.toString()}",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text("BIC : ${transactionModel!.bic.toString()}"),
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
}
