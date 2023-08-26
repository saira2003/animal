import 'package:flutter/material.dart';
import 'package:animal/login.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Página Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Bienvenido! Has iniciado sesión correctamente.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context)=> LoginPage()),
                  );
                // Aquí podrías implementar el cierre de sesión y redirigir a la página de inicio de sesión
                // Navigator.pushReplacement(...)
              },
              child: Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}