import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final client = Supabase.instance.client;

  // Método para iniciar sesión
  static Future<bool> login(String email, String password) async {
    try {
      final response = await client.auth.signInWithPassword(email: email, password: password);
      return response.user != null;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  // Método para registrar un nuevo usuario
  static Future<bool> register(String email, String password) async {
    try {
      final response = await client.auth.signUp(email: email, password: password);
      return response.user != null;
    } catch (e) {
      print("Registration error: $e");
      return false;
    }
  }

  // Método para cerrar sesión
  static Future<void> logout() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      print("Logout error: $e");
    }
  }

  // Método para obtener plantas
  static Future<List<Map<String, dynamic>>> getPlants() async {
    try {
      final response = await client.from('plants').select();
      return (response as List<dynamic>).map((item) => item as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching plants: $e");
      return [];
    }
  }

  // Método para agregar una planta
  static Future<void> addPlant(String name) async {
    try {
      await client.from('plants').insert({'name': name});
    } catch (e) {
      print("Error adding plant: $e");
    }
  }

  // Aquí puedes añadir métodos para actualizar y eliminar plantas si es necesario
}
