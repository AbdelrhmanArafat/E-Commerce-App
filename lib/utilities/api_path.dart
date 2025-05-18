class ApiPaths {
  static String products() => 'products/';
  static String user(String uid) => 'users/$uid';

  static String addToCart(String uid, String cartId) => 'users/$uid/cart/$cartId';
}