import 'package:flutter/material.dart';

class DynamicGrid extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DynamicGridState createState() => _DynamicGridState();
}

class _DynamicGridState extends State<DynamicGrid> {
  int _rows = 2;
  int _cols = 2;

  List<List<int>> _grid = List.generate(
    2,
    (_) => List.generate(2, (_) => 0),
  );

  @override
  Widget build(BuildContext context) {
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
                    _rows++;
                    _grid.add(List.generate(_cols, (_) => 0));
                  }),
                ),
                ElevatedButton(
                  child: Text('Add Column'),
                  onPressed: () => setState(() {
                    _cols++;
                    for (var row in _grid) {
                      row.add(0);
                    }
                  }),
                ),
                ElevatedButton(
                  child: Text('Remove Row'),
                  onPressed: () => setState(() {
                    if (_rows > 1) {
                      _rows--;
                      _grid.removeLast();
                    }
                  }),
                ),
                ElevatedButton(
                  child: Text('Remove Column'),
                  onPressed: () => setState(() {
                    if (_cols > 1) {
                      _cols--;
                      for (var row in _grid) {
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
                itemCount: _rows * _cols,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _cols,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ _cols;
                  int col = index % _cols;
                  return GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text("Dialog"),
                              content: Text("this is the dialog"),
                            )),
                    child: Container(
                      color:
                          _grid[row][col] == 0 ? Colors.grey[300] : Colors.blue,
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
