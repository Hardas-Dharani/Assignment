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

  List<TransactionModel> _searchResult = [];
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    Provider.of<TransactionProvider?>(context)!
        .transactionModel!
        .forEach((transdetail) {
      if (transdetail!.description!.contains(text))
        _searchResult.add(transdetail);
    });

    setState(() {});
  }

  TextEditingController controller = new TextEditingController();
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
                new Container(
                  color: Theme.of(context).primaryColor,
                  child: new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Card(
                      child: new ListTile(
                        leading: new Icon(Icons.search),
                        title: new TextField(
                          controller: controller,
                          decoration: new InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: onSearchTextChanged,
                        ),
                        trailing: new IconButton(
                          icon: new Icon(Icons.cancel),
                          onPressed: () {
                            controller.clear();
                            onSearchTextChanged('');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: _searchResult.length != 0 ||
                            controller.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: _searchResult.length,
                            itemBuilder: (context, index) {
                              String? date =
                                  _searchResult[index].date.toString();
                              String? amount =
                                  _searchResult[index].amount.toString();
                              String? type = _searchResult[index]
                                  .type
                                  .toString()
                                  .toUpperCase();
                              String? currency =
                                  _searchResult[index].currencyCode.toString();
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                                transactionModel:
                                                    _searchResult[index],
                                              )),
                                    );
                                  },
                                  title: Text(amount),
                                  leading: Text(date),
                                  trailing: Text(type),
                                  subtitle: Text(currency),
                                ),
                              );
                            })
                        : ListView.builder(
                            itemCount: myModel.transactionModel!.length,
                            itemBuilder: (context, index) {
                              String? date = myModel
                                  .transactionModel![index]!.date
                                  .toString();
                              String? amount = myModel
                                  .transactionModel![index]!.amount
                                  .toString();
                              String? type = myModel
                                  .transactionModel![index]!.type
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
