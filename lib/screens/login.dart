 import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function(String email, String password) onLogin;

  const LoginScreen({super.key, required this.onLogin});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

enum AuthMode { login, register }

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  AuthMode _mode = AuthMode.login;
  late TabController _tabController;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() => _mode = AuthMode.login);
      } else {
        setState(() => _mode = AuthMode.register);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  void _onStart() {
    final email = _email.text.trim();
    final password = _pwd.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email və şifrə boş ola bilməz!')),
      );
      return;
    }

    if (_mode == AuthMode.login) {
      if (email == "admin@energyx.com" && password == "1234") {
        widget.onLogin(email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email və ya şifrə səhvdir!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Qeydiyyat uğurla tamamlandı: $email")),
      );
    }
  }

  void _onGoogleSignIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google ilə daxil ol (demo).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          const Center(
            child: Text(
              '⚡ EnerjiX',
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF00C853),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF00C853),
              labelColor: const Color(0xFF263238),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Daxil ol'),
                Tab(text: 'Qeydiyyat'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _pwd,
            decoration: const InputDecoration(
              labelText: 'Şifrə',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.login),
            label: const Text('Google ilə daxil ol'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: _onGoogleSignIn,
          ),
          const SizedBox(height: 6),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Şifrə bərpası linki (demo)')),
            ),
            child: const Text('Şifrəni unutmusunuz?'),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _onStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Başla',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
