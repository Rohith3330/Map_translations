import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class retreive_student extends StatefulWidget {
  const retreive_student({super.key});

  @override
  State<retreive_student> createState() => _retreive_studentState();
}

class _retreive_studentState extends State<retreive_student> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('students').snapshots(),
          builder: (context, studSnapshot) {
            if (studSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final studDocs = studSnapshot.data!.docs;
              return ListView.builder(
                itemCount: studDocs.length,
                itemBuilder: (context, index) {
                  // return Card(
                  //   child: ListTile(
                  //     title: Text(studDocs[index]['name']),
                  //     subtitle: Text(studDocs[index]['roll number']),

                  //   ),
                  // );
                  return Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(studDocs[index]['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                            Container(width: 20,
                              child:Text('|',style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Text(studDocs[index]['roll number'],style: TextStyle(fontWeight: FontWeight.bold),),
                            Container(width: 20,
                              child:Text('|',style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                            Text(studDocs[index]['class'],style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 10,bottom: 10),
                        //   child: Text('--------------------',style: TextStyle(fontWeight: FontWeight.w500),),
                        // ),
                        Divider(
                          color: Colors.black,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}