import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/RegistrationPage.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/Splash.dart';
import 'package:flutter_application_2/orderer.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/xerox.dart';
import 'package:flutter_application_2/delivery.dart';
import 'package:flutter_application_2/stationary.dart';
class ESBCanteenPage extends StatefulWidget {
  @override
  _ESBCanteenPageState createState() => _ESBCanteenPageState();
}

class _ESBCanteenPageState extends State<ESBCanteenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> items = [
    {'name': 'Idli Vada', 'price': 45, 'image': 'assets/idli_vada.jpg'},
    {'name': 'Vada', 'price': 20, 'image': 'assets/vada.jpg'},
    {'name': 'Masala Dosa', 'price': 45, 'image': 'assets/masala_dosa.jpg'},
    {'name': 'Set Dosa', 'price': 45, 'image': 'assets/set_dosa.jpg'},
    {
      'name': 'Chapathi Meals',
      'price': 50,
      'image': 'assets/chapathi_meals.jpg'
    },
    {'name': 'Orange Juice', 'price': 30, 'image': 'assets/orange_juice.jpg'},
    {
      'name': 'Moosambi Juice',
      'price': 30,
      'image': 'assets/moosambi_juice.jpg'
    },
    {
      'name': 'Oreo Milkshake',
      'price': 50,
      'image': 'assets/oreo_milkshake.jpg'
    },
    {'name': 'Water Bottle', 'price': 20, 'image': 'assets/water_bottle.jpg'},
    {
      'name': 'Watermelon Juice',
      'price': 40,
      'image': 'assets/watermelon_juice.jpg'
    },
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESB Canteen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to ESB Canteen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              items[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            items[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${items[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  quantities[index] =
                                      (quantities[index] ?? 1) - 1;
                                  if (quantities[index]! <= 0) {
                                    quantities[index] = 0;
                                  }
                                });
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  quantities[index] =
                                      (quantities[index] ?? 0) + 1;

                                  // Add item to cart
                                  final item = CartItem(
                                    name: items[index]['name'],
                                    price: items[index]['price'],
                                    quantity: 1,
                                  );
                                  cartState.addItem(item);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('${item.name} added to cart'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class MultipurposeCanteenPage extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {'title': 'South Mess', 'icon': Icons.local_dining},
    {'title': 'North Mess', 'icon': Icons.local_dining},
    {'title': 'Bakery', 'icon': Icons.cake},
    {'title': 'Cafe De Costa', 'icon': Icons.local_cafe},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multipurpose Canteen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the respective page
                if (options[index]['title'] == 'South Mess') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SouthMessPage()),
                  );
                } else if (options[index]['title'] == 'North Mess') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NorthMessPage()),
                  );
                } else if (options[index]['title'] == 'Bakery') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BakeryPage()),
                  );
                } else if (options[index]['title'] == 'Cafe De Costa') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CafeDeCostaPage()),
                  );
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: Colors.purple[50],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        options[index]['icon'],
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(height: 10),
                      Text(
                        options[index]['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//Pages for locations

class SouthMessPage extends StatefulWidget {
  @override
  _SouthMessPageState createState() => _SouthMessPageState();
}

class _SouthMessPageState extends State<SouthMessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Idli Vada', 'price': 45, 'image': 'assets/idli_vada.jpg'},
    {'name': 'Vada', 'price': 20, 'image': 'assets/vada.jpg'},
    {'name': 'Masala Dosa', 'price': 45, 'image': 'assets/masala_dosa.jpg'},
    {'name': 'Set Dosa', 'price': 45, 'image': 'assets/set_dosa.jpg'},
    {
      'name': 'Chapathi Meals',
      'price': 50,
      'image': 'assets/chapathi_meals.jpg'
    },
    {'name': 'Coffee', 'price': 12, 'image': 'assets/coffee.jpg'},
    {'name': 'Tea', 'price': 12, 'image': 'assets/tea.jpg'},
    {'name': 'Limca', 'price': 50, 'image': 'assets/limca.jpg'},
    {'name': 'Water Bottle', 'price': 20, 'image': 'assets/water_bottle.jpg'},
    {'name': 'Munch', 'price': 20, 'image': 'assets/munch.jpg'},
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('South Mess'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to South Mess',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(index, false);
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(index, true);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

//North Mess page
class NorthMessPage extends StatefulWidget {
  @override
  _NorthMessPageState createState() => _NorthMessPageState();
}

class _NorthMessPageState extends State<NorthMessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // List of items with images, names, and prices
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Kulcha Curry', 'price': 75, 'image': 'assets/kulcha_curry.jpg'},
    {'name': 'Roti Curry', 'price': 70, 'image': 'assets/roti_curry.jpg'},
    {'name': 'Gobi Paratha', 'price': 80, 'image': 'assets/gobi_parata.jpg'},
    {'name': 'Noodles', 'price': 80, 'image': 'assets/noodles.jpg'},
    {'name': 'Gobi Noodles', 'price': 80, 'image': 'assets/gobi_noodles.jpg'},
    {'name': 'North Meals', 'price': 90, 'image': 'assets/north_meals.jpg'},
    {'name': 'Soya Roll', 'price': 50, 'image': 'assets/soya_roll.jpg'},
    {'name': 'Paneer Roll', 'price': 60, 'image': 'assets/paneer_roll.jpg'},
  ];

  // Quantity tracker
  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to update quantity of the item
  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('North Mess'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Welcome text with slide animation
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to North Mess',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, false); // Decrease quantity
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, true); // Increase quantity
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class BakeryPage extends StatefulWidget {
  @override
  _BakeryPageState createState() => _BakeryPageState();
}

class _BakeryPageState extends State<BakeryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // List of items with images, names, and prices
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Paneer Sandwich',
      'price': 40,
      'image': 'assets/paneer_sandwich.jpg'
    },
    {'name': 'Samosa', 'price': 30, 'image': 'assets/samosa.jpg'},
    {'name': 'Cold coffee', 'price': 35, 'image': 'assets/cold_coffee.jpg'},
    {'name': 'Donut', 'price': 25, 'image': 'assets/donut.jpg'},
    {'name': 'Snickers', 'price': 20, 'image': 'assets/snickers.jpg'},
    {'name': 'Five Star', 'price': 60, 'image': 'assets/five_star.jpg'},
  ];

  // Quantity tracker
  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to update quantity of the item
  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bakery'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Welcome text with slide animation
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Bakery',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, false); // Decrease quantity
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, true); // Increase quantity
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class CafeDeCostaPage extends StatefulWidget {
  @override
  _CafeDeCostaPageState createState() => _CafeDeCostaPageState();
}

class _CafeDeCostaPageState extends State<CafeDeCostaPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // List of items with images, names, and prices
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Espresso', 'price': 60, 'image': 'assets/espresso.jpg'},
    {'name': 'Cappuccino', 'price': 70, 'image': 'assets/cappuccino.jpg'},
    {'name': 'Latte', 'price': 80, 'image': 'assets/latte.jpg'},
    {'name': 'Mocha', 'price': 90, 'image': 'assets/mocha.jpg'},
    {'name': 'Cold Brew', 'price': 100, 'image': 'assets/cold_brew.jpg'},
    {'name': 'Iced Coffee', 'price': 80, 'image': 'assets/iced_coffee.jpg'},
  ];

  // Quantity tracker
  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to update quantity of the item
  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafe de Costa'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Welcome text with slide animation
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Cafe de Costa',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, false); // Decrease quantity
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(
                                    index, true); // Increase quantity
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class LawCanteenPage extends StatefulWidget {
  @override
  _LawCanteenPageState createState() => _LawCanteenPageState();
}

class _LawCanteenPageState extends State<LawCanteenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Fruit Bowl', 'price': 50, 'image': 'assets/fruit_bowl.jpg'},
    {'name': 'Burger', 'price': 30, 'image': 'assets/burger.jpg'},
  ];

  final Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Law Canteen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Law Canteen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              menuItems[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            menuItems[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '₹${menuItems[index]['price']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                updateQuantity(index, false);
                              },
                            ),
                            Text(
                              '${quantities[index] ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                updateQuantity(index, true);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
