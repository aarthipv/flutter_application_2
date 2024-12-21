import 'package:flutter/material.dart';

class DelivererPage extends StatefulWidget {
  @override
  _DelivererPageState createState() => _DelivererPageState();
}

class _DelivererPageState extends State<DelivererPage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 1,
      'destination': 'Apex Block, AB507',
      'totalPrice': 200,
      'user': 'Riya',
      'phone': '1234567891',
      'status': 'Accept Request',
      'items': [
        {'name': 'Masala Dosa', 'quantity': 2, 'source': 'ESB Canteen'},
        {'name': 'Bluebooks', 'quantity': 3, 'source': 'MSRIT Stationary'},
      ],
    },
    {
      'orderId': 2,
      'destination': 'Architecture Block, Lecture Hall 1',
      'totalPrice': 150,
      'user': 'Dhruv',
      'phone': '1234567892',
      'status': 'Accept Request',
      'items': [
        {'name': 'Idli', 'quantity': 4, 'source': 'ESB Canteen'},
        {'name': 'Pens', 'quantity': 5, 'source': 'MSRIT Stationary'},
      ],
    },
    {
      'orderId': 3,
      'destination': 'LHC 203',
      'totalPrice': 300,
      'user': 'Aditya',
      'phone': '1234567893',
      'status': 'Accept Request',
      'items': [
        {'name': 'Vada', 'quantity': 6, 'source': 'ESB Canteen'},
        {'name': 'Notebooks', 'quantity': 2, 'source': 'MSRIT Stationary'},
      ],
    },
    {
      'orderId': 4,
      'destination': 'DES CSE Lab 2',
      'totalPrice': 250,
      'user': 'Dinesh',
      'phone': '1234567894',
      'status': 'Accept Request',
      'items': [
        {'name': 'Samosa', 'quantity': 3, 'source': 'ESB Canteen'},
        {'name': 'Markers', 'quantity': 4, 'source': 'MSRIT Stationary'},
      ],
    },
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0.3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateStatus(int index) {
    setState(() {
      if (orders[index]['status'] == 'Accept Request') {
        orders[index]['status'] = 'Ongoing';
      } else if (orders[index]['status'] == 'Ongoing') {
        orders[index]['status'] = 'Completed';
      }
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Accept Request':
        return const Color.fromARGB(255, 202, 25, 12);
      case 'Ongoing':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stud Mode'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destination: ${orders[index]['destination']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Total Price: ₹${orders[index]['totalPrice']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...orders[index]['items'].map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '${item['name']} x ${item['quantity']} from ${item['source']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 8),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        orders[index]['status'] == 'Completed'
                            ? Icons.check_circle
                            : Icons.pending,
                        color: getStatusColor(orders[index]['status']),
                      ),
                      title: Text(
                        'User: ${orders[index]['user']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'Phone: ${orders[index]['phone']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      trailing: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: orders[index]['status'] == 'Accept Request'
                                    ? _animation.value > 0.5
                                        ? Colors.red
                                        : Colors.red.withOpacity(0.5)
                                    : getStatusColor(orders[index]['status']),
                                width: 2.0, // Increase the border thickness
                              ),
                            ),
                            onPressed: () => updateStatus(index),
                            child: Text(
                              orders[index]['status'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}