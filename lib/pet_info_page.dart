import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_pet.dart';

class PetInfoPage extends StatefulWidget {
  final String? Age;
  final String? Breed;
  final String? Category;
  final String? Description;
  final String? Email_address;
  final String? Gender;
  final String? Location;
  final String? Mobile_number;
  final String? Name;
  final String? Owner_name;
  final String? Dummy;

  //({Key? key}) : super(key: key);
  const PetInfoPage({super.key, 
    this.Dummy,
    this.Breed,
    this.Age,
    this.Category,
    this.Description,
    this.Email_address,
    this.Gender,
    this.Location,
    this.Mobile_number,
    this.Name,
    this.Owner_name,
  });

  @override
  State<PetInfoPage> createState() => _PetInfoPageState();
}

class _PetInfoPageState extends State<PetInfoPage> {
  

  // String? petName;
  // String? petAge;
  // String? petBreed;
  // String? petCategory;
  // String? petGender;
  // String? petLocation;
  // String? description;
  // String? emailAddress;
  // String? mobileNumber;
  // String? ownerName;

  // readData() {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection("Pets").doc(petName);
  //   documentReference.get().then((datasnapshot) {
  //     if (kDebugMode) {
  //       print(datasnapshot.data());
  //     }
  //   });

  //   FirebaseFirestore.instance.collection('Pets')
  //     .get().then<dynamic>((DocumentSnapshot snapshot) async
  //     {
  //       petName = snapshot.get('Name');
        
  //     } as FutureOr Function(QuerySnapshot<Map<String, dynamic>> value));
  // }

  Future _getDataFromDatabase() async {
    // Retrieve a document with a specific ID from a collection
Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(String collectionName, String documentId) async {
  final doc = await FirebaseFirestore.instance.collection(collectionName).doc(documentId).get();
  return doc;
}

// // Example usage
// const docId = 'SCBFhKWQ777j5jLM9Y1d';
// const collectionName = 'Pets';
// final docSnapshot = await getDocument(collectionName, docId);
// if (docSnapshot.exists) {
//   // Access the document data
//   final data = docSnapshot.data();
//   print(data);
// } else {
//   print('Document with ID $docId not found in collection $collectionName');
// }

// Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocumentsByField(String collectionName, String fieldName) async {
//   final snapshots = await FirebaseFirestore.instance.collection(collectionName).where(fieldName, isEqualTo: fieldValue).get();
//   return snapshots.docs;
// }

// // Example usage
// final collectionName = 'Pets';
// final fieldName = 'Name';
// //final fieldValue = 'someValue';
// final docsSnapshots = await getDocumentsByField(collectionName, fieldName);
// docsSnapshots.forEach((doc) {
//   final data = doc.data();
//   print(data);
// });
    // await FirebaseFirestore.instance
    //     .collection("students")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((snapshot) async {
    //   if (snapshot.exists) {
    //     setState(() {
    //       petName = snapshot.data()!["Name"];
    //       petAge = snapshot.data()!["Age"];
    //       petBreed = snapshot.data()!["Breed"];
    //       petCategory = snapshot.data()!["Category"];
    //       petGender = snapshot.data()!["Gender"];
    //       description = snapshot.data()!["Description"];
    //       petLocation = snapshot.data()!["Location"];
    //       ownerName = snapshot.data()!["Owner name"];
    //       mobileNumber = snapshot.data()!["Mobile number"];
    //       emailAddress = snapshot.data()!["Email address"];
    //     });
    //   }
    //   else{
    //     return const Center(child: Text('There is no tasks'),);
    //   }
    //   return const Center(child: Text(
    //     'Something went wrong',
    //   ),);
    // });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    var petName;
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
              Text(
                'Image DB',
              ),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
              Text(
               'Name',
              ),
            ]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: const [
                  Text(
                    'Age',
                  ),
                  Text(
                    'DB',
                  )
                ]),
                Column(children: const [
                  Text(
                    'Age',
                  ),
                  Text(
                    'DB',
                  )
                ]),
                Column(children: const [
                  Text(
                    'Breed',
                  ),
                  Text(
                    'DB',
                  )
                ]),
              ],
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(children: const [
                Text(
                  'Location',
                ),
                Text(
                  'DB',
                )
              ]),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
              Text(
                'Sterlised DB',
              ),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(children: const [
                Text(
                  'Description',
                ),
                Text(
                  'Desp DB',
                )
              ]),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
              Text(
                'Contact Information',
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(children: const [
                Text(
                  'Mobile No.',
                ),
                Text(
                  'Eamil address',
                )
              ]),
              Column(children: const [
                Text(
                  'DB ',
                ),
                Text(
                  'DB',
                )
              ]),
            ]),
          ]),
        ),
      ),
    );
  }
  List<String> docIDs = [];

    //get docIDs
    Future getDocId() async{
      await FirebaseFirestore.instance.collection('Pets').get().then(
        // ignore: avoid_function_literals_in_foreach_calls
        (snapshot) => snapshot.docs.forEach((element) {
          if (kDebugMode) {
            print(element.reference);
            docIDs.add(element.reference.id);
          }
        })
      );
    }
}
