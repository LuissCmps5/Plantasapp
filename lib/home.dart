import 'package:flutter/material.dart';
import 'login.dart';
import 'plant_crud.dart';
import 'supabase_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Plantas'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await SupabaseService.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: PlantCRUD(), // Aquí iría el widget CRUD de plantas
    );
  }
}
