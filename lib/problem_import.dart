import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProblemImport extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('UPLOAD FILE'),
      onPressed: () async {
        var picked = await FilePicker.platform.pickFiles();

        if (picked != null) {
          Uint8List? fileBytes = picked.files.single.bytes;
          String s = utf8.decode(fileBytes!);
          List<String> recordList =
              s.replaceAll('\r\n', '\n').replaceAll('\r', '\n').split('\n');
          await docDelete();
          int recordCount = 0;
          for (final record in recordList) {
            List<String> elements = record.split(',');
            int i = 0;
            await _firestore
                .collection('problem')
                .add({
                  'number': recordCount++,
                  'school_year': elements[i++],
                  'unit': elements[i++],
                  'japanese': elements[i++],
                  'english': elements[i++],
                })
                .then((value) => print('ドキュメントを追加しました！'))
                .catchError((e) => print(e));
          }
        }
      },
    );
  }

  docDelete() async {
    var collection = _firestore.collection('problem');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
