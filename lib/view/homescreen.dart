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

  TextEditingController controller = new TextEditingController();
  List<TransactionModel?>? _searchResult = [];
  onSearchTextChanged(String text) async {
    _searchResult!.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    var string=Provider.of<TransactionProvider?>(context,listen: false)!
        .transactionModel!
        .forEach((transdetail) {
      if (transdetail!.description!.contains(text))
        _searchResult!.add(transdetail);
    });

    setState(() {});
  }
  Widget listViewShow(List<TransactionModel?>? listModel){
    return ListView.builder(
                            itemCount: listModel!.length,
                            itemBuilder: (context, index) {
                              String? date =
                                  listModel[index]!.date.toString();
                              String? amount =
                                  listModel[index]!.amount.toString();
                              String? type = listModel[index]!
                                  .type
                                  .toString()
                                  .toUpperCase();
                              String? currency =
                                  listModel[index]!.currencyCode.toString();
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                                transactionModel:
                                                    listModel[index],
                                              )),
                                    );
                                  },
                                  title: Text(amount),
                                  leading: Text(date),
                                  trailing: Text(type),
                                  subtitle: Text(currency),
                                ),
                              );
                            });
                        
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
                SizedBox(height: 35),
                 Container(
                  color: Theme.of(context).primaryColor,
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Card(
                      child:  ListTile(
                        leading:  Icon(Icons.search),
                        title:  TextField(
                          controller: controller,
                          decoration:  InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: onSearchTextChanged,
                        ),
                        trailing:  IconButton(
                          icon:  Icon(Icons.cancel),
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
                    child: _searchResult!.length != 0 ||
                            controller.text.isNotEmpty
                        ? listViewShow(_searchResult)
                        :listViewShow( myModel.transactionModel) )
              ],
            ),
          ),
        );
      }),
    );
  }
}
