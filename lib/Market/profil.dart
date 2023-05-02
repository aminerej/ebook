import 'package:flutter/material.dart';

import '../Widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        bottomNavigationBar: BottomNavBarForApp(indexNum:3,),
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
