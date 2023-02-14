import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shop_it/common/routes.dart';
import 'package:shop_it/controllers/auth_controller.dart';
import 'package:shop_it/main.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  SigninPageState createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final controller = Get.find<AuthController>();

  void _register() async {
    final User? user = (await auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;
    if (user != null) {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
            child: const Text("Sign Up",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          )
        ]),
        Container(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: "Name",
                  ),
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                TextField(
                  controller: _passwordController,
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
                    onTap: () => Get.toNamed(RouteClass.getLogin()),
                    child: const Text('Aldready have an Account?'),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
              ],
            )),
        SizedBox(
          width: double.infinity,
          child: RawMaterialButton(
            fillColor: Colors.red,
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            onPressed: 
              // _register();
              () => Get.toNamed(RouteClass.getFirst()),
            
            child: const Text("SIGN UP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )),
          ),
        ),
        const SizedBox(height: 100),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Or sign up with social account"),
            ]),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              height: 70,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: SizedBox(
                height: 45,
                width: 45,
                child: InkWell(
                  onTap: () {
                    controller.loginWithGoogle();
                  },
                  child: Image.network(
                      "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png"),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Container(
                padding: const EdgeInsets.all(25),
                height: 70,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/124/124010.png"),
                )),
            const SizedBox(height: 10),
          ],
        )
      ],
    ));
  }
}
