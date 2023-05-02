import 'package:flutter/material.dart';

import '../Widgets/bottom_nav_bar.dart';

class UploadBook extends StatefulWidget {


  @override
  State<UploadBook> createState() => _UploadBookState();
}

class _UploadBookState extends State<UploadBook> {





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



        bottomNavigationBar: BottomNavBarForApp(indexNum:2,),
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
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(7.0),
            child: Card(
              color: Colors.white12,
              child: SingleChildScrollView(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ],
                ),
              ),
            ),
          ),
        ),




        ),





    );
  }
}
