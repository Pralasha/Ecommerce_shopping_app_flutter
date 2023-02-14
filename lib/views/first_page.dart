import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_it/controllers/cart_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../common/routes.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Women's tops"),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/back.svg",
              color: kDefaultIconDarkColor),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/search.svg",
                color: kDefaultIconDarkColor),
          ),
          IconButton(
            onPressed: () => Get.toNamed(RouteClass.getCart()),
            icon: SvgPicture.asset("assets/icons/cart.svg",
                color: kDefaultIconDarkColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetX<CartController>(builder: (controller) {
          return GridView(

              //itemCount: products.length,
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 260,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16),
              children: [
                for (int index = 0; index < controller.products.length; index++)
                  GestureDetector(
                    onTap: () {
                      bottomsheets(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0.5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.blueGrey.withOpacity(0.5))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              controller.products[index].image?.toString() ??
                                  '0',
                            ),
                          ),
                          RatingBarIndicator(
                            rating: 2.75,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            controller.products[index].title ?? 'No Name',
                            style: const TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${controller.products[index].price?.toString() ?? '0'}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () {
                                  controller
                                      .addOrRemove(controller.products[index]);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(120),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: Colors.blueGrey
                                                .withOpacity(0.5))
                                      ]),
                                  child: GetBuilder<CartController>(
                                      builder: (controller) {
                                    bool inCart = false;
                                    controller.inCart.forEach((element) {
                                      if (controller.products[index].id ==
                                          element.product?.id) {
                                        inCart = true;
                                      }
                                    });
                                    return Icon(inCart
                                        ? Icons.shopping_bag
                                        : Icons.add_shopping_cart);
                                  }),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ]);
        }),
      ),
    );
  }
}

void bottomsheets(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text("Select Size",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: const Text(
                        "XS",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: const Text(
                        "S",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: const Text(
                        "M",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: const Text(
                        "L",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: const Text(
                        "XL",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: const Text("Size info"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: Colors.red,
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0)),
                    onPressed: () => Get.toNamed(RouteClass.getCart()),
                    child: const Text("ADD TO CART",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        )),
                  ),
                ),
                //SizedBox(height: 30),
              ),
            ],
          )));
}
