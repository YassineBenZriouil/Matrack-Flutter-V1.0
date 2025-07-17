import 'package:flutter/material.dart';
import 'scan_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;
  String _role = 'Agent'; // Default role

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    // MOCK login: accept any non-empty credentials
    Future.delayed(Duration(seconds: 1), () {
      setState(() => _isLoading = false);
      if (_username == 'admin' && _password == 'admin') {
        Navigator.pushReplacementNamed(context, '/home', arguments: {'role': _role, 'username': _username});
      } else if (_username.isNotEmpty && _password.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/home', arguments: {'role': _role, 'username': _username});
      } else {
        setState(() => _errorMessage = 'Identifiants invalides.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0D47A1);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.directions_car, size: 72, color: primaryColor),
              SizedBox(height: 16),
              Text(
                'Matricule Checker',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 32),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Identifiant',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (val) =>
                              val == null || val.isEmpty ? 'Champ requis' : null,
                          onSaved: (val) => _username = val ?? '',
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                          validator: (val) =>
                              val == null || val.isEmpty ? 'Champ requis' : null,
                          onSaved: (val) => _password = val ?? '',
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _role,
                          decoration: InputDecoration(
                            labelText: 'Rôle',
                            prefixIcon: Icon(Icons.security),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: ['Admin', 'Agent']
                              .map((role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _role = val ?? 'Agent';
                            });
                          },
                        ),
                        SizedBox(height: 24),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                        _isLoading
                            ? CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: _submit,
                                  child: Text(
                                    'Se connecter',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
