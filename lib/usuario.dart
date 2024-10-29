import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';  // Asegúrate de importar la página de 

class UsuarioPage extends StatelessWidget {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Cerrar sesión dentro del onPressed
              await _supabase.auth.signOut(); 
              // Redirigir al login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Bienvenido Usuario', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
