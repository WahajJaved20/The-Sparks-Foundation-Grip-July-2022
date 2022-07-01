// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:banking_app/Database/Database.dart';
import 'package:banking_app/model/transaction.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late List<TransactionList> transactions;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future refreshList() async {
    setState(() {
      isLoading = true;
    });
    transactions = await CustomerDatabase.instance.readAllTransactions();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 7, 255),
          elevation: 3,
          title: Text("Transactions"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Customers"))
          ],
        ),
        body: Center(
            child: isLoading ? CircularProgressIndicator() : buildList()),
      ),
    );
  }

  Widget buildList() {
    refreshList();
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Column(children: [
          Card(
            color: Color.fromARGB(96, 10, 21, 175),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.height * 0.05,
              ),
              child: Text(
                "Sender ID: ${transaction.id}\n${transaction.value}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Divider()
        ]);
      },
    );
  }
}
