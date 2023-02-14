import 'package:get/route_manager.dart';
import 'package:shop_it/views/cart_page.dart';
import 'package:shop_it/views/first_page.dart';
import 'package:shop_it/views/home_page.dart';
import 'package:shop_it/views/signin_page.dart';
import 'package:shop_it/views/login_page.dart';
import 'package:shop_it/views/success.dart';

class RouteClass {
  static String home = '/';
  static String signPage = '/signPage';
  static String loginPage = '/loginPage';
  static String firstPage = '/firstPage';
  static String cartPage = '/cartPage';
  static String sucessPage = '/sucessPage';

  static String getHome() => home;
  static String getSign() => signPage;
  static String getLogin() => loginPage;
  static String getFirst() => firstPage;
  static String getCart() => cartPage;
  static String getSucess() => sucessPage;

  static List<GetPage> routes = [
    GetPage(page: () => HomePage(), name: home),
    GetPage(page: () => const SigninPage(), name: signPage),
    GetPage(page: () => const HomeScreen(), name: loginPage),
    GetPage(page: () => FirstPage(), name: firstPage),
    GetPage(page: () => CartPage(), name: cartPage),
    GetPage(page: () => SucessPage(), name: sucessPage),
  ];
}
