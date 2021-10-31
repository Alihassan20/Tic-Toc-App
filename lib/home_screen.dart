import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = "X";
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(42, 9, 68, 1),
      body: Center(
        child: MediaQuery.of(context).orientation == Orientation.portrait? Column(
          children: [
            ...firstBloch(),
            buildExpandedGridView(),
            ...secondBlock(),
          ],
        ):
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...firstBloch(),
                      ...secondBlock(),
                    ],
                  ),
                ),
                buildExpandedGridView(),
              ],
            )
      ),
    );
  }

  Expanded buildExpandedGridView() {
    return Expanded(
              child: GridView.count(
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.0,
            crossAxisCount: 3,
            children: List.generate(
                9,
                (index) => InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)),
                      onTap: gameOver == true ? null : () => _onTap(index),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(112, 11, 151, 1)),
                        child: Center(
                          child: Text(
                            Player.playerX.contains(index)
                                ? "X"
                                : Player.playerO.contains(index)
                                    ? "O"
                                    : "",
                            style: TextStyle(
                                color: Player.playerX.contains(index)
                                    ? Colors.white
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 50),
                          ),
                        ),
                      ),
                    )),
          ));
  }

  List <Widget> firstBloch(){
    return [
      SwitchListTile.adaptive(
          activeColor: Colors.tealAccent,
          title: const Text(
            'Turn On/Off Two Player Mode',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30),
            textAlign: TextAlign.center,
          ),
          value: isSwitched,
          onChanged: (newValue) {
            setState(() {
              isSwitched = newValue;
            });
          }),
      Text(
        "it's  $activePlayer  turn".toUpperCase(),
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 50),
        textAlign: TextAlign.center,
      ),
    ];
  }

  List <Widget> secondBlock(){
    return [
      Text(
        result,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 50),
        textAlign: TextAlign.center,
      ),
      RaisedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerO = [];
            Player.playerX = [];
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = '';
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text('Repeat The Game'),
        color: const Color.fromRGBO(62, 6, 95, 1),
        elevation: 10,
      )
    ];
  }
  _onTap(int index) async {

    if ((Player.playerX.isEmpty ||
        !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty ||
        !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      upState();
      if (!isSwitched && !gameOver&& turn!=9){
        await game.autoPlay(activePlayer);
        upState();
      }

    }

  }

  void upState() {
    setState(() {
      activePlayer = (activePlayer == "X") ? "O" : "X";
      turn++;
      String winnerPlayer = game.checkWinner();
      if(winnerPlayer !=""){
        gameOver=true;
        result = "$winnerPlayer Is The Winner";

      }
      else if(!gameOver&&turn==9){
        result = "It's Draw";

      }
    });
  }
}
