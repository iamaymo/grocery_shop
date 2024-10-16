import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/pages/CartPage.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/components/GroceryItemTile.dart';
import 'package:grocery_shop/model/cart_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(187, 232, 104, 1),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CartPage();
            },
          ));
        },
        child: const Icon(
          Icons.shopping_bag,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(187, 232, 104, 1),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(187, 232, 104, 1)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Good Morning,",
                      style: GoogleFonts.notoSerif(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Let's order fresh items for you",
                      style: GoogleFonts.notoSerif(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Fresh Items",
                style: GoogleFonts.notoSerif(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Consumer<CartModel>(
                builder:
                    (BuildContext context, CartModel value, Widget? child) {
                  return GridView.builder(
                    itemCount: value.shopItems.length,
                    padding: EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.2),
                    itemBuilder: (context, index) {
                      return GroceryItemTile(
                        itemName: value.shopItems[index][0] as String,
                        itemPrice: value.shopItems[index][1]
                            as String, // Corrected index
                        imagePath: value.shopItems[index][2]
                            as String, // Corrected index
                        color: value.shopItems[index][3] as MaterialColor,
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .addItemToCart(index);
                        }, // Corrected index
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
