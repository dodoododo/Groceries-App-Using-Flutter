import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit()
      : super(
          ExploreState(
            categories: const [
              {
                "title": "Fresh Fruits & Vegetable",
                "image": "assets/images/fresh_food_n_vegetables.png",
                "color": Color(0xFFDFF5E3),
                "borderColor": Color.fromARGB(255, 182, 241, 193),
                "description": "High in vitamins (especially vitamin C and folate), dietary fiber and various antioxidants. Support immune function, aid digestion, and help reduce chronic‑disease risk. Rich in fiber, vitamins A, K, folate, and minerals like potassium and magnesium.",
              },
              {
                "title": "Cooking Oil & Ghee",
                "image": "assets/images/cooking_oil_n_ghee.png",
                "color": Color(0xFFFFF3E0),
                "borderColor": Color.fromARGB(255, 244, 216, 165),
                "description": "Provide essential fatty acids and fat-soluble vitamins (A, D, E, and K). Support brain health, hormone production, and overall cellular function. Help absorb fat-soluble vitamins from other foods.",
              },
              {
                "title": "Meat & Fish",
                "image": "assets/images/meat_n_fish.png",
                "color": Color(0xFFFFE0E0),
                "borderColor": Color.fromARGB(255, 244, 165, 165),
                "description": "Excellent source of high-quality protein, essential for muscle growth and repair. Rich in vitamins (B12, niacin, B6) and minerals (iron, zinc, selenium) that support energy production, immune function, and overall health.",
              },
              {
                "title": "Bakery & Snacks",
                "image": "assets/images/bakery_n_snack.png",
                "color": Color(0xFFF3E5F5),
                "borderColor": Color.fromARGB(255, 231, 165, 244),
                "description": "Provide quick energy from carbohydrates, which are the body's primary fuel source. Can be a source of fiber (if whole grain) and some vitamins and minerals, depending on the ingredients used.",
              },
              {
                "title": "Dairy & Eggs",
                "image": "assets/images/dairy_n_eggs.png",
                "color": Color(0xFFFFF9C4),
                "borderColor": Color.fromARGB(255, 233, 229, 175),
                "description": "Rich in calcium, vitamin D, and protein, essential for strong bones and teeth. Provide B vitamins (B12, riboflavin) that support energy metabolism and overall health.",
              },
              {
                "title": "Beverages",
                "image": "assets/images/beverages.png",
                "color": Color(0xFFE1F5FE),
                "borderColor": Color.fromARGB(255, 175, 209, 242),
                "description": "Hydrate the body and support overall bodily functions. Can provide essential nutrients (vitamins, minerals, antioxidants) depending on the type of beverage.",
              },
            ],
          ),
        );

  Future<void> selectCategory() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(isLoading: false));
  }
}
