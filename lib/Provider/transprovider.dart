import 'package:assignment/Model/transModel.dart';
import 'package:assignment/Request/apirequest.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel?>? transactionModel = [];
  bool loading = false;

  getPostData() async {
    try {
      loading = true;
      transactionModel = await Transaction().helpRequest();
      loading = false;
    } catch (e) {
      loading = false;
    }

    notifyListeners();
  }
}
