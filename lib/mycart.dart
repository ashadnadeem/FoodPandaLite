import 'package:flutter/material.dart';
import 'package:foodpandalite/main.dart';

class myCart extends StatefulWidget {
  final Function(List<Dish>) onCartUpdated;
  final List<Dish> cart;
  myCart({
    Key? key,
    required List<Dish> this.cart,
    required this.onCartUpdated,
  }) : super(key: key);

  @override
  State<myCart> createState() => _myCartState();
}

class _myCartState extends State<myCart> {
  List<Dish> myCartList = [];
  @override
  void initState() {
    // TODO: implement initState
    myCartList = widget.cart;
    super.initState();
  }

  // Function to Calculate the total price of the cart
  int totalPrice() {
    int total = 0;
    for (Dish dish in myCartList) {
      total += dish.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.red,
      ),
      //Widgets
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Dishes:',
              style: Theme.of(context).textTheme.headline4,
            ),
            //Display the list of dishes through menu
            Expanded(
              child: ListView.builder(
                itemCount: myCartList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(myCartList[index].name[0]),
                    ),
                    title: Text(myCartList[index].name),
                    subtitle: Text(
                        '${myCartList[index].description} for just Rs: ${myCartList[index].price}/-'),
                    trailing: IconButton(
                      iconSize: 40,
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        //Get the confirmation from the user
                        bool val = await _showMyDialog();
                        if (val) {
                          //Remove the dish from the cart
                          setState(() {
                            myCartList.removeAt(index);
                            widget.onCartUpdated(myCartList);
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Total Price: ${totalPrice()}/-',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Remove'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure, you want to remove this dish from cart?'),
                Text('Please confirm to proceed.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
