import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zonar_led/main.dart';

class DynamicGrid extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DynamicGridState createState() => _DynamicGridState();
}

class _DynamicGridState extends State<DynamicGrid> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    int rows = appState.rows;
    int cols = appState.cols;

    List<List<int>> grid = List.generate(
      2,
      (_) => List.generate(2, (_) => 0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Grid'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Add Row'),
                  onPressed: () => setState(() {
                    appState.rows++;
                    grid.add(List.generate(cols, (_) => 0));
                  }),
                ),
                ElevatedButton(
                  child: Text('Add Column'),
                  onPressed: () => setState(() {
                   appState.cols++;
                    for (var row in grid) {
                      row.add(0);
                    }
                  }),
                ),
                ElevatedButton(
                  child: Text('Remove Row'),
                  onPressed: () => setState(() {
                    if (rows > 1) {
                      appState.rows--;
                      grid.removeLast();
                    }
                  }),
                ),
                ElevatedButton(
                  child: Text('Remove Column'),
                  onPressed: () => setState(() {
                    if (cols > 1) {
                      appState.cols--;
                      for (var row in grid) {
                        row.removeLast();
                      }
                    }
                  }),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: rows * cols,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int r = 0;
                  int g = 0;
                  int b = 0;
                  return GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text("Choose a color"),
                              content: Text("this is the dialog"),
                            )),
                    child: Container(
                      color: Color.fromARGB(255, 94, 116, 134),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text('Send'),
                  onPressed: () => setState(() {
                    print("Hola mundo");
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
