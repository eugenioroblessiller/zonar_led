import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:provider/provider.dart';
import 'package:zonar_led/main.dart';

class BluetoothSearch extends StatefulWidget {
  @override
  State<BluetoothSearch> createState() => _BluetoothSearchState();
}

class _BluetoothSearchState extends State<BluetoothSearch> {
  final List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    _searchForDevices();
  }

  Future<void> _searchForDevices() async {
    try {
      final adapter = FlutterWebBluetooth.instance;
      if (!adapter.isBluetoothApiSupported) {
        print('Web Bluetooth API is not supported.');
        return;
      }

      final device = await adapter.requestDevice(RequestOptionsBuilder.acceptAllDevices());

      if (device != null) {
        print('Found device: ${device.name} (${device.id})');
        setState(() {
          _devices.add(device);
        });
      }
    } catch (e) {
      print('Error searching for devices: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have devices:'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _devices.length,
            itemBuilder: (context, index) {
              final device = _devices[index];
              return ListTile(
                title: Text(device.name ?? ''),
                subtitle: Text(device.id),
                onTap: () {
                  // TODO: connect to the selected device
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
