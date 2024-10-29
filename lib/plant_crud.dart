import 'package:flutter/material.dart';
import 'supabase_service.dart';

class PlantCRUD extends StatefulWidget {
  @override
  _PlantCRUDState createState() => _PlantCRUDState();
}

class _PlantCRUDState extends State<PlantCRUD> {
  List<String> plants = [];
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPlants(); // Cargar plantas al iniciar
  }

  Future<void> fetchPlants() async {
    final response = await SupabaseService.getPlants();
    setState(() {
      plants = response.cast<String>();
    });
  }

  Future<void> addPlant() async {
    await SupabaseService.addPlant(textController.text);
    textController.clear();
    fetchPlants();
  }

  // Métodos para actualizar y eliminar plantas se pueden añadir aquí

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: textController, decoration: InputDecoration(labelText: 'Nueva Planta')),
        ElevatedButton(onPressed: addPlant, child: Text('Agregar Planta')),
        Expanded(
          child: ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) => ListTile(title: Text(plants[index])),
          ),
        ),
      ],
    );
  }
}
