import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     color: Colors.white,
    //     constraints: const BoxConstraints.expand(),
    //     child: Stack(
    //       children: <Widget>[
    //         SafeArea(
    //           child: Align (
    //             alignment: Alignment.topLeft,
    //             child: IconButton(
    //               icon: const Icon(Icons.arrow_back),
    //               onPressed: () {
    //                 Navigator.pop(context); // goes back
    //               },
    //             ),
    //           )
    //         ),
    //         Container(
    //           height: 300,
    //           color: Colors.redAccent,
    //         )
    //       ],
    //     ),
    //   )
    // );
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            color: Colors.white,
            child: Container(

            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );

  }
}