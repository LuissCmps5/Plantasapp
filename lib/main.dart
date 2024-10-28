import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nusnfloqgrgssxfvmkeo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im51c25mbG9xZ3Jnc3N4ZnZta2VvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0OTIxNjksImV4cCI6MjA0NDA2ODE2OX0.dkbMLuU70LiN5dgcZcsy5WC16ZMwLRCPukSVvNWXUIs',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Cuidado de Plantas',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(),
    );
  }
}
