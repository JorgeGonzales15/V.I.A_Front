import 'package:flutter/material.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  // Controlador para el PageView, nos permite saber en qué página estamos
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // El índice seleccionado para el BottomNavBar. Asumimos que esta es la segunda pantalla (índice 1).
  final int _selectedIndex = 1; 

  @override
  void initState() {
    super.initState();
    // Escuchamos los cambios de página para actualizar el indicador de puntos
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos el mismo Scaffold que en HomeScreen para mantener la consistencia
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E), // Fondo oscuro
      body: SafeArea(
        child: Column(
          children: [
            // --- Carousel de Tarjetas ---
            SizedBox(
              height: 380, // <<--- CAMBIO: Altura aumentada
              child: PageView(
                controller: _pageController,
                children: [
                  _buildInfoCard(
                    icon: Icons.shield_outlined,
                    title: 'Estás seguro 😉',
                  ),
                  _buildInfoCard(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('10°', style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)),
                        const Text('Temperatura ambiental', style: TextStyle(color: Colors.white, fontSize: 25)),
                        const SizedBox(height: 20),
                        const Icon(Icons.check_circle, color: Colors.green, size: 40),
                        const Text('Estado de sensor de sismo', style: TextStyle(color: Colors.white, fontSize: 25)),
                      ],
                    ),
                  ),
                  _buildInfoCard(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          const Text('Soporte', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          const Text(
                            'En caso tenga algún inconveniente o duda. Contactar con:',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'xxxxxx@gmail.com',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // --- Indicador de Página (los puntos) ---
            _buildPageIndicator(),
            
            // --- Contenido Fijo Inferior ---
            const Spacer(), // Empuja el contenido hacia abajo
            Center(
  child: const Text(
    '¿Preparado para una emergencia?',
    textAlign: TextAlign.center, // Buena práctica para textos de múltiples líneas
    style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
  ),
),
            const SizedBox(height: 20),
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // Aumenta el espacio horizontal y vertical dentro del botón
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: const Text(
        'Atrás',
        // Opcional: aumenta el tamaño del texto
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    const SizedBox(width: 15),
    ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/analyzing_route');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // Aumenta el espacio horizontal y vertical dentro del botón
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: const Text(
        'Analizar ruta',
        // Opcional: aumenta el tamaño del texto
        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  ],
),
            const SizedBox(height: 80), // Espacio para el BottomAppBar
          ],
        ),
      ),
      // --- Reutilizamos la misma configuración de la barra de navegación ---
      floatingActionButton: SizedBox(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(Icons.campaign, color: Colors.black, size: 40),
          tooltip: 'Botón de alerta',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.grey.shade900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
            _buildNavItem(icon: Icons.route, label: 'Rutas', index: 1),
            const SizedBox(width: 40),
            _buildNavItem(icon: Icons.report, label: 'Reportes', index: 2),
            _buildNavItem(icon: Icons.settings, label: 'Configuración', index: 3),
          ],
        ),
      ),
    );
  }

  // --- Widgets Auxiliares ---

  // Widget reutilizable para crear las tarjetas azules
  Widget _buildInfoCard({String? title, IconData? icon, Widget? content}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      // Se ajusta el padding para tener más espacio vertical
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.cyan.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: content ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon, size: 100, color: Colors.white),
                if (icon != null) const SizedBox(height: 20),
                if (title != null)
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
      ),
    ),
  );
}

  // Widget para crear los puntos indicadores de la página actual
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.white : Colors.grey.shade600,
          ),
        );
      }),
    );
  }
  
  // Widget para los ítems de la barra de navegación
  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.white : Colors.grey,
        size: 28,
      ),
      tooltip: label,
      onPressed: () {
        // Aquí iría la lógica de navegación real.
      },
    );
  }
}