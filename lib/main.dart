import 'package:ebook/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _intialisation =Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intialisation,
      builder: (context, snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return const MaterialApp(

            home: Scaffold(
              body: Center(
                child: Text('ebook is being intialised',
                style:TextStyle(
                  color: Colors.cyan,
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  fontFamily:'signatra'
                ) ,
                ),
              ),
            ),
          );
        }
        else if(snapshot.hasError)
        {
          return const MaterialApp(

            home: Scaffold(
              body: Center(
                child: Text('an error has been occurred',
                  style:TextStyle(
                    color: Colors.cyan,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ) ,
                ),
              ),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ebook',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.blue,
          ),
          home:UserState(),
        );
      }
    );


  }
}


