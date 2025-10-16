import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../product_details/product_details.dart';
import 'shop_cubit.dart';
import 'shop_state.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShopCubit(),
      child: const _ShopView(),
    );
  }
}

class _ShopView extends StatefulWidget {
  const _ShopView({super.key});

  @override
  State<_ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<_ShopView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              title: product["title"],
              subtitle: product["subtitle"],
              image: product["image"],
              price: product["price"],
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color.fromARGB(255, 229, 226, 226)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(product["image"], fit: BoxFit.contain, height: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(product["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(product["subtitle"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${product["price"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const Text("See all", style: TextStyle(color: Colors.green)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) => buildProductCard(items[index]),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: 370,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search Store",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/images/fresh_vegetables.png", width: 370),
                  const SizedBox(height: 20),
                  buildSection("Exclusive Offer", state.exclusiveOffers),
                  buildSection("Best Selling", state.bestSelling),
                  buildSection("Groceries", state.groceries),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
