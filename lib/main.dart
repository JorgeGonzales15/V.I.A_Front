import 'package:flutter/material.dart';
import 'package:via_2/routes_screen/routes_screen.dart';
import 'package:via_2/routes_screen/track_screen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Tu App',
      // Define la ruta inicial de la app
      initialRoute: '/emergency', // O '/home' si quieres que empiece ahí
      
      // Define todas las rutas con nombre de tu aplicación
      routes: {
        '/home': (context) => const HomeScreen(),
        '/emergency': (context) => const EmergencyScreen(),
        '/analyzing_route': (context) => const AnalyzingRouteScreen(),
      },
    );
  }
}
