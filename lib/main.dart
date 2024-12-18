import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudVery',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Text(
            "StudVery",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Login Page
class LoginPage extends StatelessWidget {
  final TextEditingController usnController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usnController,
                decoration: InputDecoration(labelText: 'USN'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainAppPage()),
                  );
                },
                child: Text('Login'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Text('Register Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Registration Page
class RegistrationPage extends StatelessWidget {
  final TextEditingController usnController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  String selectedGender = 'Male';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: usnController,
                decoration: InputDecoration(labelText: 'USN'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: branchController,
                decoration: InputDecoration(labelText: 'Branch'),
              ),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              DropdownButton<String>(
                value: selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          child: Text(gender),
                          value: gender,
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedGender = value!;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                      'Date of Birth: ${selectedDate.toLocal()}'.split(' ')[0]),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        selectedDate = pickedDate;
                      }
                    },
                    child: Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main Application Page with Toggle Feature
class MainAppPage extends StatefulWidget {
  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  bool isOrderer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudVery'),
        actions: [
          Switch(
            value: isOrderer,
            onChanged: (value) {
              setState(() {
                isOrderer = value;
              });
            },
          ),
        ],
      ),
      body: isOrderer ? OrdererPage() : DelivererPage(),
    );
  }
}

// Orderer Page
class OrdererPage extends StatelessWidget {
  final List<String> options = [
    'ESB Canteen',
    'Multipurpose Canteen',
    'Law Canteen',
    'Stationery',
    'Xerox'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(options[index]),
          leading: Icon(Icons.fastfood),
          onTap: () {
            // Handle navigation or functionality here
          },
        );
      },
    );
  }
}

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
