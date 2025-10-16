import 'package:equatable/equatable.dart';

class ProductDetailsState extends Equatable {
  final int quantity;
  final bool isFavorite;

  const ProductDetailsState({
    this.quantity = 1,
    this.isFavorite = false,
  });

  ProductDetailsState copyWith({
    int? quantity,
    bool? isFavorite,
  }) {
    return ProductDetailsState(
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [quantity, isFavorite];
}
