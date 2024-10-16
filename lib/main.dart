import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'administrador.dart';
import 'usuario.dart';

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
      title: 'CRUD App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [];
  TextEditingController textController = TextEditingController();
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de cuidado de plantas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Ingrese un elemento',
              ),
              onSubmitted: (value) {
                // Crear
                if (value.isNotEmpty) {
                  setState(() {
                    items.add(value);
                    textController.clear();
                  });
                }
              },
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Crear
                  if (textController.text.isNotEmpty) {
                    setState(() {
                      items.add(textController.text);
                      textController.clear();
                    });
                  }
                },
                child: Text('Crear'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Actualizar
                  if (selectedIndex != null) {
                    setState(() {
                      items[selectedIndex!] = textController.text;
                      textController.clear();
                      selectedIndex = null;
                    });
                  }
                },
                child: Text('Actualizar'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Eliminar
                  if (selectedIndex != null && selectedIndex! < items.length) {
                    setState(() {
                      items.removeAt(selectedIndex!);
                      textController.clear();
                      selectedIndex = null;
                    });
                  }
                },
                child: Text('Eliminar'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    // Leer y seleccionar para actualizar/eliminar
                    setState(() {
                      textController.text = items[index];
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}