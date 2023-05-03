import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home_screen.dart';
// import 'package:login_page/home_screen.dart';

class phone_otp extends StatefulWidget {
  const phone_otp({super.key});

  @override
  State<phone_otp> createState() => _phone_otpState();
}

class _phone_otpState extends State<phone_otp> {
  var phonenum = TextEditingController();
  var phoneenter = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verify = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone OTP'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Phone number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: phonenum,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    prefixIcon: Icon(Icons.phone),
                    suffixIcon: TextButton(
                      child: Text("Send OTP"),
                      onPressed: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+91 ${phonenum.text}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            verify = verificationId;
                            print("otp sent");
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: phoneenter,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter OTP sent',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: verify, smsCode: phoneenter.text);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  } catch (e) {
                    // print("wrong otp");
                    const snackBar = SnackBar(
                            content: Text('oops! wrong otp'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text("Verify")),
          ],
        ),
      ),
    );
  }
}