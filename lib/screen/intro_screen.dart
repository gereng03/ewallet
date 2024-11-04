import 'package:flutter/material.dart';
import 'package:zalo2222/screen/signin_screen.dart';
import 'package:zalo2222/screen/signup_screen.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              _buildLogo(),
              const Spacer(),
              _buildActionButtons(),
              _buildTermsText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logos/logo.png',
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 0),
        const Text(
          'E-Wallet',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ví điện tử thông minh',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Đăng nhập',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.green),
            ),
            child: const Text(
              'Đăng ký',
              style: TextStyle(fontSize: 16, color: Colors.green),

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        'Bằng việc sử dụng E-Wallet, bạn đồng ý với Điều khoản sử dụng và Chính sách bảo mật của E-Wallet',
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}