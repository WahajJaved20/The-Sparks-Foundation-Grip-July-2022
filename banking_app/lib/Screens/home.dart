// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:banking_app/Database/Database.dart';
import 'package:banking_app/Screens/customerDetails.dart';
import 'package:banking_app/Screens/transactions.dart';
import 'package:banking_app/model/customer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Customer> customers;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshList();
  }

  @override
  void dispose() {
    CustomerDatabase.instance.close();
    super.dispose();
  }

  Future refreshList() async {
    setState(() {
      isLoading = true;
    });
    customers = await CustomerDatabase.instance.readAllData();
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
          title: Text("List of Customers"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Transactions()),
                  );
                },
                child: Text("View Transactions"))
          ],
        ),
        body: Container(
          child: Center(
              child: isLoading ? CircularProgressIndicator() : buildList()),
        ),
      ),
    );
  }

  Widget buildList() {
    refreshList();
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final customer = customers[index];
        return Container(
          child: CustomerDetails(customer, index),
        );
      },
    );
  }
}
