import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


class ConnectionDetailsPage extends StatelessWidget {
  final BluetoothDevice device;

  const ConnectionDetailsPage({Key? key, required this.device}) : super(key: key);

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
    );
  }
}
