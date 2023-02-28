import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  final String collectionName = 'Pets';
  final String documentId = ' SCBFhKWQ777j5jLM9Y1d';
  final String fieldName = 'Age';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection(collectionName).doc(documentId).get(),
      builder: (context, snapshot) {
        const String fieldName = 'Age';
        if (snapshot.hasData) {
          final data = snapshot.data!.data();
          final fieldValue = data!.[fieldName];
          return Text('Field value: $fieldValue');
        } else if (snapshot.hasError) {
          return const Text('Error retrieving document');
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}

