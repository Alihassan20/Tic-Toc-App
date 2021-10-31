import 'dart:math';
class Player{

static List<int>playerX=[];
static List<int>playerO=[];

}

extension ContainAll on List{

  bool containAll(int x,int y,[z]){
    if (z==null){
      return contains(x)&& contains(y);
    }else {
      return contains(x)&& contains(y)&&contains(z);
    }
    }
  }


class Game {
  void playGame(int index, String activePlayer){

    if (activePlayer=="X")
      Player.playerX.add(index);
    else Player.playerO.add(index);

  }

  String checkWinner(){
    String winner = '';

    if (
    Player.playerX.containAll(0, 1,2)||
    Player.playerX.containAll(3, 4,5)||
    Player.playerX.containAll(6, 7,8)||
    Player.playerX.containAll(0, 3,6)||
    Player.playerX.containAll(1, 4,7)||
    Player.playerX.containAll(2, 5,8)||
    Player.playerX.containAll(0, 4,8)||
    Player.playerX.containAll(2, 4,6)) {
      winner = "X";
    }
     else if(
      Player.playerO.containAll(0, 1,2)||
          Player.playerO.containAll(3, 4,5)||
          Player.playerO.containAll(6, 7,8)||
          Player.playerO.containAll(0, 3,6)||
          Player.playerO.containAll(1, 4,7)||
          Player.playerO.containAll(2, 5,8)||
          Player.playerO.containAll(0, 4,8)||
          Player.playerO.containAll(2, 4,6)
      ) {
       winner = "O";
     } else{
     winner="";
     }
    return winner;
  }
  Future<void> autoPlay(activePlayer)async {
    int index=0;
    List<int>emptyCell=[];

    for(int i =0;i<9;i++){
      if (!(Player.playerO.contains(i)||Player.playerX.contains(i))){
        emptyCell.add(i);
      }
    }
    Random random=Random();
    int randomIndex = random.nextInt(emptyCell.length);
    index = emptyCell[randomIndex];
    playGame(index,activePlayer);

  }
}
