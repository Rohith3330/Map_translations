import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class create_student extends StatefulWidget {
  const create_student({super.key});

  @override
  State<create_student> createState() => _create_studentState();
}

// ignore: camel_case_types
class _create_studentState extends State<create_student> {
  var nameval = TextEditingController();
  var rollval = TextEditingController();
  var classval = TextEditingController();

  create(String name, rno, cla) async {
    await FirebaseFirestore.instance.collection('students').doc(rno).set({
      'name': name,
      'roll number': rno,
      'class': cla,
    });
    // print("user created");
    const snackBar = SnackBar(
      content: Text('User added'),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create student'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: nameval,
                // onChanged: (value) {
                //   emailval = value;
                // },
                decoration: InputDecoration(
                    hintText: 'Enter Student name',
                    prefixIcon: const Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Roll Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: rollval,
                // onChanged: (value) {
                //   passval = value;
                // },
                // obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter roll number',
                    prefixIcon: const Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Class',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: classval,
                decoration: InputDecoration(
                    hintText: 'Enter class',
                    prefixIcon: const Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  create(nameval.text, rollval.text, classval.text);
                  Navigator.pop(context);
                },
                child: const Text('Add')),
          ],
        ),
      ),
    );
  }
}