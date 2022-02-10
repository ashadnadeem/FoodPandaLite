import 'package:flutter/material.dart';
import 'package:foodpandalite/mycart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Panda Lite',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Welcome to our Resturant'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Dish> _cart = [];
  List<Dish> menu = [];
  List<Dish> _defaultMenu = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu.add(Dish(
        id: 1, name: 'Pizza', price: 100, description: "Pizza description"));
    menu.add(Dish(
        id: 2, name: 'Burger', price: 200, description: "Burger description"));
    menu.add(
        Dish(id: 3, name: 'Cake', price: 250, description: "Cake description"));
    menu.add(Dish(
        id: 4, name: 'Coffee', price: 300, description: "Coffee description"));
    menu.add(
        Dish(id: 5, name: 'Tea', price: 50, description: "Tea description"));
    menu.add(
        Dish(id: 6, name: 'Soup', price: 150, description: "Soup description"));
    menu.add(Dish(
        id: 7,
        name: 'Biryani',
        price: 250,
        description: "Biryani description"));
    menu.add(Dish(
        id: 8,
        name: 'Egg Fried Rice',
        price: 150,
        description: "Rice description"));
    menu.add(Dish(
        id: 9,
        name: 'Chicken Fried Rice',
        price: 200,
        description: "Chicken Rice description"));
    menu.add(Dish(
        id: 10, name: 'Pasta', price: 150, description: "Pasta description"));
    // Creating a copy to save original data
    _defaultMenu = menu;
  }

  // Function to Calculate the total price of the cart
  int totalPrice() {
    int total = 0;
    for (Dish dish in _cart) {
      total += dish.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please Select your Dishes:',
              style: Theme.of(context).textTheme.headline4,
            ),
            //Text Field to search the menu list
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for Dishes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  menu = _defaultMenu
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            //Display the list of dishes through menu
            Expanded(
              child: ListView.builder(
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(menu[index].name[0]),
                    ),
                    title: Text(menu[index].name),
                    subtitle: Text(
                        '${menu[index].description} \nfor just Rs: ${menu[index].price}/-'),
                    trailing: IconButton(
                      iconSize: 40,
                      icon: Icon(
                        !_cart.contains(menu[index])
                            ? Icons.add_circle_rounded
                            : Icons.remove_circle_outline,
                        color: !_cart.contains(menu[index])
                            ? Colors.green
                            : Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          !_cart.contains(menu[index])
                              ? _cart.add(menu[index])
                              : _cart.remove(menu[index]);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            //Display the total price of the dishes in the cart
            //Left Aligned
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Total Price: ${totalPrice()}/-',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(right: 50),
        child: FloatingActionButton(
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            //Go to My carts page and pass the cart list
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => myCart(
                  cart: _cart,
                  onCartUpdated: (value) {
                    setState(() {
                      _cart = value;
                    });
                  },
                ),
              ),
            );
          },
          tooltip: 'Show Cart',
          child: Column(mainAxisSize: MainAxisSize.min, children: const [
            Icon(Icons.shopping_cart),
            Text('Cart'),
          ]),
        ),
      ),
    );
  }
}

class Dish {
  final int id;
  final String name;
  final int price;
  final String description;

  Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });
}
