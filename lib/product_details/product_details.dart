import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_details_cubit.dart';
import 'product_details_state.dart';

class ProductDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final double price;

  const ProductDetails({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit(),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            image,
                            height: 400,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Title + Favorite
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(subtitle,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 16)),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                state.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: state.isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                                size: 28,
                              ),
                              onPressed: cubit.toggleFavorite,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Quantity + Price
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: cubit.decreaseQuantity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      state.quantity.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        color: Colors.green),
                                    onPressed: cubit.increaseQuantity,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "\$${(price * state.quantity).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),

                      // Product Detail
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ExpansionTile(
                          shape: const Border(),
                          collapsedShape: const Border(),
                          tilePadding: EdgeInsets.zero,
                          title: const Text("Product Detail",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "This product is fresh and healthy. "
                                "Perfect for your daily meals and nutrition.",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),

                      ListTile(
                        title: const Text("Nutritions",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                          ),
                          child: const Text("100gr"),
                        ),
                      ),
                      const Divider(),

                      ListTile(
                        title: const Text("Review",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            5,
                            (index) => const Icon(Icons.star,
                                color: Colors.orange, size: 20),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Add To Basket",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Back Button
                Positioned(
                  top: 40,
                  left: 16,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
