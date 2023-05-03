import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class update_details extends StatefulWidget {
  const update_details({super.key});

  @override
  State<update_details> createState() => _update_detailsState();
}

class _update_detailsState extends State<update_details> {
  var nameval = TextEditingController();
  var rollval = TextEditingController();
  var classval = TextEditingController();
  // var n = FirebaseFirestore.instance
  //     .collection('students')
  //     .where('name',isEqualTo:"Rishikesh" && 'class', isEqualTo: "CSMA")
  //     .get();
  Update(String nam, rno, cla) async {
    FirebaseFirestore.instance.collection('students').doc(rno)
.get().then((DocumentSnapshot) =>
      // ignore: avoid_print
      print(DocumentSnapshot.data.toString())
);
    const snackBar = SnackBar(
      content: Text('User updated'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update details'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: nameval,
                decoration: InputDecoration(
                    // prefixText: n.toString(),
                    prefixIcon: Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Roll Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rollval,
                decoration: InputDecoration(
                    hintText: 'Enter roll number',
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Class',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: classval,
                decoration: InputDecoration(
                    hintText: 'Enter class',
                    prefixIcon: Icon(Icons.abc),
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
                  // create(nameval.text, rollval.text, classval.text);
                  // Navigator.pop(context);
                  Update(nameval.text, rollval.text, classval.text);
                  Navigator.pop(context);
                },
                child: Text('Update')),
          ],
        ),
      ),
    );
  }
}