class ShopState {
  final List<Map<String, dynamic>> exclusiveOffers;
  final List<Map<String, dynamic>> bestSelling;
  final List<Map<String, dynamic>> groceries;
  final List<Map<String, dynamic>> groceriesType;
  final bool isLoading;

  const ShopState({
    this.exclusiveOffers = const [],
    this.bestSelling = const [],
    this.groceries = const [],
    this.groceriesType = const [],
    this.isLoading = true,
  });

  ShopState copyWith({
    List<Map<String, dynamic>>? exclusiveOffers,
    List<Map<String, dynamic>>? bestSelling,
    List<Map<String, dynamic>>? groceries,
    List<Map<String, dynamic>>? groceriesType,
    bool? isLoading,
  }) {
    return ShopState(
      exclusiveOffers: exclusiveOffers ?? this.exclusiveOffers,
      bestSelling: bestSelling ?? this.bestSelling,
      groceries: groceries ?? this.groceries,
      groceriesType: groceriesType ?? this.groceriesType,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
