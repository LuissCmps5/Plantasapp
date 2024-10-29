# 	Aplicación de Gestión de Cuidado de Plantas
<img src="https://upen.milaulas.com/pluginfile.php/1/core_admin/logocompact/300x300/1647098022/89925310_2623778167869379_5016977600837320704_n.jpg" alt="Descripción de la imagen" width="600">
<p><strong>Your Name </strong>Luis Enrique Campos Ontiveros, Diego Llamas Alcantar </p>
<p><strong>Course:</strong> Mobile Applications 2</p>
<p><strong>Submission: </strong>October 28, 2024</p>
<p><strong>Instructor's Name: </strong> Carlos Alberto Iriarte Mrtinez</p>
<h1> Introduction</h1>

<p>This application is designed to help users manage the care of their plants. Users can register each plant, view relevant information, and receive reminders for tasks such as watering, pruning, and other maintenance activities.</p>

<p>The application includes authentication via Supabase. There are two types of roles:</p>
<ul>
  <li><strong>User:</strong> can view plants and their care tasks.</li>
  <li><strong>Administrator:</strong> has permissions to create, modify, view, and delete plants and tasks. Additionally, the administrator can add new plant species to the database.</li>
</ul>

<p>Each plant includes detailed information such as common name, scientific name, family or species, type of plant (vegetable or fruit), size, and distinctive features. To make searching easier, users can apply filters by species or type of plant.</p>
<h1> Application Objective</h1>
<p>
    The plant care management application aims to allow users to register their plants and receive notifications on how to take proper care of them For this, it includes authentication with Supabase that allows for two different roles users who can view their plants and administrators who have the ability to create modify view and delete plants In addition the application will feature a CRUD system to manage plants and care tasks such as watering or pruning Each plant must include information such as its common name scientific name family or species type of plant which can be vegetable or fruit size and a distinctive characteristic It will also implement the option to filter plants by species or type which will facilitate the search and management of them Administrators will have the authority to add new plant species to the system thus enriching the database and enhancing the user experience
</p>
<h1>System Requirements for the Plant Care Management Application</h1>
<p>
    The application will be developed using Flutter, allowing for an attractive and functional user interface on both iOS and Android devices. Authentication will be implemented with Supabase to manage user access. There will be a user role for users to view their plants and an administrator role that will allow creating, modifying, viewing, and deleting plants.
</p>
<p>
    A database will store information about the plants and care tasks. Each plant entry must include its common name, scientific name, family or species, type of plant which can be a vegetable or fruit, size, and distinctive characteristic.
</p>
<p>
    There will be a CRUD system to allow administrators to manage the plants and care tasks such as watering and pruning, as well as an option for administrators to add new plant species to the system.
</p>
<p>
    Filters will be implemented so that users can search for plants by species or type, facilitating the management and search for them. Additionally, there will be a notification system to inform users about the proper care of their plants.
</p>
<h1>Application Description</h1>
<p>
    The plant care management application allows users to register their plants and receive notifications on proper care
</p>
<p>
    The application includes authentication with Supabase
    There will be a user role that allows users to view their plants and an administrator role that allows creating modifying viewing and deleting plants
</p>
<p>
    There will be a CRUD system to manage the plants and care tasks such as watering and pruning
    Each plant must contain its common name scientific name family or species type of plant which can be vegetable or fruit size and distinctive characteristic
</p>
<p>
    Administrators will have the ability to add new plant species to the system
    Additionally a filter will be implemented so that users can search for plants by species or type
</p>
  <h1>Source Code</h1>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
</head>
<body>
    <h2>Login</h2>
    <pre>
        <code class="language-dart">
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'administrador.dart';
import 'usuario.dart';
import 'registro.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future&lt;void&gt; _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      // Autenticación con correo y contraseña
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response != null) {
        // Obtener el perfil del usuario y su rol
        final userId = response.user!.id;
        final profile = await _supabase
            .from('profiles')
            .select('role')
            .eq('id', userId)
            .single();

        final role = profile['role'];

        // Redirigir según el rol
        if (role == 'Administrador') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdministradorPage()),
          );
        } else if (role == 'Usuario') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UsuarioPage()),
          );
        } else {
          throw 'Rol no reconocido';
        }
      }
    } catch (error) {
      print('Error de autenticación: $error');
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar Sesión'),
            ),
            ElevatedButton(onPressed: () {
            // Navega a la página de registro
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
          child: Text('Ir a Registro'),)
          ],
        ),
      ),
    );
  }
}
        </code>
    </pre>
</body>
</html>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
    <h1>Administrador</h1>
    <pre>
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';  // Asegúrate de importar la página de login

class AdministradorPage extends StatelessWidget {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página del Administrador'),
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
        child: Text('Bienvenido Diseñador', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
    </pre>
</body>
</html>

