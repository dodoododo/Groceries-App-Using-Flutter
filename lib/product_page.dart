import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;
  double price = 4.99;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🍎 Product Image
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/apple_background.png"), // your image path
                      fit: BoxFit.cover, // cover / contain / fill
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/apple.png", // change to your image path
                      height: 200,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Product Title & Favorite
                Container(
                  // padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Natural Red Apple",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "1kg, Price",
                                  style: TextStyle(color: Colors.grey, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 28,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      
                      // Quantity & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() {
                                        quantity--;
                                      });
                                    }
                                  },
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colors.green,
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: Text(
                              "\$${(price * quantity).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.grey,     // line color
                          thickness: 1,           // line thickness
                          indent: 0,              // empty space before the line
                          endIndent: 0,           // empty space after the line
                        ),
                      ),
                      // Product Detail
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: ExpansionTile(
                          shape: const Border(),            // removes border when expanded
                          collapsedShape: const Border(),   // removes border when collapsed
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
                          title: const Text(
                            "Product Detail",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5.0),
                              child: Text(
                                "Apples Are Nutritious. Apples May Be Good For Weight Loss. "
                                "Apples May Be Good For Your Heart. As Part Of A Healthful And Varied Diet.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),

                      ),
                      
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.grey,     // line color
                          thickness: 1,           // line thickness
                          indent: 0,              // empty space before the line
                          endIndent: 0,           // empty space after the line
                        ),
                      ),
                      // Nutritions
                      ListTile(
                        title: const Text("Nutritions",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                          ),
                          child: const Text("100gr"),
                        ),
                      ),
                      
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.grey,     // line color
                          thickness: 1,           // line thickness
                          indent: 0,              // empty space before the line
                          endIndent: 0,           // empty space after the line
                        ),
                      ),

                      // Review
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
                      
                      // Add to Basket
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(370, 70),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Add To Basket",
                            style:
                                TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating back button
          Positioned(
            top: 40,
            left: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
