import 'package:flutter/material.dart';
import 'package:animal/database_helper.dart';
import 'package:image_picker/image_picker.dart';




class acuicolaPage extends StatefulWidget {
  @override
  _acuicolaPageState createState() => _acuicolaPageState();
}

class _acuicolaPageState extends State<acuicolaPage> {
  final TextEditingController _animalNameController = TextEditingController();
  final TextEditingController _animalPriceController = TextEditingController();
  XFile? _selectedImage; // Declaración de la variable para la imagen seleccionada

   Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery); // Puedes cambiar a ImageSource.camera si lo deseas
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  void _addAnimal() async{
    final animalName = _animalNameController.text;
    final animalPrice = double.tryParse(_animalPriceController.text) ?? 0.0;
     final imagePath = _selectedImage?.path ?? '';

      if (animalName.isNotEmpty && animalPrice > 0) {
    final newAnimal = Animal(id: 0, name: animalName, price: animalPrice, imagePath: imagePath);
      
    try {
      await DatabaseProvider.instance.insertAnimal(newAnimal); 
      // Aquí puedes realizar cualquier acción que necesites después de la inserción
      // Por ejemplo, redirigir a una nueva pantalla o actualizar la lista de animales
    } catch(error) {
      // Manejo de errores si la inserción falla
      print('Error al insertar el animal: $error');
    }
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Animal Ovino')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _animalNameController,
              decoration: InputDecoration(labelText: 'Nombre del Animal'),
            ),
            TextField(
              controller: _animalPriceController,
              decoration: InputDecoration(labelText: 'Precio del Animal'),
              keyboardType: TextInputType.number,
            ),
            // TODO: Agregar campos para manejar imágenes
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addAnimal,
              child: Text('Agregar Animal'),
            ),
          ],
        ),
      ),
    );
  }
}
