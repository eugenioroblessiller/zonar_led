import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:zonar_led/main.dart';

class BluetoothSearch extends StatefulWidget {
  @override
  State<BluetoothSearch> createState() => _BluetoothSearchState();
}

class _BluetoothSearchState extends State<BluetoothSearch> {
  final List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    super.initState();
    _searchForDevices();
  }

  void _searchForDevices() async {
    // Start scanning for devices
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (!devicesList.contains(r.device)) {
          setState(() {
            devicesList.add(r.device);
          });
        }
      }
    });

    await flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.stopScan();
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
          // Make better use of wide windows with a grid.
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            itemCount: devicesList.length,
            itemBuilder: (BuildContext context, int index) {
              final device = devicesList[index];
              return ListTile(
                title: Text(device.name ?? 'Unknown'),
                subtitle: Text(device.id.toString()),
                onTap: () {
                  // Do something when the device is tapped
                  print('Tapped on device: ${device.name}');
                  _showConnectToDeviceDialog(context, device);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}


void _showConnectToDeviceDialog(BuildContext context, BluetoothDevice device) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Connect to ${device.name}?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () async {
              // Connect to the device
              await device.connect();
              // Do something else after the device is connected
              // ...
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}