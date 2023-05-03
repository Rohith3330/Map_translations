import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_otp/email_otp.dart';
import 'phone_otp.dart';


// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
   SignupPage({super.key});
  var nameval = TextEditingController();
  var emailval = TextEditingController();
  var passval = TextEditingController();
  var mailotp = TextEditingController();

  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),
        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text("Sign up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 20,),
                  Text("Create an account, It's free ",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.grey[700]),)
                ],
              ),
              Column(
                children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      // ignore: prefer_const_constructors
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
                  hintText: 'Enter name',
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'E-Mail',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 300,
            child: TextField(
              controller: emailval,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter email id',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 300,
            child: TextField(
              obscureText: true,
              controller: passval,
              decoration: InputDecoration(
                  hintText: 'Enter password',
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Container(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'OTP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 10,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: mailotp,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  suffixIcon: TextButton(
                    child: Text("Send OTP"),
                    onPressed: () async {
                      myauth.setConfig(
                        appEmail: "krohithmanikanta3@gmail.com",
                        appName: "Email OTP",
                        userEmail: emailval.text,
                        otpLength: 6,
                        otpType: OTPType.digitsOnly,
                      );
                      if (await myauth.sendOTP() == true) {
                        print("OTP sent successfully");
                      } else {
                        print("OTP could not be sent");
                        const snackBar = SnackBar(
                          content: Text('Please enter valid Email Id'),
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (await myauth.verifyOTP(otp: mailotp.text) == true) {
                  try {
                    // UserCredential userCredential = await FirebaseAuth.instance
                    //     .createUserWithEmailAndPassword(
                    //         email: emailval.text, password: passval.text);

                    // var db = FirebaseFirestore.instance;

                    // final person_x = <String, String>{
                    //   "Name": nameval.text,
                    //   "Mail": emailval.text,
                    //   "Password": passval.text,
                    // };
                    // db
                    //     .collection("people")
                    //     .doc()
                    //     .set(person_x)
                    //     .onError((e, _) => print("Error writing document: $e"));
                    // // ignore: use_build_context_synchronously
                    await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailval.text,
                                password: passval.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const phone_otp()));
                        }).onError((error, stackTrace) {
                          // print("Error ${error.toString()}");
                        });
                        // print('uid');
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .set({
                          'uid': uid,
                          'username': nameval.text,
                          'email': emailval.text,
                          'password': passval.text,
                        });
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => ));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      const snackBar = SnackBar(
                        content: Text('The password provided is too weak.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      const snackBar = SnackBar(
                        content: Text('email-already-in-use'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } catch (e) {
                    print(e);
                  }
                } else {
                  const snackBar = SnackBar(
                    content: Text('Incorrect OTP entered'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
              )
        ],
      ),
                          
            ],
          ),
        ),
      ),
    );
  }
}

