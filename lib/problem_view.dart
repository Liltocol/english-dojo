import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProblemView extends StatelessWidget {
  const ProblemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: buildProblemList(),
    );
  }

  Widget buildProblemList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('test-problem').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
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
