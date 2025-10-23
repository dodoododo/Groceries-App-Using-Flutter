import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_page.dart';
import 'account_cubit.dart';
import 'account_state.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountCubit(),
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator(color: Colors.green)),
            ),
            failure: (errorMessage) => Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            success: (user) => Scaffold( 
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const SizedBox(width: 16),
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            user.avatarUrl ?? 
                            "https://ui-avatars.com/api/?name=${user.username ?? 'User'}"
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user.name ?? user.username ?? 'Unknown User',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email, 
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Expanded(
                      child: ListView(
                        children: const [
                          Divider(color: Color.fromARGB(255, 194, 190, 190)),
                          _AccountTile(icon: Icons.shopping_bag_outlined, title: "Orders"),
                          _AccountTile(icon: Icons.card_giftcard, title: "My Details"),
                          _AccountTile(icon: Icons.location_on_outlined, title: "Delivery Address"),
                          _AccountTile(icon: Icons.credit_card_outlined, title: "Payment Methods"),
                          _AccountTile(icon: Icons.airplane_ticket_outlined, title: "Promo Code"),
                          _AccountTile(icon: Icons.notifications_none, title: "Notifications"),
                          _AccountTile(icon: Icons.help_outline, title: "Help"),
                          _AccountTile(icon: Icons.info_outline, title: "About"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: 160,
                      height: 50,
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.green.shade600, width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => _showLogoutDialog(context),
                          icon: const Icon(Icons.logout, color: Colors.green),
                          label: const Text(
                            "Log Out",
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final cubit = context.read<AccountCubit>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Log Out", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("No", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              Navigator.pop(ctx);
              await cubit.logout();
              if (context.mounted) {
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              }
            },
            child: const Text("Yes", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _AccountTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, color: Color.fromARGB(255, 200, 200, 200)),
      shape: const Border(
        bottom: BorderSide(color: Color.fromARGB(255, 194, 190, 190)),
      ),
      onTap: () {},
    );
  }
}