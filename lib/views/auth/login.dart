import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Hub',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://localhost:3000/api/auth');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle the successful login response
      print('Login successful: ${data['message']}');
      print('Access token: ${data['data']['accessToken']}');
      print('Refresh token: ${data['data']['refreshToken']}');
      print('User details: ${data['data']['user']}');
    } else {
      // Handle the login error
      print('Login failed: ${response.statusCode} - ${response.body}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', width: 100, height: 100),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
