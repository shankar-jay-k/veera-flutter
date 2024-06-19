import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool permissionDenied = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _showScanner();
    } else if (status.isDenied || status.isPermanentlyDenied) {
      if (!permissionDenied) {
        setState(() {
          permissionDenied = true;
        });
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showScanner() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('QR Scanner'),
          ),
          body: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 10,
              overlayColor: Colors.black.withOpacity(0.5),
              borderLength: 60,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      controller = qrViewController;
    });
    controller!.scannedDataStream.listen((scanData) {
      // Handle scanned data
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      if (!permissionDenied) {
        setState(() {
          permissionDenied = true;
        });
        controller?.pauseCamera(); // Stop the QR scanner
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Denied'),
        content: Text('Camera permission is required to scan QR codes. Please enable it in settings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    ).then((_) {
      setState(() {
        permissionDenied = false; // Reset the permission denial state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _requestPermission,
          child: Text('Open QR Scanner'),
        ),
      ),
    );
  }
}

