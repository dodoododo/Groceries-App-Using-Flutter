import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(const ShopState()) {
    loadProducts();
  }

  void loadProducts() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      exclusiveOffers: [
        {"title": "Organic Bananas", "subtitle": "7pcs, Priceg", "price": 4.99, "image": "assets/images/banana.png"},
        {"title": "Red Apple", "subtitle": "1kg, Price", "price": 4.99, "image": "assets/images/apple.png"},
      ],
      bestSelling: [
        {"title": "Bell Pepper Red", "subtitle": "1kg, Price", "price": 4.99, "image": "assets/images/bell_pepper_red.png"},
        {"title": "Ginger", "subtitle": "250gm, Price", "price": 4.99, "image": "assets/images/ginger.png"},
      ],
      groceries: [
        {"title": "Beef Bone", "subtitle": "1kg, Price", "price": 4.99, "image": "assets/images/beef_bone.png"},
        {"title": "Broiler Chicken", "subtitle": "1kg, Price", "price": 4.99, "image": "assets/images/broiler_chicken.png"},
      ],
      groceriesType: [
        {"title": "Pulses", "colors": Color.fromARGB(255, 239, 209, 187), "image": "assets/images/pulses.png"},
        {"title": "Rice", "colors": Color.fromARGB(255, 200, 232, 210), "image": "assets/images/rice.png"},
      ],
      isLoading: false,
    ));
  }
}
