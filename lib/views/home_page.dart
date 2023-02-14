import 'package:flutter/material.dart';
//import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:shop_it/common/routes.dart';
import 'package:shop_it/controllers/cart_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 120.0,
                  width: 120.0,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                      border: Border.all(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [BoxShadow(color: Colors.blueGrey.withOpacity(0.5), blurRadius: 4)]),
                  child: const Text(
                    "Shop it",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 230,
                ),
                ClipPath(
                    clipper: Triangle(),
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        height: 180,
                        decoration:  const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          color: Colors.orange,
                         
                        ))),
              ],
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteClass.getSign()),
        tooltip: '',
        child: const Icon(Icons.arrow_right),
      ),
    );
  }
}

class Triangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
