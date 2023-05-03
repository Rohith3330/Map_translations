import 'package:flutter/material.dart';
import 'update_details.dart';

class update_student extends StatefulWidget {
  const update_student({super.key});

  @override
  State<update_student> createState() => _update_studentState();
}

class _update_studentState extends State<update_student> {
  var searchval = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 600,
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                controller: searchval,
                decoration: InputDecoration(
                    hintText: 'Enter Roll number of student to be updated',
                    prefixIcon: Icon(Icons.abc),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => update_details()));
                  // Navigator.pop(context);
                },
                child: Text('Update')),
          ],
        ),
      ),
    );
  }
}