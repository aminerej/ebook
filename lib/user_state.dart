

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Books/books_screen.dart';
import 'LoginPage/login.dart';

class UserState extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot)
      {
        if(userSnapshot.data==null)
        {
          print('User is not logged yet');
          return login();
        }
        else if (userSnapshot.hasData)
        {
          print('User is already logged in yet');
          return  BookScreen();
        }

        else if (userSnapshot.hasError)
        {
          return const Scaffold(
            body: Center(
              child: Text('An error has been occured'),
            ),
          );
        }

        else if (userSnapshot.connectionState==ConnectionState.waiting)
        {
          return const Scaffold(
            body: Center(
              child:CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text('somthing went wrong'),
          ),
        );


      },
    );
  }
}
