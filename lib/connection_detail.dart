import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ConnectionDetailsPage extends StatelessWidget {
  final BluetoothDevice device;

  const ConnectionDetailsPage({Key? key, required this.device})
      : super(key: key);

  Future<void> _disconnectFromDevice() async {
    try {
      await device.disconnect();
      print("disconnect from device...");
    } catch (e) {
      print('Error disconnecting from device: $e');
    }
  }

  void _sendPatternToBluetoothDevice() async {
    // Set display pattern
    // MessageType = 04
    // FrameHeight = 1 byte
    // FrameCount = 1 byte
    // Pattern 3 bytes * frameHeight * frameCount = R,G,B (1 byte each)
    const message = [
      0xD0, // Start byte
      0x04, // MessageType
      0x03, // FrameHeight
      0x03, // FrameCount
      0x00, 0x00, 0xFF, // First frame (blue)
      0x00, 0x00, 0xFF, // Second frame (blue)
      0x00, 0x00, 0xFF, // Third frame (blue)
      0xD1, // End byte
    ];

    // Find the characteristic to write to
    final service = await device.discoverServices();
    final characteristic =
        service.map((s) => s.characteristics).expand((c) => c).firstWhere((c) {
      print(c);
      return c.uuid == Guid('00002a28-0000-1000-8000-00805f9b34fb');
    });

    // Write the message to the characteristic
    final bytes = Uint8List.fromList(message);
    await characteristic.write(bytes);
  }

  void _sendStringToBluetoothDevice() async {
    // Generate a random string to send to the device
    const randomString = 'asdf';

    // Find the characteristic to write to
    final service = await device.discoverServices();
    final characteristic =
        service.map((s) => s.characteristics).expand((c) => c).firstWhere((c) {
      print(c);
      return c.uuid == Guid('00002a28-0000-1000-8000-00805f9b34fb');
    });

    // Convert the string to bytes and write it to the characteristic
    final bytes = utf8.encode(randomString);
    await characteristic.write(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the previous screen
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Connection Details'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Connected to ${device.name}'),
              Text('Device ID: ${device.id}'),
              // Add more details about the connection here
              MaterialButton(
                onPressed: _disconnectFromDevice,
                color: Colors.red,
                child: Text('Disconnect'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _sendStringToBluetoothDevice,
          child: Icon(Icons.send),
        ),
      ),
    );
  }
}
