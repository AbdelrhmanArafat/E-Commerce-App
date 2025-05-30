class ApiPaths {
  static String products() => 'products/';
  static String deliveryMethod() => 'deliveryMethod/';
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid, String cartId) =>
      'users/$uid/cart/$cartId';
  static String myProductCart(String uid) => 'users/$uid/cart/';
  static String userShippingAddress(String uid) =>
      'users/$uid/shippingAddress/';
  static String newAddress(String uid, String addressId) =>
      'users/$uid/shippingAddress/$addressId';
}
