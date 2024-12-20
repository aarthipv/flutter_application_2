import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/RegistrationPage.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/Splash.dart';
import 'package:flutter_application_2/orderer.dart';
import 'package:flutter_application_2/canteens.dart';
import 'package:flutter_application_2/xerox.dart';
import 'package:flutter_application_2/stationary.dart';
import 'package:flutter_application_2/main.dart';
// Deliverer Page
class DelivererPage extends StatefulWidget {
  @override
  _DelivererPageState createState() => _DelivererPageState();
}

class _DelivererPageState extends State<DelivererPage> {
  final List<Map<String, dynamic>> orders = List.generate(
    5,
    (index) => {
      'orderId': index + 1,
      'name': 'Order ${index + 1}',
      'isDelivered': false,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  orders[index]['isDelivered']
                      ? Icons.check_circle
                      : Icons.pending,
                  color: orders[index]['isDelivered']
                      ? Colors.green
                      : Colors.orange,
                ),
                title: Text(orders[index]['name']),
                trailing: Checkbox(
                  value: orders[index]['isDelivered'],
                  onChanged: (value) {
                    setState(() {
                      orders[index]['isDelivered'] = value!;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}