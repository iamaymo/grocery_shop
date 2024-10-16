import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/pages/HomePage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 80, right: 80, bottom: 40, top: 120),
            child: Image.asset('images/avocado.png'),
          ),
          Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "We Deliver Groceries At Your Doorstep",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSerif(
                    fontSize: 35, fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "Fresh Items Everyday",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSerif(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(187, 232, 104, 1),
              ),
              child: Text(
                "Get Started",
                style: GoogleFonts.notoSerif(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
