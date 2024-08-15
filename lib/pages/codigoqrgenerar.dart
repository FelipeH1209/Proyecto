import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class Codigoqrgenerar extends StatelessWidget {
  Codigoqrgenerar(
      {super.key,
      required this.pesoT,
      required this.estaturaT,
      required this.razaT,
      required this.generoT,
      required this.enfermedades,
      required this.medicamento,
      required this.categoria,
      required this.crias});
  final String pesoT;
  final String estaturaT;
  final String razaT;
  final String generoT;
  final String enfermedades;
  final String medicamento;
  final String categoria;
  final String crias;
  final ScreenshotController screenshotController = ScreenshotController();
  String generateQRData() {
    return "Peso Novillo : $pesoT\nEstatura Novillo : $estaturaT\nRaza Novillo: $razaT\nGenero Novillo : $generoT/nEnfermedades Novillo :$enfermedades\nMedicamentos Novillo : $medicamento\nCategoria Novillo : $categoria\nCrias Novillo : $crias";
  }

  Future<void> captureAndSaveImage() async {
    final Uint8List? uint8list = await screenshotController.capture();
    if (uint8list != null) {
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        final result = await ImageGallerySaver.saveImage(uint8list);
        if (result['isSuccess']) {
          print('Imagen guardada en galeria');
        } else {
          print('No se guardo la imagen: ${result['error']}');
        }
      } else {
        print('Permiso de acceso al almacenamiento denegado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String qrData = generateQRData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador Qr'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                gapless: false,
                size: 180,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text('Escanea el codigo QR'),
            ElevatedButton(
                onPressed: () async {
                  await captureAndSaveImage();
                },
                child: Text('Capturar y Guardar Imagen del QR'))
          ],
        ),
      ),
    );
  }
}
