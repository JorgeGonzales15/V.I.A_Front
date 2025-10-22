import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AnalyzingRouteScreen extends StatefulWidget {
  const AnalyzingRouteScreen({super.key});

  @override
  State<AnalyzingRouteScreen> createState() => _AnalyzingRouteScreenState();
}

class _AnalyzingRouteScreenState extends State<AnalyzingRouteScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Obtiene la lista de cámaras disponibles
    final cameras = await availableCameras();
    // Usa la primera cámara de la lista (generalmente la trasera)
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print("Error al inicializar la cámara: $e");
    }
  }

  @override
  void dispose() {
    // Es muy importante liberar el controlador cuando el widget se destruye
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        child: _isCameraInitialized
            ? Stack(
                fit: StackFit.expand,
                children: [
                  // Widget que muestra la vista previa de la cámara
                  CameraPreview(_controller!),
                  
                  // Capa de superposición azul
                  _buildOverlay(),
                  
                  // Contenido de la UI (texto y botón)
                  _buildUIContent(),
                ],
              )
            : const Center(
                // Muestra un indicador de carga mientras la cámara se inicializa
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan.withOpacity(0.7), // Color cian semi-transparente
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildUIContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
      child: Column(
        children: [
          const Text(
            'Analizando ruta...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(), // Empuja el botón hacia abajo
          ElevatedButton(
            onPressed: () {
              // Regresa a la pantalla anterior
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'Finalizar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}