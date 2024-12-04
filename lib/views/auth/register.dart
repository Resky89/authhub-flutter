import 'package:flutter/material.dart';
import '../../controllers/authController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password dan Confirm Password tidak cocok')),
        );
        return;
      }

      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih gender terlebih dahulu')),
        );
        return;
      }

      final body = {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "gender": _selectedGender ?? "",
        "password": _passwordController.text,
        "phoneNumber": _phoneNumberController.text.trim(),
      };

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await AuthController.registerUser(body);

        setState(() {
          _isLoading = false;
        });

        if (response['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Registrasi berhasil!')),
          );

          // Bersihkan semua field
          _nameController.clear();
          _phoneNumberController.clear();
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          setState(() {
            _selectedGender = null;
          });
        } else if (response['error'] != null) {
          // Tampilkan pesan error spesifik jika ada
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['error'])),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Registrasi gagal')),
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan2: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Auth',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Hub',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField('Name', _nameController, (value) {
                        if (value == null || value.isEmpty) return 'Nama harus diisi';
                        if (value.length < 3) return 'Nama minimal 3 karakter';
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildTextField('Phone Number', _phoneNumberController, (value) {
                        if (value == null || value.isEmpty) return 'Nomor telepon harus diisi';
                        if (!RegExp(r'^(\+62|62|0)[0-9]{9,11}$').hasMatch(value)) {
                          return 'Format nomor telepon tidak valid';
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      const Text('Gender:', style: TextStyle(color: Colors.white)),
                      Row(
                        children: [
                          _buildRadioOption('M'),
                          _buildRadioOption('F'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildTextField('Email', _emailController, (value) {
                        if (value == null || value.isEmpty) return 'Email harus diisi';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildPasswordField('Password', _passwordController, _isPasswordVisible,
                          (bool isVisible) {
                        setState(() {
                          _isPasswordVisible = isVisible;
                        });
                      }),
                      const SizedBox(height: 20),
                      _buildPasswordField('Confirm Password', _confirmPasswordController,
                          _isConfirmPasswordVisible, (bool isVisible) {
                        setState(() {
                          _isConfirmPasswordVisible = isVisible;
                        });
                      }),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _isLoading ? null : _register,
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.black)
                              : const Text('Register', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    // Already have an account
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Already have an account? Click here',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedGender,
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
          activeColor: Colors.orange,
        ),
        Text(value == 'M' ? 'Male' : 'Female', style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool isVisible,
      void Function(bool) onVisibilityChanged) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white54,
          ),
          onPressed: () {
            onVisibilityChanged(!isVisible);
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password harus diisi';
        if (value.length < 6) return 'Password minimal 6 karakter';
        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
          return 'Harus mengandung huruf besar, kecil, dan angka';
        }
        return null;
      },
    );
  }
}
