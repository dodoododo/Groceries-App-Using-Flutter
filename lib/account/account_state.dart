import 'package:equatable/equatable.dart';

class AccountState extends Equatable {
  final String name;
  final String email;
  final String avatarUrl;
  final bool isLoading;
  final String? errorMessage;

  const AccountState({
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.isLoading = false,
    this.errorMessage,
  });

  AccountState copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AccountState(
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [name, email, avatarUrl, isLoading, errorMessage];
}
