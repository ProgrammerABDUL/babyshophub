import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_provider.dart';
import '../../screens/registration.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoggedIn = false; // Simulated auth state
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => setState(() => isLoggedIn = false),
              tooltip: 'Logout',
            )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isLoggedIn ? _buildUserProfile() : _buildGuestBanner(),
            ),
            const SizedBox(height: 24),
            _buildAccountOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestBanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Enjoy better experience when logged in!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showLogin(),
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => _showLogin(),
                      child: const Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated login redirection
  void _showLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
          ),
          const SizedBox(height: 16),
          Text(
            'John Doe',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'john.doe@email.com',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOptions() {
    return Column(
      children: [
        _buildListTile(
          icon: Icons.dark_mode,
          title: 'Dark Mode',
          onTap: () {},
          trailing: Switch(
            value:
                Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
            onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(value),
          ),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.history,
          title: 'Order History',
          onTap: () => _handleOptionTap('Orders'),
          trailing: const Icon(Icons.chevron_right),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.location_on,
          title: 'Saved Addresses',
          onTap: () => _handleOptionTap('Addresses'),
          trailing: const Icon(Icons.chevron_right),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.payment,
          title: 'Payment Methods',
          onTap: () => _handleOptionTap('Payments'),
          trailing: const Icon(Icons.chevron_right),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.favorite,
          title: 'Wishlist',
          onTap: () => _handleOptionTap('Wishlist'),
          trailing: const Icon(Icons.chevron_right),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () => _handleOptionTap('Settings'),
          trailing: const Icon(Icons.chevron_right),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.support,
          title: 'Help & Support',
          onTap: () => _handleOptionTap('Support'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 72, color: Colors.grey[200]);
  }

  void _handleOptionTap(String option) {
    if (!isLoggedIn && option != 'Wishlist') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please login to access $option'),
        action: SnackBarAction(
          label: 'Login',
          onPressed: _showLogin,
        ),
      ));
      return;
    }
    // Handle navigation to selected option
  }
}
