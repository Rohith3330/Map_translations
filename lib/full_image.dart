import 'dart:convert';
import 'dart:typed_data';

import 'package:dev/sample.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class Fullimg extends StatefulWidget {
  String img1,img2;
  Fullimg({super.key,required this.img1,required this.img2});
  @override
  State<Fullimg> createState() => _FullimgState(img1,img2);
}

class _FullimgState extends State<Fullimg> {
  String img1,img2;
  _FullimgState(this.img1,this.img2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          // SizedBox(height: MediaQuery.of(context).size.height/10,),
          // Image.memory(base64Decode(img2),fit: BoxFit.fill,),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Uploaded Image',
            style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            child:Container(
            height: MediaQuery.of(context).size.height/2,
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20.0),
              minScale: 0.1,
              maxScale: 10,
              child: Image.memory(base64Decode(img1),fit: BoxFit.fill,),
            ),
          ),
          onTap: ()=>{Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Gmap(
                            img1: img1,
                          )))},
          ),
          
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Result Image',
            style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            child:Container(
            height: MediaQuery.of(context).size.height/2,
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20.0),
              minScale: 0.1,
              maxScale: 10,
              child: Image.memory(base64Decode(img2),fit: BoxFit.fill,),
            ),
          ),
          onTap: ()=>{Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Gmap(
                            img1: img2,
                          )))},
          ),
          // Container(
          //   height: 450,
          //   padding: EdgeInsets.all(10),
          //   width: MediaQuery.of(context).size.width,
          //   child: PinchZoom(
          //       child: Image.memory(base64Decode(img2),fit: BoxFit.fill,),
          //       resetDuration: const Duration(milliseconds: 100),
          //       maxScale: 2.5,
          //       onZoomStart: (){},
          //       onZoomEnd: (){},
          //   ),
          // ),
        ],
      ),
    );
  }
}