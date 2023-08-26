import 'package:flutter/material.dart';
import 'package:animal/database_helper.dart'; // Asegúrate de importar la clase DatabaseProvider y Animal

class AnimalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animales Registrados')),
      body: FutureBuilder<List<Animal>>(
        future: DatabaseProvider.instance.getAnimals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No se encontraron animales registrados.');
          } else {
            final animals = snapshot.data!;

            return ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];
                return ListTile(
                  title: Text(animal.name),
                  subtitle: Text('Precio: \$${animal.price.toStringAsFixed(2)}'),
                  // Mostrar la imagen del animal si es necesario
                );
              },
            );
          }
        },
      ),
    );
  }
}
