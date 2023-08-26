import 'package:animal/database_helper.dart';
import 'package:animal/registro.dart';
import 'package:flutter/material.dart';
import 'ovinos_page.dart';// Agrega esta línea para importar la vista OvinosPage
import 'bovinos_page.dart';
import 'porcino_page.dart';
import 'acuicola_page.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();
  
  String _errorMessage = '';

  void _login() async {
    final username = _usernameController.text; // 0 'bovinos2' 0 'acuicola3' 0  'porcinos4'
    final password = _passwordController.text; // 0 'bovinos123' 0 'acuicola123' 0  'porcinos123'
    final profile = _profileController.text; // 0 'bovinos' 0 'acuicola' 0  'porcinos'

    final db = await DatabaseProvider.instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',// verificar para cada tipo de usuario
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      final userProfile = result[3]['profile'];
      // Verifica el perfil del usuario y redirige a la página correspondiente
   
      //ovinos 
switch (userProfile) {
  case 'ovinos':
    print("Navigating to OvinosPage");
   Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => OvinosPage()),
);
    break;
  case 'porcinos':
    print("Navigating to PorcinoPage");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => porcinoPage()),
    );
    break;
   case 'bovinos':
    print("Navigating to bovinosPage");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => bovinoPage()),
    );
    break;

    case 'acuicola':
    print("Navigating to acuicolaPage");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => acuicolaPage()),
    );
    break;  
  // ... Repeat for other cases
  default:
    print("Unrecognized profile");
    setState(() {
      _errorMessage = 'Perfil no reconocido';
    });
    break;
}

   } else {
      setState(() {
        _errorMessage = 'Credenciales incorrectas';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio de Sesión')),
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
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 8.0),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Color.fromARGB(171, 26, 16, 141),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterPage()));
                  },
                  child: const Text(
                    "Registrarse",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}