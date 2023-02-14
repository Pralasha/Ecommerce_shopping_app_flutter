import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shop_it/common/routes.dart';
import 'package:shop_it/controllers/cart_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<CartController>();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  //final controller = Get.find<AuthController>();
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for this email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 44.0,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              alignment: const Alignment(1, 0),
              padding: const EdgeInsets.only(top: 15, left: 20),
              child: InkWell(
                onTap: () => Get.toNamed(RouteClass.getSign()),
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.red,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context)
                      .then((value) => Get.toNamed(RouteClass.getFirst()));
                  print(user);
                },
                child: const Text("LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),
              ),
            ),
          ],
        ));
  }
}
