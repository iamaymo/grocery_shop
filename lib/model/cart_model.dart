import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    // [itemName, ItemPrice, imagePath, color]
    ["Avocado", "4.99", "images/avocado.png", Colors.green],
    ["Banana", "2.99", "images/banana.png", Colors.yellow],
    ["Chicken", "12.99", "images/chicken.png", Colors.brown],
    ["Water", "1.99", "images/water.png", Colors.blue],
    ["sheep", "44.99", "images/sheep.png", Colors.grey],
    ["apple", "3.99", "images/apple.png", Colors.green],
    ["lemon", "5.99", "images/lemon.png", Colors.yellow],
    ["grape", "7.99", "images/grape.png", Colors.purple],
    ["strawberry", "13.99", "images/strawberry.png", Colors.pink],
    ["cherry", "17.99", "images/cherry.png", Colors.red],
    ["bakery cake", "5.99", "images/bakery_cake.png", Colors.brown],
    ["icecream", "3.99", "images/icecream.png", Colors.orange],
    ["donut", "7.99", "images/donut.png", Colors.pink],
    ["pear", "4.99", "images/pear.png", Colors.yellow],
  ];

  List _cartItems = [];
  get shopItems => _shopItems;

  get cartItems => _cartItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
