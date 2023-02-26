import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'add_pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'add_pet2.dart';
import 'pet_info_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyB_mgrGHYC013S9m6BNDyZ8gbcomV6J25k",
      authDomain: "pet-adoption-app-23810.firebaseapp.com",
      databaseURL:"https://pet-adoption-app-23810-default-rtdb.asia-southeast1.firebasedatabase.app/",
      appId: "1:911697000475:android:369013fe7ab7ea2c16e0be",
      messagingSenderId: "911697000475",
      projectId: "pet-adoption-app-23810",
      storageBucket: "pet-adoption-app-23810.appspot.com",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Adoption App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.deepPurple), //<-- SEE HERE
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.deepPurple,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.deepPurple),
          ),
        ),
        //home: const AddPetProfile(),
        home: PetInfoPage(),
      );
        }
        
        else if(snapshot.hasError)
        {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("An error occured"),
              ),
            ),
          );
        }
        
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "PET ADOPTION APP",
          // //home: AddPetProfile(),
          home: PetInfoPage(),
        );
        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
