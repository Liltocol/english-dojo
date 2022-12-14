import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProblemView extends StatelessWidget {
  const ProblemView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  buildProblemList();
  }

  Widget buildProblemList() {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(title: const Text('Problem')),
        body: SafeArea(
      child:StreamBuilder<QuerySnapshot>(
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
                title: Text(data['english']),
                subtitle: Text(data['japanese']),
              ),
            );
          }).toList(),
        );
      },
    ),
      ),
    ),
    );
  }
}
