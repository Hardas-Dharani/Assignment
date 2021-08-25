import 'package:fluttertoast/fluttertoast.dart';

class Config {
  static String baseurl = '60e29b749103bd0017b4743f.mockapi.io';
  static String transactions = '/api/v1/transactions';

  messagefuncation(String messages) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 1,
      msg: messages,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}
