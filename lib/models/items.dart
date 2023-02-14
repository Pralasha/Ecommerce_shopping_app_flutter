import 'package:shop_it/models/product.dart';
class CartItem {
  Product? product;
  int? count;
  CartItem({
    this.product,
    this.count,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product?.toJson(),
      'count': count,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: map['product'] != null
          ? Product.fromJson(map['product'] as Map<String, dynamic>)
          : null,
      count: map['count'] != null ? map['count'] as int : null,
    );
  }
}
