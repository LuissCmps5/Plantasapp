import 'package:flutter/material.dart';

import 'Listado_de_plantas.dart';

class _PlantListPageState extends State<PlantListPage> {
  // ... Código anterior ...

  String filter = "";
  
  get plants => null;

  @override
  Widget build(BuildContext context) {
    final filteredPlants = plants.where((plant) {
      return plant['nombre_comun'].toLowerCase().contains(filter.toLowerCase()) ||
            plant['tipo'].toLowerCase().contains(filter.toLowerCase());
    }).toList();

    return Scaffold(
      // ... Código anterior ...
      body: Column(
        children: [
          // Campo de texto para el filtro
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Filtrar por nombre o tipo'),
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlants.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredPlants[index]['nombre_comun']),
                  subtitle: Text(filteredPlants[index]['nombre_cientifico']),
                  onTap: () {
                    // Similar a la lógica anterior
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


