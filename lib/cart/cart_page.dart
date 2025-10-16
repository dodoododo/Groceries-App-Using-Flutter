import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shop/shop_cubit.dart';
import '../shop/shop_state.dart';
import '../explore/explore_cubit.dart';
import '../explore/explore_state.dart';
import 'cart_cubit.dart';
import 'cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => ShopCubit()),
        BlocProvider(create: (_) => ExploreCubit()),
      ],
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final shopCubit = context.watch<ShopCubit>();
    final exploreCubit = context.watch<ExploreCubit>();

    if (shopCubit.state.isLoading || exploreCubit.state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final categories = exploreCubit.state.categories;

    final foods = {
      "Fresh Fruits & Vegetable": shopCubit.state.exclusiveOffers,
      "Cooking Oil & Ghee": shopCubit.state.bestSelling,
      "Meat & Fish": shopCubit.state.groceries,
      "Bakery & Snacks": shopCubit.state.groceriesType,
    };

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final selectedFoods = foods[state.selectedFoodType] ?? [];

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("My Cart"),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.selectedFoodType,
                      isExpanded: true,
                      iconEnabledColor: Colors.white,
                      dropdownColor: Colors.green.shade400,
                      underline: const SizedBox(),

                      selectedItemBuilder: (context) {
                        return categories.map((cat) {
                          return SizedBox(
                            height: 48, 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Food Type",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  state.selectedFoodType ?? "Select food type",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList();
                      },

                      hint: SizedBox(
                        height: 48, 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Food Type",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              state.selectedFoodType ?? "Select food type",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      items: categories.map((cat) {
                        return DropdownMenuItem<String>(
                          value: cat["title"].toString(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(cat["image"], height: 35, width: 35),
                                  const SizedBox(width: 10),
                                  Text(
                                    cat["title"].toString().replaceAll("Fresh ", ""),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "Select",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) cartCubit.selectFoodType(value);
                      },
                    ),
                  ),
                ),



                const SizedBox(height: 16),

                if (state.selectedFoodType != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black, 
                          ),
                          children: [
                            const TextSpan(text: "Detail Information About "),
                            TextSpan(
                              text: state.selectedFoodType ?? "",
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _getDescription(state.selectedFoodType!, categories),
                        style: const TextStyle(
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 20),

                
                if (selectedFoods.isNotEmpty)
                Container(
                  height: 90,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.green.shade400,
                      iconEnabledColor: Colors.white,
                      isExpanded: true,
                      value: null,

                      hint: SizedBox(
                        height: 48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select item",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      style: const TextStyle(color: Colors.white),
                      items: selectedFoods.map((food) {
                        return DropdownMenuItem<String>(
                          value: food["title"],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(food["image"], height: 30, width: 30),
                                  const SizedBox(width: 10),
                                  Text(
                                    food["title"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          cartCubit.selectFood(value);
                          final selected = selectedFoods.firstWhere(
                            (f) => f["title"] == value,
                            orElse: () => <String, dynamic>{},
                          );
                          if (selected.isNotEmpty) {
                            cartCubit.addToCart(
                              foodType: state.selectedFoodType!,
                              title: selected["title"],
                              image: selected["image"],
                              price: selected["price"],
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                ..._buildCartSections(cartCubit, state),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildCartSections(CartCubit cubit, CartState state) {
    final grouped = <String, List<CartItem>>{};
    for (var item in state.cartItems) {
      grouped.putIfAbsent(item.foodType, () => []).add(item);
    }

    return grouped.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.key,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10),
          ...entry.value.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Image.asset(item.image, height: 40),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text("\$${item.price.toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.green),
                          onPressed: () => cubit.decreaseQuantity(item.title),
                        ),
                        Container(  
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item.quantity.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.green),
                          onPressed: () => cubit.increaseQuantity(item.title),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const Divider(
            thickness: 0.6,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
        ],
      );
    }).toList();
  }
  String _getDescription(String type, List categories) {
    final found = categories.firstWhere(
      (c) => c["title"].toString().contains(type),
      orElse: () => <String, dynamic>{},
    );
    return found["description"] ?? "";
  }
}
