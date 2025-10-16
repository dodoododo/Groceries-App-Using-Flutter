import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String foodType;
  final String title;
  final String image;
  final double price;
  final int quantity;

  const CartItem({
    required this.foodType,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({
    String? foodType,
    String? title,
    String? image,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      foodType: foodType ?? this.foodType,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [foodType, title, image, price, quantity];
}

class CartState extends Equatable {
  final String? selectedFoodType;
  final String? selectedFood;
  final List<CartItem> cartItems;

  const CartState({
    this.selectedFoodType,
    this.selectedFood,
    this.cartItems = const [],
  });

  CartState copyWith({
    String? selectedFoodType,
    String? selectedFood,
    List<CartItem>? cartItems,
  }) {
    return CartState(
      selectedFoodType: selectedFoodType ?? this.selectedFoodType,
      selectedFood: selectedFood ?? this.selectedFood,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [selectedFoodType, selectedFood, cartItems];
}
