import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:border_queue_management_app/services/qr_verification_service.dart';

class QRVerificationScreen extends StatefulWidget {
  @override
  _QRVerificationScreenState createState() => _QRVerificationScreenState();
}

class _QRVerificationScreenState extends State<QRVerificationScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  String result;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Verification'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Result: $result')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      String verificationResult = await QRVerificationService().verifyQRCode(scanData.code);
      setState(() {
        result = verificationResult;
      });
    });
  }
}