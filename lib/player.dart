import 'dart:math';

class Player {
  // Nom du joueur
  String name;

  // PV de base du joueur
  int pv = 100;

// Nombre de potion de base du joueur
  int potion = 3;
  Player({
    required this.name,
  });

  final Random rand = Random();

  // Prendre une potion
  void getPotion() {
    if (potion > 0) {
      print("$name prend une potion🧪✨");
      int potion = rand.nextInt(25) + 5;
      this.potion = this.potion--;
      gainPv(potion);
      print("\nLa potion🧪 a généré $potion de PV🍀✨\n");
      // return potion;
    } else {
      print("Vous n'avez plus de potions🧪🥲");
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
    print("\nL'attaque🗡️ que vous avez subi vous a couté $pv🩸 de PV\n");
    this.pv = this.pv -= pv;
    print("Votre PV est maintenant de ${this.pv}🍀");
  }

  // Attaquer
  int attack() {
    print("$name est entrain d'attaquer⚔️");
    int attack = rand.nextInt(10) + 5;
    return attack;
  }

  // Perdre la partie
  bool lostGame() {
    if (pv <= 5) {
      print("$name n'a plus assez de point de vie😵☠️");
      return true;
    }
    return false;
  }
}
