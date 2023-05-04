import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ConnectionDetailsPage extends StatelessWidget {
  final BluetoothDevice device;

  const ConnectionDetailsPage({Key? key, required this.device})
      : super(key: key);

  void _sendStringToBluetoothDevice() async {
    // Generate a random string to send to the device
    const randomString = 'Zonar';

    // Find the characteristic to write to
    final service = await device.discoverServices();
    final characteristic = service
        .map((s) => s.characteristics)
        .expand((c) => c)
        .firstWhere(
            (c) => c.uuid == Guid('00002a28-0000-1000-8000-00805f9b34fb'));

    // Convert the string to bytes and write it to the characteristic
    final bytes = utf8.encode(randomString);
    await characteristic.write(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendStringToBluetoothDevice,
        child: Icon(Icons.send),
      ),
    );
  }
}
