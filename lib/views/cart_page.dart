import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/common/routes.dart';
import 'package:shop_it/controllers/cart_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.toNamed(RouteClass.getFirst()),
          icon: SvgPicture.asset("assets/icons/back.svg",
              color: kDefaultIconDarkColor),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/search.svg",
                color: kDefaultIconDarkColor),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "My Bag",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // list view of cart
          Expanded(
            child: GetBuilder<CartController>(builder: (controller) {
              return ListView.builder(
                itemCount: controller.inCart.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.network(
                                  controller.inCart[index].product?.image
                                          ?.toString() ??
                                      '0',
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 16.0,
                                  top: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.inCart[index].product?.title ??
                                          'No Name',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 25.0),
                                            child: Text(
                                              '\$${controller.inCart[index].product?.price?.toString() ?? '0'}',
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          SizedBox(
                                              child: /*  GetBuilder<CartController>(builder: (controller) {
                          return  */
                                                  SizedBox(
                                            width: 160,
                                            height: 50,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      controller.updateCount(
                                                          controller
                                                                  .inCart[index]
                                                                  .count! -
                                                              1,
                                                          controller
                                                              .inCart[index]
                                                              .product!
                                                              .id!);
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove),
                                                  ),
                                                  Text(
                                                      '${controller.inCart[index].count}'),
                                                  IconButton(
                                                      onPressed: () {
                                                        controller.updateCount(
                                                            controller
                                                                    .inCart[
                                                                        index]
                                                                    .count! +
                                                                1,
                                                            controller
                                                                .inCart[index]
                                                                .product!
                                                                .id!);
                                                      },
                                                      icon: const Icon(
                                                          Icons.add)),
                                                ]),
                                          )
                                              // }),
                                              ),
                                        ]),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total amount:'),
                  GetX<CartController>(builder: (_controller) {
                    return Text(
                        '${_controller.totalPrice.value.toStringAsFixed(2)}');
                  }),
                  const SizedBox(
                    height: 60.0,
                  ),
                  // Obx(() => Text(controller.totalPrice.string)),
                ]),
          ),
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
                onPressed: () {
                  controller.makePayment().ignore();
                  Get.toNamed(RouteClass.getSucess());
                },
                child: const Text("CHECK OUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    )),
              ),
            ),
            //SizedBox(height: 30),
          ),
        ],
      ),
    );
  }
}
