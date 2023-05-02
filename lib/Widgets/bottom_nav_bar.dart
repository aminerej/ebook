import 'package:ebook/Books/books_screen.dart';
import 'package:ebook/Books/upload_book.dart';
import 'package:ebook/Market/notification_screen.dart';
import 'package:ebook/Market/shopping_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../Market/profil.dart';

class BottomNavBarForApp extends StatelessWidget {


  int indexNum =0;
  BottomNavBarForApp({required this.indexNum});


  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Color(0xFFF5F5DC),
      backgroundColor: Color(0xFF73C2FB),
      buttonBackgroundColor: Color(0xFFF5F5DC),
      height: 50,
      index: indexNum,
      items: const [
        Icon(Icons.home , size: 19, color: Colors.black,),
        Icon(Icons.shopping_cart,size: 19,color: Colors.black,),
        Icon(Icons.add,size: 19,color: Colors.black,),
        Icon(Icons.person,size: 19,color: Colors.black,),
        Icon(Icons.notifications,size: 19,color: Colors.black,),
      ],
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index)
      {
        if(index==0)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BookScreen()));
          }
        else if(index==1)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ShoppingScreen()));

        }
        else if (index==2)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>UploadBook()));

        }
        else if (index==3)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ProfileScreen()));

        }
        else if (index==4)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>NotificationScreen()));

        }
      },
    );
  }
}
