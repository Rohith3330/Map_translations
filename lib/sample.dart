import 'dart:convert';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Gmap extends StatefulWidget {
  String img1;
  Gmap({super.key, required this.img1});

  @override
  State<Gmap> createState() => _GmapState(img1);
}

class _GmapState extends State<Gmap> {
  String img1;
  _GmapState(this.img1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // elevation: 0.0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 1,
          maxScale: 10,
          child: Image.memory(
            base64Decode(img1),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}