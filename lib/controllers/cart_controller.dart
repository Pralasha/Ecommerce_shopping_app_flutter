import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/state_manager.dart';
import 'package:shop_it/models/product.dart';
import 'package:shop_it/models/items.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class CartController extends GetxController {
  final box = GetStorage();
  @override
  void onInit() {
    //box.erase();
    box.listen(() {
      print('box changed');
    });
    box.listenKey('totalPrice', (value) {
      print('new key is $value');
    });

    getProducts();
    totalPrice.value = double.parse(box.read('totalPrice') ?? '0');
    try {
      final String cartItems = box.read('inCart') ?? '[]';
      final List<Map<String, dynamic>> element =
          List<Map<String, dynamic>>.from(json.decode(cartItems) as List);
      for (final element in element) {}
    } catch (_) {
      print(_.toString());
    }

    super.onInit();
  }

  List<Product> products = <Product>[].obs;
  List<CartItem> inCart = <CartItem>[];
  var totalPrice = 0.0.obs;

  void addOrRemove(Product product) {
    bool isPresent = false;
    inCart.forEach((element) {
      if (element.product!.id == product.id) {
        isPresent = true;
      }
    });
    if (isPresent == false) {
      inCart.add(CartItem(count: 1, product: product));
    } else {
      inCart.removeWhere((element) => element.product!.id == product.id);
    }
    totalPrice.value = inCart.fold(
        0, (sum, element) => sum + element.product!.price!.toDouble());
    box.write('totalPrice', '$totalPrice');

    update();
  }

  updateCount(int number, num id) {
    inCart.firstWhere((element) => element.product?.id == id).count = number;

    totalPrice.value = inCart.fold(
        0,
        (sum, element) =>
            sum +
            (element.product!.price!.toDouble() * element.count!.toInt()));
    box.write('totalPrice', '$totalPrice');
    update();
  }

  var dio = Dio();

  Future<void> getProducts() async {
    final response = await dio
        .get("https://fakestoreapi.com/products/category/women's%20clothing");
    if (response.statusCode == 200) {
      for (final element in response.data as List) {
        products.add(Product.fromJson(element as Map<String, dynamic>));
      }
    } else {
      throw 'Error';
    }
  }

  Future<void> makePayment() async {
    final response = await dio
        .post(
      "https://payulatam.com/payments-api/4.0/service.cgi",
      /* data: {
          "language": "es",
          "command": "SUBMIT_TRANSACTION",
          "merchant": {
            "apiKey": "4Vj8eK4rloUd272L48hsrarnUA",
            "apiLogin": "pRRXKOl8ikMmt9u"
          },
          "transaction": {
            "order": {
              "accountId": "512321",
              "referenceCode": "PRODUCT_TEST_2023-02-14T13:53:18.860Z",
              "description": "Payment test description",
              "language": "es",
              "signature": "{{signature}}",
              "notifyUrl": "{{confirmation_page}}",
              "additionalValues": {
                "TX_VALUE": {
                  "value": {'{tx_value_co}'},
                  "currency": "{{currency_co}}"
                },
                "TX_TAX": {"value": 0, "currency": "{{currency_co}}"},
                "TX_TAX_RETURN_BASE": {
                  "value": 0,
                  "currency": "{{currency_co}}"
                }
              },
              "buyer": {
                "merchantBuyerId": "1",
                "fullName": "First name and second buyer name",
                "emailAddress": "buyer_test@test.com",
                "contactPhone": "7563126",
                "dniNumber": "123456789",
                "shippingAddress": {
                  "street1": "calle 100",
                  "street2": "5555487",
                  "city": "Medellin",
                  "state": "Antioquia",
                  "country": "CO",
                  "postalCode": "000000",
                  "phone": "7563126"
                }
              },
              "shippingAddress": {
                "street1": "calle 100",
                "street2": "5555487",
                "city": "Medellin",
                "state": "Antioquia",
                "country": "CO",
                "postalCode": "0000000",
                "phone": "7563126"
              }
            },
            "payer": {
              "merchantPayerId": "1",
              "fullName": "First name and second payer name",
              "emailAddress": "payer_test@test.com",
              "contactPhone": "7563126",
              "dniNumber": "5415668464654",
              "billingAddress": {
                "street1": "calle 93",
                "street2": "125544",
                "city": "Bogota",
                "state": "Bogota DC",
                "country": "CO",
                "postalCode": "000000",
                "phone": "7563126"
              }
            },
            "creditCard": {
              "number": "4037997623271984",
              "securityCode": "321",
              "expirationDate": "2030/12",
              "name": "APPROVED"
            },
            "extraParameters": {"INSTALLMENTS_NUMBER": 1},
            "type": "AUTHORIZATION_AND_CAPTURE",
            "paymentMethod": "VISA",
            "paymentCountry": "CO",
            "deviceSessionId": "vghs6tvkcle931686k1900o6e1",
            "ipAddress": "127.0.0.1",
            "cookie": "pt1t38347bs6jc9ruv2ecpv7o2",
            "userAgent":
                "Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/20100101 Firefox/18.0"
          },
          "test": true
        } */
    )
        .onError((error, stackTrace) {
      log(error.toString());
      inCart.clear();
      throw error!;
    });
    if (response.statusCode == 200) {
      log(response.statusMessage!);
    } else {
      log(response.statusMessage!);
      throw 'Error';
    }
  }
}
