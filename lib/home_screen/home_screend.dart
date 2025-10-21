import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Para controlar la pestaña activa del BottomNavBar
  bool _showConnectionStatus = true;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
@override
  void initState() {
    super.initState();
    // 2. INICIA EL TEMPORIZADOR
    // Después de 3 segundos, ocultamos la notificación.
    Future.delayed(const Duration(seconds: 3), () {
      // Usamos setState para que la UI se reconstruya con el nuevo valor.
      if (mounted) { // Buena práctica: comprueba que el widget todavía existe.
        setState(() {
          _showConnectionStatus = false;
        });
      }
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // O el color de fondo que prefieras
      body: SafeArea(
        child: ListView( // Usamos ListView para que sea scrollable si el contenido crece
          padding: const EdgeInsets.all(20.0),
          children: [
            // Aquí irán todos los widgets del cuerpo
            _buildConnectionStatus(),
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 30),
            _buildRegisterRouteButton(),
            const SizedBox(height: 40),
            _buildSavedRoutesSection(),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
  width: 70.0,  // Ancho del botón
  height: 70.0, // Alto del botón
  child: FloatingActionButton(
    onPressed: () {
      // Acción del botón de pánico/alerta
    },
    backgroundColor: Colors.white,
    shape: const CircleBorder(),
    tooltip: 'Botón de alerta',
    child: const Icon(
      Icons.campaign,
      color: Colors.black,
      size: 40, // Aumentamos el tamaño del ícono
    ),
  ),
),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    // AQUI ESTÁ EL CAMBIO PRINCIPAL
    bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(), // Mantiene el hueco para el botón
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
          _buildNavItem(icon: Icons.route, label: 'Rutas', index: 1),
          const SizedBox(width: 40), // Espacio para el botón flotante
          _buildNavItem(icon: Icons.report, label: 'Reportes', index: 2),
          _buildNavItem(icon: Icons.settings, label: 'Configuración', index: 3),
        ],
      ),
    ),
  );
}

Widget _buildConnectionStatus() {
return AnimatedOpacity(
      // La opacidad será 1 (visible) o 0 (invisible) según el estado
      opacity: _showConnectionStatus ? 1.0 : 0.0,
      // Duración de la animación de fade
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Conectado con pulsera',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
}

Widget _buildHeader() {
  return const Text(
    'Hola, Jorge',
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    // Etiqueta semántica para que el lector de pantalla no lea "coma"
    semanticsLabel: "Hola Jorge",
  );
}

// Añade este método dentro de _HomeScreenState

Widget _buildRegisterRouteButton() {
  return ElevatedButton(
    onPressed: () {
      // Navegar a la pantalla de registro de ruta
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2C2C2E), // Color oscuro del diseño
      padding: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    // Usamos Semantics para que el lector lea todo el botón como una sola entidad
    child: Semantics(
      label: "Botón para registrar una nueva ruta segura",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shield_outlined, color: Colors.white, size: 40),
          const SizedBox(width: 15),
          const Text(
            'REGISTRA TU\nRUTA SEGURA',
            style: TextStyle(color: Colors.white, fontSize: 18, height: 1.2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}


// Widget para cada item de la barra para no repetir código
Widget _buildNavItem({required IconData icon, required String label, required int index}) {
  final isSelected = _selectedIndex == index;
  // Usamos un IconButton por su simplicidad y área de toque adecuada
  return IconButton(
    icon: Icon(
      icon,
      color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
      size: 28,
    ),
    // La etiqueta de accesibilidad es crucial
    tooltip: label, 
    onPressed: () => _onItemTapped(index),
  );
}

Widget _buildSavedRoutesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Rutas guardadas',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 15),
      // Aquí iría una lista real de datos
      _RouteCard(routeName: 'Casa al Trabajo', distance: '2.5 km'),
      const SizedBox(height: 10),
      _RouteCard(routeName: 'Parque cercano', distance: '800 m'),
    ],
  );
}

}

class _RouteCard extends StatelessWidget {
  final String routeName;
  final String distance;

  const _RouteCard({required this.routeName, required this.distance});

  @override
  Widget build(BuildContext context) {
    // Usamos InkWell para que la tarjeta sea clickeable y tenga feedback visual
    return InkWell(
      onTap: () {
        // Navegar al detalle de esta ruta
      },
      // Semantics para que el lector de pantalla describa la tarjeta y anuncie que es un botón
      child: Semantics(
        label: "Ruta guardada: $routeName, a una distancia de $distance. Toca para ver detalles.",
        button: true,
        child: Card(
          color: Colors.grey[300], // Color de fondo claro
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  routeName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  distance,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}