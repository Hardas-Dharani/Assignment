import 'package:intl/intl.dart';

class TransactionModel {
  String? date;
  String? amount;
  String? type;
  String? currencyCode;
  String? iban;
  String? description;
  String? bic;
  String? id;

  TransactionModel(
      {this.date,
      this.amount,
      this.type,
      this.currencyCode,
      this.iban,
      this.description,
      this.bic,
      this.id});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['date']);

    date = DateFormat('dd-MMMM-yyyy').format(dateTime);
    amount = json['amount'];
    type = json['type'];
    currencyCode = json['currencyCode'];
    iban = json['iban'];
    description = json['description'];
    bic = json['bic'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['currencyCode'] = this.currencyCode;
    data['iban'] = this.iban;
    data['description'] = this.description;
    data['bic'] = this.bic;
    data['id'] = this.id;
    return data;
  }
}
