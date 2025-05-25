class ApiPaths {
  static String products() => 'products/';
  static String deliveryMethod() => 'deliveryMethod/';
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid, String cartId) => 'users/$uid/cart/$cartId';
  static String myProductCart(String uid) => 'users/$uid/cart/';
}