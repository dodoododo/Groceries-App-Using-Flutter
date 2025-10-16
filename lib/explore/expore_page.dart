import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'explore_cubit.dart';
import 'explore_state.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExploreCubit(),
      child: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Find Products",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
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
                    Expanded(
                      child: GridView.builder(
                        itemCount: state.categories.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<ExploreCubit>().selectCategory();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: category["color"],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: category["borderColor"]),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    category["image"],
                                    height: 130,
                                    width: 70,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    category["title"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
