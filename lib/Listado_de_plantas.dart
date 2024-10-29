import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlantListPage extends StatefulWidget {
  @override
  _PlantListPageState createState() => _PlantListPageState();
}

class _PlantListPageState extends State<PlantListPage> {
  List<dynamic> plants = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _scientificNameController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _distinctiveFeatureController = TextEditingController();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    fetchPlants();
  }

  Future<void> fetchPlants() async {
    final response = await Supabase.instance.client.from('plants').select().execute();
    if (response.error == null) {
      setState(() {
        plants = response.data;
      });
    } else {
      print('Error fetching plants: ${response.error!.message}');
    }
  }

  Future<void> addPlant() async {
    final response = await Supabase.instance.client.from('plants').insert({
      'nombre_comun': _nameController.text,
      'nombre_cientifico': _scientificNameController.text,
      'familia': _familyController.text,
      'tipo': _typeController.text,
      'tamaño': _sizeController.text,
      'caracteristica_distintiva': _distinctiveFeatureController.text,
    }).execute();

    if (response.error == null) {
      fetchPlants();
      clearInputs();
    } else {
      print('Error adding plant: ${response.error!.message}');
    }
  }

  Future<void> updatePlant(String id) async {
    final response = await Supabase.instance.client.from('plants').update({
      'nombre_comun': _nameController.text,
      'nombre_cientifico': _scientificNameController.text,
      'familia': _familyController.text,
      'tipo': _typeController.text,
      'tamaño': _sizeController.text,
      'caracteristica_distintiva': _distinctiveFeatureController.text,
    }).eq('id', id).execute();

    if (response.error == null) {
      fetchPlants();
      clearInputs();
    } else {
      print('Error updating plant: ${response.error!.message}');
    }
  }

  Future<void> deletePlant(String id) async {
    final response = await Supabase.instance.client.from('plants').delete().eq('id', id).execute();
    if (response.error == null) {
      fetchPlants();
    } else {
      print('Error deleting plant: ${response.error!.message}');
    }
  }

  void clearInputs() {
    _nameController.clear();
    _scientificNameController.clear();
    _familyController.clear();
    _typeController.clear();
    _sizeController.clear();
    _distinctiveFeatureController.clear();
    selectedIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Plantas')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nombre Común')),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(controller: _scientificNameController, decoration: InputDecoration(labelText: 'Nombre Científico')),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(controller: _familyController, decoration: InputDecoration(labelText: 'Familia')),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(controller: _typeController, decoration: InputDecoration(labelText: 'Tipo')),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(controller: _sizeController, decoration: InputDecoration(labelText: 'Tamaño')),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(controller: _distinctiveFeatureController, decoration: InputDecoration(labelText: 'Características Distintivas')),
          ),
          Row(
            children: [
              ElevatedButton(onPressed: addPlant, child: Text('Agregar')),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (selectedIndex != null) {
                    updatePlant(plants[selectedIndex!]['id']);
                  }
                },
                child: Text('Actualizar'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (selectedIndex != null) {
                    deletePlant(plants[selectedIndex!]['id']);
                  }
                },
                child: Text('Eliminar'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(plants[index]['nombre_comun']),
                  subtitle: Text(plants[index]['nombre_cientifico']),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      _nameController.text = plants[index]['nombre_comun'];
                      _scientificNameController.text = plants[index]['nombre_cientifico'];
                      _familyController.text = plants[index]['familia'];
                      _typeController.text = plants[index]['tipo'];
                      _sizeController.text = plants[index]['tamaño'];
                      _distinctiveFeatureController.text = plants[index]['caracteristica_distintiva'];
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

extension on PostgrestFilterBuilder {
  execute() {}
}

extension on PostgrestFilterBuilder<PostgrestList> {
  execute() {}
}
