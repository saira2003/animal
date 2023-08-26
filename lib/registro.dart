import 'package:animal/login.dart';
import 'package:flutter/material.dart';
import 'package:animal/database_helper.dart'; // Asegúrate de importar tu clase de manejo de base de datos

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _datesController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _register() async {
    final dates = _datesController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;

    if ( dates.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
      final db = await DatabaseProvider.instance.database;
      await db.insert(
        'users',
        {'username': username, 'password': password},
      );
      setState(() {
        _errorMessage = '';
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> LoginPage()),
      );
      // Registro exitoso, puedes redirigir a la página de inicio de sesión
      // Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = 'Completa todos los campos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 250, //ajusta el tamaño de la imagen  segun tus necesidades
              ),
              SizedBox(height: 20,),
             TextField(
                controller: _datesController,
                decoration: InputDecoration(labelText: 'Datos del usuario'),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nombre de Usuario'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _register,
                child: Text('Registrarse'),
              ),
              SizedBox(height: 8.0),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}