import 'package:flutter/material.dart';
import 'package:via_2/routes_screen/routes_screen.dart';
import 'home_screen/home_screend.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí puedes configurar el tema de tu app para que los colores coincidan
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Opcional: quita la cinta de "Debug"
      theme: ThemeData(
        // Define un color primario para los elementos seleccionados, como el BottomNavBar
        primarySwatch: Colors.green, 
      ),
      // 2. Usa HomeScreen como la pantalla de inicio
      home: const EmergencyScreen(), 
    );
  }
}
