import 'dart:developer';
import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProblemView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: buildProblemList(),
    );
  }

  Widget buildProblemList() {
    print("buildProblemList start");
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('test-problem').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          print("buildProblemList no data");
          return const Center(
            
            child: CircularProgressIndicator(),
          );
        }
        print("buildProblemList has data");
        if (snapshot.hasError) {
         print(snapshot.error);
          return const Text('Something went wrong');
        }
        print("ListView mae");
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            
            final data = document.data()! as Map<String, dynamic>;
            return Card(
              child: ListTile(
                title: Text(data['japanese']),
              ),
            );
          }).toList(),
          
        );
      },
    );
  }
}
