import 'package:flutter/material.dart';

void main() {
  runApp(const ArmarioIaApp());
}

class ArmarioIaApp extends StatelessWidget {
  const ArmarioIaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Armario IA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _prendas = [
    'Camiseta blanca',
    'Vaqueros azules',
    'Chaqueta negra',
    'Zapatillas urbanas',
  ];

  void _agregarPrenda(String nuevaPrenda) {
    if (nuevaPrenda.isNotEmpty) {
      setState(() {
        _prendas.add(nuevaPrenda);
      });
    }
  }

  void _mostrarDialogoNuevaPrenda() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir prenda'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Ej. Sudadera gris',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _agregarPrenda(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _generarOutfitIA() {
    if (_prendas.isEmpty) return;
    _prendas.shuffle();
    final outfit = '${_prendas[0]} + ${_prendas.length > 1 ? _prendas[1] : _prendas[0]}';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome, color: Colors.deepPurple, size: 40),
              const SizedBox(height: 12),
              const Text(
                'Sugerencia de Outfit IA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                outfit,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Armario IA'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Generar Outfit',
            onPressed: _generarOutfitIA,
          ),
        ],
      ),
      body: _prendas.isEmpty
          ? const Center(child: Text('No hay prendas registradas.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _prendas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.checkroom, color: Colors.deepPurple),
                    title: Text(_prendas[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _prendas.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarDialogoNuevaPrenda,
        icon: const Icon(Icons.add),
        label: const Text('Añadir Prenda'),
      ),
    );
  }
}