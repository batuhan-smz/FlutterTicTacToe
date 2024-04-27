import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Game(),
    );
  }
}
class Game extends StatefulWidget{
  @override
  _GameState createState() => _GameState();
}
class _GameState extends State<Game> {
  List<List<String>> board = List.generate(
      3, (_) => List.generate(3, (_) => ""));
  bool playerX = true;

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ""));
      playerX = true;
    });
  }

  void markCell(int row, int col) {
    if (board[row][col] == "") {
      setState(() {
        board[row][col] = playerX ? "X" : "O";
        playerX = !playerX;
      });
    }
  }

  bool checkWin(List<List<String>> board, String player) {
    for (int i = 0; i < 3; i++) {
      //Dikey Kontrol
      if (board[i][0] == playerX && board[i][1] == playerX &&
          board[i][2] == playerX) {
        return true;
      }
      //Yatay Kontrol
      if (board[0][i] == playerX && board[1][i] == playerX &&
          board[2][i] == playerX) {
        return true;
      }
      //Çapraz Kontrol
      if (board[0][0] == playerX && board[1][1] == playerX &&
          board[2][2] == playerX) {
        return true;
      }
      if (board[2][0] == playerX && board[1][1] == playerX &&
          board[0][2] == playerX) {
        return true;
      }
    }
    return false;
  }

  bool checkDraw() {
    bool allFilled = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          allFilled = false;
          break;
        }
      }
      if (!allFilled) {
        break;
      }
    }
    if (allFilled) {
      return true;
    }
    return false;
  }

  void win() {
    bool winner = checkWin(board, playerX ? "X" : "O");
    if (winner != false) {
      // Show winner or tie message and reset board
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                winner == checkDraw() ? "Beraberlik!" : "$winner Kazandı!"),
            content: Text("Yeniden oynamak ister misin?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetBoard();
                },
                child: Text("Evet"),
              ),
            ],
          );
        },
      );
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tic Tac Toe',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => markCell(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: resetBoard, child: Text('Reset')
              ),
            ],
          ),
        ),
      );
    }
  }
