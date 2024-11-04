import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  late MobileScannerController cameraController;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_off),
            onPressed: () async {
              await cameraController.toggleTorch();
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera_rear),
            onPressed: () async {
              await cameraController.switchCamera();
              setState(() {});
            },
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (BarcodeCapture capture) {
          if (!isScanning) return;

          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            isScanning = false;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('QR Code Detected'),
                  content: Text('Value: ${barcode.rawValue ?? "No value found"}'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        isScanning = true;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}