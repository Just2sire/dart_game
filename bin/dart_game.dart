import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // String whoPlays = "first";
  String handleAction(Player player1, Player player2) {
    bool lost = player1.lostGame();
    if (lost == true) {
      return "0";
    } else {
      print("====>Action de ${player1.name}<====");
      String? option = stdin.readLineSync();
      // return option!;

      if (option == "1") {
        int attack = player1.attack();
        player2.lostPv(attack);
      } else if (option == "2") {
        player1.getPotion();
      }

      // whoPlays = player1.first ? "first" : "last";

      return "1";
    }
  }

  void playGame(Player firstPlayer, Player secondPlayer) {
    int tour = 1;
    while (true) {
      print("""
============== Tour $tour ==============

1. Attaquer ⚔️ 🩸
2. Prendre une potion🧪
""");

      String j1 = handleAction(firstPlayer, secondPlayer);
      if (j1 == "0") {
        print("Fin du jeu");
        break;
      }

      String j2 = handleAction(secondPlayer, firstPlayer);
      if (j2 == "0") {
        print("Fin du jeu");
        break;
      }

      firstPlayer.getPv();
      secondPlayer.getPv();

      tour++;
    }
  }

  print('Veuillez entrez le nom des joueurs\n');
  print('Nom du premier joueur\n');

  String? firstPlayerName = stdin.readLineSync();
  print('Nom du second joueur\n');
  String? secondPlayerName = stdin.readLineSync();

  Player first = Player(
    name: firstPlayerName!,
    first: true,
  );
  Player second = Player(
    name: secondPlayerName!,
    first: false,
  );

  print("""
============== BIENVENUE DANS LE JEU 'THE BATTLE' ==============

Choissiez une option puis appuyer sur entrer.

1. Lire les règles
2. Commencer sans lire les règles
""");

  stdout.writeln("Entrer votre choix: ");
  var choice = stdin.readLineSync();
  // int? selected = int.tryParse(choice ?? "");

  if (choice == "1") {
    print("""Les règles
    - Le jeu se joue à deux
    - Au départ, vous avez tous 100 points de vie (PV)
    - Le jeu est subdivisé en tour. Et à chaque jour, chaque joueur peut faire une action
    - Vous pouvez attaquer votre adversaire en lui faisant perdre entre 5 et 15 PV
    - Vous pouvez aussi prendre une potion pour gagner entre 5 et 30 PV
    - Chaque joueur dispose de 3 potions durant toute la partie
    - Le premier à atteindre 0 PV a perdu la partie
      """);

    playGame(first, second);
  } else if (choice == "2") {
    playGame(first, second);
  } else {
    // continue;
  }
}

class Player {
  // Nom du joueur
  String name;

  // PV de base du joueur
  int pv = 50;

// Nombre de potion de base du joueur
  int potion = 3;

  // rang
  bool first;

  Player({
    required this.name,
    required this.first,
  });

  final Random rand = Random();

  // Prendre une potion
  void getPotion() {
    if (potion > 0) {
      print("$name prend une potion 🧪✨");
      int potion = rand.nextInt(25) + 5;
      this.potion = this.potion -= 1;
      print("\nLa potion🧪 a généré $potion de PV 🍀✨");
      print("\nIl vous reste ${this.potion} potion(s)⚗️\n");
      gainPv(potion);
      // return potion;
    } else {
      print("Vous n'avez plus de potions 🧪🥲");
      // return 0;
    }
  }

  // Gangner des pv
  void gainPv(int pv) {
    this.pv = this.pv += pv;
    print("\nVotre PV est maintenant de ${this.pv}🍀\n");
  }

  // Perdre des pv
  void lostPv(int pv) {
    print(
      "\n$name l'attaque🗡️ que vous avez subi vous a couté $pv 🩸 de PV\n",
    );
    if (this.pv < 5) {
      this.pv = 0;
    } else {
      this.pv = this.pv -= pv;
    }
    if (this.pv < 15) {
      print("⛔⛔$name vous avez moins de 15 PV⛔⛔");
    }
    print("votre PV est maintenant de ${this.pv}🍀");
  }

  // Attaquer
  int attack() {
    print("$name est entrain d'attaquer⚔️");
    int attack = rand.nextInt(10) + 5;
    return attack;
  }

  // Perdre la partie
  bool lostGame() {
    if (pv <= 0) {
      print("$name n'a plus assez de point de vie😵☠️");
      return true;
    }
    return false;
  }

  // Voir son PV
  String getPv() {
    return "Le PV de $name est de $pv\n";
  }
}
