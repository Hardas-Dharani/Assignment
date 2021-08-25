import 'dart:convert';
import 'dart:io';

import 'package:assignment/Const/constant.dart';
import 'package:assignment/Model/transModel.dart';
import 'package:dio/dio.dart';

class Transaction {
  Future<List<TransactionModel>> helpRequest() async {
    List<TransactionModel> trans = [];
    var url = Uri.https(Config.baseurl, Config.transactions);
    try {
      var response = await Dio().get(url.toString());
      if (response.statusCode == 200) {
        for (var item in response.data) {
          trans.add(TransactionModel.fromJson(item));
        }
      }
    } on SocketException catch (e) {
      Config().messagefuncation(e.message.toString());
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      Config().messagefuncation("Unable to process the data");
      throw FormatException("Unable to process the data");
    } catch (e) {
      Config().messagefuncation(e.toString());
      throw e;
    }
    return trans;
  }
}
