import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class delete_student extends StatefulWidget {
  const delete_student({super.key});

  @override
  State<delete_student> createState() => _delete_studentState();
}

// ignore: camel_case_types
class _delete_studentState extends State<delete_student> {
  var searchval = TextEditingController();
  deleteStud(String rno) async {
    await FirebaseFirestore.instance.collection('students').doc(rno).delete();
    // print("User deleted");
    const snackBar = SnackBar(
      content: Text('User deleted'),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Student'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 600,
              padding: const EdgeInsets.only(top: 20),
              child: TextField(
                controller: searchval,
                decoration: InputDecoration(
                    hintText: 'Enter Roll number of student to be deleted',
                    prefixIcon: const Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  // const snackBar = SnackBar(
                  //   content: TextButton(
                  //     child: Text('Confirm Deletion?'),
                  //     onPressed:(){
                  //       deleteStud(searchval.text);
                  //     },
                  //   ),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Navigator.pop(context);
                  deleteStud(searchval.text);
                  Navigator.pop(context);
                },
                child: const Text('Delete')),
          ],
        ),
      ),
    );
  }
}