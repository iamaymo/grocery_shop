// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/model/cart_model.dart';
import 'package:provider/provider.dart';

Future<void> paymentDialog(BuildContext context, CartModel cartModel) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(162, 187, 232, 104),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.37,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Divider(height: 20, color: Colors.transparent),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Payment Cost: \$${cartModel.calculateTotal()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: nameController,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    style: TextStyle(decoration: TextDecoration.none),
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: cardNumberController,
                    maxLength: 9,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      labelText: "Card Number",
                      hintText: "000 000 000",
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      errorText: cardNumberController.text.length < 9
                          ? 'Card number must be 9 digits'
                          : null,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    style: TextStyle(decoration: TextDecoration.none),
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (value) {
                      // Trigger a rebuild when the card number changes
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(187, 232, 104, 1),
                        ),
                        onPressed: () {
                          // Check if the fields are empty or card number is less than 9 digits
                          if (nameController.text.isEmpty ||
                              cardNumberController.text.length < 9) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            50), // Adjust the margin to push it down slightly
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Please fill in all fields correctly",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            // Logic to handle payment
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Pay'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void showTopSnackBar(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(
              top: 50), // Adjust the margin to push it down slightly
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    },
  );

  // Close the dialog automatically after 2 seconds
  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
}

class CartPage extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black, size: 30),
          backgroundColor: Color.fromRGBO(187, 232, 104, 1),
          centerTitle: true,
          toolbarHeight: 65,
          title: Text(
            "My Cart",
            style: GoogleFonts.notoSerif(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Consumer<CartModel>(
          builder: (context, value, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: value.cartItems[index][3],
                        margin: EdgeInsets.all(7),
                        child: ListTile(
                            leading: Image.asset(
                              value.cartItems[index][2],
                              height: 36,
                            ),
                            title: Text(
                              value.cartItems[index][0],
                              style: GoogleFonts.notoSerif(
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '\$${value.cartItems[index][1]}',
                              style: GoogleFonts.notoSerif(
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Provider.of<CartModel>(context, listen: false)
                                    .removeItem(index);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            )),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(187, 232, 104, 1),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Price: ",
                              style: GoogleFonts.notoSerif(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("\$${value.calculateTotal()}",
                                style: GoogleFonts.notoSerif(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            var cartModel =
                                Provider.of<CartModel>(context, listen: false);
                            double total =
                                double.tryParse(cartModel.calculateTotal()) ??
                                    0;
                            if (total > 0) {
                              paymentDialog(context, cartModel);
                            } else {
                              showTopSnackBar(context, "Your cart is empty!");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Text(
                                  "Pay Now",
                                  style: GoogleFonts.notoSerif(
                                      color: Colors.black, fontSize: 17),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
