import 'package:ebook/Widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BookScreen extends StatefulWidget {


  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient:     LinearGradient(
          colors: [Color(0xFF73C2FB) , Color(0xFFF5F5DC)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.2, 0.9],
        )
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavBarForApp(indexNum:0),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient:     LinearGradient(
                  colors: [Color(0xFF73C2FB) , Color(0xFFF5F5DC)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.2, 0.9],
                )
            ),

          ),
        ),
      ),
    );
  }
}
