import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void selectFoodType(String type) {
    emit(state.copyWith(selectedFoodType: type, selectedFood: null));
  }

  void selectFood(String foodName) {
    emit(state.copyWith(selectedFood: foodName));
  }

  void addToCart({
    required String foodType,
    required String title,
    required String image,
    required double price,
  }) {
    final existingIndex = state.cartItems.indexWhere((i) => i.title == title);

    if (existingIndex != -1) {
      final updated = List<CartItem>.from(state.cartItems);
      final item = updated[existingIndex];
      updated[existingIndex] =
          item.copyWith(quantity: item.quantity + 1);
      emit(state.copyWith(cartItems: updated));
    } else {
      emit(state.copyWith(
        cartItems: [
          ...state.cartItems,
          CartItem(
            foodType: foodType,
            title: title,
            image: image,
            price: price,
            quantity: 1,
          ),
        ],
      ));
    }
  }

  void increaseQuantity(String title) {
    final updated = state.cartItems.map((item) {
      if (item.title == title) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(cartItems: updated));
  }

  void decreaseQuantity(String title) {
    final updated = state.cartItems
        .map((item) {
          if (item.title == title) {
            if (item.quantity > 1) {
              return item.copyWith(quantity: item.quantity - 1);
            }
            return null; 
          }
          return item;
        })
        .whereType<CartItem>()
        .toList();
    emit(state.copyWith(cartItems: updated));
  }
}
