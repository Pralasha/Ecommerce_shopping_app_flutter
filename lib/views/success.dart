import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/common/routes.dart';
import 'package:shop_it/controllers/cart_controller.dart';

class SucessPage extends StatelessWidget {
  SucessPage({super.key});

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text("Success!", style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20),
          const Text("Your order will be delivered soon."),
          const SizedBox(height: 10),
          const Text("Thank you for choosing our app!"),
          const SizedBox(height: 220),
          Padding(
            padding:const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.red,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                onPressed: () => Get.toNamed(RouteClass.getFirst()),
                child: const Text("Continue Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    )),
              ),
            ),
          ),
          
            //SizedBox(height: 30),
        ],
      ),
      
    );
  }
}
