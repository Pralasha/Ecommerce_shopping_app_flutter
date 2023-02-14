import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_it/controllers/auth_controller.dart';

import 'common/routes.dart';
import 'controllers/cart_controller.dart';

//import 'firebase_options.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<CartController>(() => CartController());
  Get.lazyPut<AuthController>(() => AuthController());
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter2 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomeScreen(),
      initialRoute: RouteClass.home,
      getPages: RouteClass.routes,
    );
  }
}
