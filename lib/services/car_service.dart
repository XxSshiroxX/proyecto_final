import '../models/Cart.dart';
import '../models/Product.dart';

class CartService {
  static final List<Cart> _cartItems = [];

  // Obtener todos los productos en el carrito
  static List<Cart> getCartItems() {
    return _cartItems;
  }

  // Agregar un producto al carrito
  static void addToCart(Product product) {
    // Verifica si el producto ya está en el carrito
    Cart? existingCartItem;
    try {
      existingCartItem =
          _cartItems.firstWhere((item) => item.product.id == product.id);
    } catch (e) {
      existingCartItem = null;
    }

    if (existingCartItem != null) {
      // Si ya existe, incrementa la cantidad
      existingCartItem.numOfItem++;
    } else {
      // Si no existe, agrega un nuevo producto al carrito
      _cartItems.add(Cart(product: product, numOfItem: 1));
    }
  }

  // Eliminar un producto del carrito
  static void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  // Actualizar la cantidad de un producto en el carrito
  static void updateQuantity(String productId, int quantity) {
    Cart? cartItem;
    try {
      cartItem = _cartItems.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      cartItem = null;
    }

    if (cartItem != null) {
      cartItem.numOfItem = quantity;
      if (cartItem.numOfItem <= 0) {
        // Si la cantidad es 0 o menor, elimina el producto del carrito
        removeFromCart(productId);
      }
    }
  }

  // Calcular el total del carrito
  static double calculateTotal() {
    return _cartItems.fold(
        0, (total, item) => total + (item.product.price * item.numOfItem));
  }

  // Limpiar el carrito
  static void clearCart() {
    _cartItems.clear();
  }
}
