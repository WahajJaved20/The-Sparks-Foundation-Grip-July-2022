// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:banking_app/Database/Database.dart';
import 'package:banking_app/model/customer.dart';
import 'package:banking_app/model/transaction.dart';
import 'package:flutter/material.dart';

class Transfer extends StatefulWidget {
  Transfer(this.customer);
  final Customer customer;
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _toMoneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Material(child: CircularProgressIndicator())
        : Material(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02),
              color: Color.fromARGB(96, 10, 21, 175),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Name: ${widget.customer.customerName}",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      "Enter the customer ID to send money to:",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      child: TextFormField(
                          controller: _toMoneyController,
                          keyboardType: TextInputType.number),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "Enter the amount of money:",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      child: TextFormField(
                          controller: _moneyController,
                          keyboardType: TextInputType.number),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (int.parse(_moneyController.text) <=
                              widget.customer.moneyValue) {
                            final cus = widget.customer.copy(
                                id: widget.customer.id,
                                cName: widget.customer.customerName,
                                money: widget.customer.moneyValue -
                                    int.parse(_moneyController.text));
                            await CustomerDatabase.instance.update(cus);
                            Customer cuss = await CustomerDatabase.instance
                                .readData(int.parse(_toMoneyController.text));
                            cuss = cuss.copy(
                                id: cuss.id,
                                cName: cuss.customerName,
                                money: cuss.moneyValue +
                                    int.parse(_moneyController.text));
                            await CustomerDatabase.instance.update(cuss);
                            TransactionList t = TransactionList(
                                value:
                                    "${cus.customerName} transferred ${_moneyController.text} to ${cuss.customerName}");
                            await CustomerDatabase.instance
                                .insertTransaction(t);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Transfer",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
