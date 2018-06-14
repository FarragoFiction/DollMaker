
/*
A charm is repesented by a single symbol.

a charm can be vaccilation, in which case it has two sub charms (and renders all three of them)

this is a sub charm.

a charm also has a name. it's trove will use these to generate text

 */

class Charm {
    static List<Charm> _allCharms  = new List<Charm>();
    static List<Charm> get allCharms {
        if(_allCharms == null || _allCharms.isEmpty) {
            initCharms();
        }
        return _allCharms;
    }
    static String folder = "images/Charms/";
    String name;

    String get imgLocation => "$folder$name.png";

    Charm(String this.name);

    static initCharms() {
        new Charm("Heart");
        new Charm("Spades");
    }
}