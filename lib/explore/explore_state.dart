import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ExploreState extends Equatable {
  final List<Map<String, dynamic>> categories;
  final bool isLoading;

  const ExploreState({
    required this.categories,
    this.isLoading = false,
  });

  ExploreState copyWith({
    List<Map<String, dynamic>>? categories,
    bool? isLoading,
  }) {
    return ExploreState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [categories, isLoading];
}
