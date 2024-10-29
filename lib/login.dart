import 'package:flutter/material.dart';
import 'package:plantasapp/supabase_service.dart';
import 'register.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final response = await SupabaseService.login(
      emailController.text,
      passwordController.text,
    );
    if (response) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error en la autenticación')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Contraseña'), obscureText: true),
            ElevatedButton(onPressed: login, child: Text('Iniciar Sesión')),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage())), child: Text('Registrarse')),
          ],
        ),
      ),
    );
  }
}