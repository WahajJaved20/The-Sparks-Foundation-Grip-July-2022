// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names, prefer_const_constructors

import 'package:banking_app/Screens/transferScreen.dart';
import 'package:banking_app/model/customer.dart';
import 'package:flutter/material.dart';

class CustomerDetails extends StatelessWidget {
  CustomerDetails(this.customer, this.index);
  Customer customer;
  int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(96, 10, 21, 175),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Name: ${customer.customerName}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "ID: ${customer.id.toString()}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "Money Amount: ${customer.moneyValue}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Transfer(customer)),
                );
              },
              child: Text(
                "Transfer Money",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
