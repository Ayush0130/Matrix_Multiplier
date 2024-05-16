import 'package:flutter/material.dart';

void main() {
  runApp(MatrixMultiplyApp());
}

class MatrixMultiplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrix Multiplier',
      home: MatrixMultiplyScreen(),
    );
  }
  //no change
}

class MatrixMultiplyScreen extends StatefulWidget {
  @override
  _MatrixMultiplyScreenState createState() => _MatrixMultiplyScreenState();
}

class _MatrixMultiplyScreenState extends State<MatrixMultiplyScreen> {
  List<List<int>> s = List.generate(3, (_) => List.filled(3, 0));
  List<List<int>> t = List.generate(3, (_) => List.filled(3, 0));
  List<List<int>> p = List.generate(3, (_) => List.filled(3, 0));

  void updateS(int row, int col) {
    setState(() {
      s[row][col] = (s[row][col] + 1) % 10;
    });
  }

  void updateT(int row, int col) {
    setState(() {
      t[row][col] = (t[row][col] + 1) % 10;
    });
  }

  void multiplyMatrices() {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          p[i][j] = 0;
          for (int k = 0; k < 3; k++) {
            p[i][j] += s[i][k] * t[k][j];
          }
          p[i][j]=p[i][j]%10;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrix Multiplier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrix(s, updateS),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text("x", style: TextStyle(fontSize: 30)),
                  ],
                ),
                SizedBox(width: 20),
                _buildMatrix(t, updateT),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: multiplyMatrices,
              child: Text('Multiply Matrices'),
            ),
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                _buildMatrix(p, null),
                  ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatrix(List<List<int>> matrix, Function(int, int)? onPressed) {
    return Column(
      children: List.generate(3, (i) {
        return Row(
          children: List.generate(3, (j) {
            return GestureDetector(
              onTap: onPressed != null ? () => onPressed(i, j) : null,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    matrix[i][j].toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
