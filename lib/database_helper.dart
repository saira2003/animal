import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Animal{
  final int id;
  final String name;
  final double price;
  final String imagePath;

  Animal({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('my_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        dates TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        profile TEXT NOT NULL
      )
    ''');
    //creacion de la tabla de los animales

     await db.execute('''
      CREATE TABLE animals (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');
    await db.insert('users',
     {
      'dates':'ovinos',
      'username':'ovinos1',
      'password':'ovinos123',
      'profile': 'ovinos'
     },
    );
    await db.insert(
  'users',
  {
    'dates': 'bovinos',
    'username': 'bovinos2',
    'password': 'bovinos123',
    'profile': 'bovinos',
  },
);
await db.insert(
  'users',
  {
    'dates': 'acuicola',
    'username': 'acuicola3',
    'password': 'acuicola123',
    'profile': 'acuicola',
  },
);
await db.insert(
  'users',
  {
    'dates': 'porcinos',
    'username': 'porcinos4',
    'password': 'porcinos123',
    'profile': 'porcinos',
  },
);
  }  
   
  

  // Agregar el método para obtener la lista de animales
  Future<List<Animal>>getAnimals()async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('animals');
     return List.generate(maps.length, (i){
      return Animal(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
      );

    });
  }
  Future<void> insertAnimal(Animal animal) async {
    final db = await database;
    await db.insert(
      'animals',
      {
        'name': animal.name,
        'price': animal.price,
        'imagePath': animal.imagePath,
      },
    );
  }
}

