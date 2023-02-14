import 'dart:async';
import 'dart:developer';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_it/common/routes.dart';

class AuthController extends GetxController {
  Future<void> loginWithGoogle() async {
    try {
      await _googleSignIn.signIn().then((value) {
        log(value?.displayName ?? '');
        log(value?.email ?? '');
        log(value?.id ?? '');
        log(value?.photoUrl ?? '');
      }).onError((error, stackTrace) {
        log(error.toString());
      }).then((value) {
        Get.toNamed(RouteClass.getFirst());
      });
    } catch (error) {
      print(error);
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
}
