import "../commonImports.dart";

class Quirk {
    //why did it take me so long to do this???

    static  List<String> prefixes = <String>["8=D", ">->", "//", "tumut", ")", "><>", "(", "\$", "?", "=begin", "=end"]
        ..addAll(<String>["<3", "<3<", "<>", "c3<", "{", "}", "<String>[", "]", "'", ".", ",", "~", "!", "~", "^", "&", "#", "@", "%", "*"]);

    static List<List<String>> sbahj_quirks = <List<String>>[<String>["asshole", "dunkass"], <String>["happen", "hapen"], <String>["we're", "where"], <String>["were", "where"], <String>["has", "hass"], <String>["lol", "ahahahaha"], <String>["dog", "god"], <String>["god", "dog"], <String>["know", "no"]]..addAll(<List<String>>[<String>["they're", "there"], <String>["their", "there"], <String>["theyre", "there"], <String>["through", "threw"], <String>["lying", "lyong"], <String>["distraction", "distaction"], <String>["garbage", "gargbage"], <String>["angel", "angle"]])..addAll(<List<String>>[<String>["the", "thef"], <String>["i'd", "i'd would"], <String>["i'm", "i'm am"], <String>["don't", "don't not"], <String>["won't", "won't not"], <String>["can't", "can't not"], <String>["ing", "ung"]])..addAll(<List<String>>[<String>["ink", "ing"], <String>["ed", "id"], <String>["id", "ed"], <String>["ar", "aur"], <String>["umb", "unk"], <String>["ian", "an"], <String>["es", "as"], <String>["ough", "uff"]]);

    static  List<List<String>> fish_quirks = <List<String>>[<String>["this", "fish"],<String>["calm", "clam"], <String>["ass", "bass"], <String>["god", "glub"], <String>["god", "cod"], <String>["fuck", "glub"], <String>["really", "reely"], <String>["kill", "krill"], <String>["thing", "fin"], <String>["well", "whale"], <String>["purpose", "porpoise"], <String>["better", "betta"], <String>["help", "kelp"], <String>["see", "sea"], <String>["friend", "frond"], <String>["crazy", "craysea"], <String>["kid", "squid"], <String>["hell", "shell"]];

//not as extreme as a troll quirk, buxt...
    static List<List<String>> conversational_quirks = <List<String>>[<String>["\\well\\b", "welp"],<String>["pro", "bro"], <String>["guess", "suppose"], <String>["S\\b", "Z"], <String>["oh my god", "omg"], <String>["like", "liek"], <String>["ing", "in"], <String>["have to", "hafta"], <String>["want to", "wanna"], <String>["going to", "gonna"], <String>["i'm", "i am"], <String>["you're", "you are"], <String>["we're", "we are"], <String>["forever", "5ever"], <String>["ever", "evah"], <String>["er", "ah"], <String>["to", "ta"]]..addAll(<List<String>>[<String>["I'm", "Imma"], <String>["don't know", "dunno"], <String>["school", "skool"], <String>["the", "teh"], <String>["aren't", "aint"], <String>["ie", "ei"], <String>["though", "tho"], <String>["you", "u"], <String>["right", "rite"]])..addAll(<List<String>>[<String>["n't", " not"], <String>["'m'", " am"], <String>["kind of", "kinda"], <String>["okay", "ok"], <String>["\\band\\b", "&"], <String>["\\bat\\b", "@"], <String>["okay", "okey dokey"]]);
    static List<List<String>> very_quirks = <List<String>>[<String>["\\bvery\\b", "adequately"], <String>["\\bvery\\b", "really"], <String>["\\bvery\\b", "super"], <String>["\\bvery\\b", "amazingly"], <String>["\\bvery\\b", "hella"], <String>["\\bvery\\b", "extremely"], <String>["\\bvery\\b", "absolutely"], <String>["\\bvery\\b", "mega"], <String>["\\bvery\\b ", "extra"], <String>["\\bvery\\b", "ultra"], <String>["\\bvery\\b", "hecka"], <String>["\\bvery\\b", "totes"]];
    static List<List<String>> good_quirks = <List<String>>[<String>["\\bgood\\b", "good"], <String>["\\bgood\\b", "agreeable"], <String>["\\bgood\\b", "marvelous"], <String>["\\bgood\\b", "ace"], <String>["\\bgood\\b", "wonderful"], <String>["\\bgood\\b", "sweet"], <String>["\\bgood\\b", "dope"], <String>["\\bgood\\b", "awesome"], <String>["\\bgood\\b", "great"], <String>["\\bgood\\b", "radical"], <String>["\\bgood\\b", "perfect"], <String>["\\bgood\\b", "amazing"], <String>["\\bgood\\b", "super good"], <String>["\\bgood\\b", "acceptable"]];
    static List<List<String>> asshole_quirks = <List<String>>[<String>["asshole", "asshat"],<String>["asshole", "dickhead"],<String>["asshole", "fucknut"], <String>["asshole", "pukestain"], <String>["asshole", "dirtbag"], <String>["asshole", "fuckhead"], <String>["asshole", "asshole"], <String>["asshole", "dipshit"], <String>["asshole", "garbage person"], <String>["asshole", "fucker"], <String>["asshole", "poopy head"], <String>["asshole", "shit sniffer"], <String>["asshole", "jerk"],<String>["asshole", "douchecanoe"],<String>["asshole", "douche"], <String>["asshole", "plebeian"], <String>["asshole", "fuckstain"], <String>["asshole", "douchebag"], <String>["asshole", "fuckface"], <String>["asshole", "fuckass"]];
    static List<List<String>> lol_quirks = <List<String>>[<String>["lol", "lol"], <String>["lol", "haha"], <String>["lol", "ehehe"], <String>["lol", "heh"], <String>["lol", "omg lol"], <String>["lol", "rofl"], <String>["lol", "funny"], <String>["lol", " "], <String>["lol", "hee"], <String>["lol", "lawl"], <String>["lol", "roflcopter"], <String>["lol", "..."], <String>["lol", "bwahah"], <String>["lol", "*giggle*"], <String>["lol", ":)"]];
    static List<List<String>> greeting_quirks = <List<String>>[<String>["\\bhey\\b", "hey"], <String>["\\bhey\\b", "hi"], <String>["\\bhey\\b", "hello"], <String>["\\bhey\\b", "greetings"], <String>["\\bhey\\b", "yo"], <String>["\\bhey\\b", "sup"]];
    static List<List<String>> dude_quirks = <List<String>>[<String>["dude", "guy"], <String>["dude", "bro"], <String>["dude", "man"], <String>["dude", "you"], <String>["dude", "friend"], <String>["dude", "asshole"], <String>["dude", "fella"], <String>["dude", "bro"]];
    static  List<List<String>> curse_quirks = <List<String>>[<String>["fuck", "beep"],<String>["fuck", "piss"],  <String>["fuck", "motherfuck"], <String>["\\bfuck\\b", "um"], <String>["\\bfuck\\b", "fuck"], <String>["\\bfuck\\b", "shit"], <String>["\\bfuck\\b", "cocks"], <String>["\\bfuck\\b", "nope"], <String>["\\bfuck\\b", "goddammit"], <String>["\\bfuck\\b", "damn"], <String>["\\bfuck\\b", "..."], <String>["\\bfuck\\b", "...great."], <String>["\\bfuck\\b", "crap"], <String>["\\bfuck\\b", "fiddlesticks"], <String>["\\bfuck\\b", "darn"], <String>["\\bfuck\\b", "dang"], <String>["\\bfuck\\b", "omg"]];
//problem: these are likely to be inside of other words.
    static List<List<String>> yes_quirks = <List<String>>[<String>["\\byes\\b", "certainly"], <String>["\\byes\\b", "indeed"], <String>["\\byes\\b", "yes"], <String>["\\byes\\b", "yeppers"], <String>["\\byes\\b", "right"], <String>["\\byes\\b", "yeah"], <String>["\\byes\\b", "yep"], <String>["\\byes\\b", "sure"], <String>["\\byes\\b", "okay"], <String>["\\byes\\b", "hell yes"]];
    static List<List<String>> no_quirks = <List<String>>[<String>["\\bnope\\b|\\bno\\b", "hell no"], <String>["\\bnope\\b|\\bno\\b", "absolutely no"], <String>["\\bnope\\b|\\bno\\b", "no"], <String>["\\bnope\\b|\\bno\\b", "no"], <String>["\\bnope\\b|\\bno\\b", "nope"], <String>["\\bnope\\b|\\bno\\b", "no way"],<String>["\\bnope\\b|\\bno\\b", "nah"]];
    static List<List<String>> friend_quirks = <List<String>>[<String>["friend", "bro"], <String>["friend", "buddy"], <String>["friend", "pal"], <String>["friend", "friend"], <String>["friend", "compadre"], <String>["friend", "comrade"],<String>["friend", "best friend"],<String>["friend", "homey"]];

//abandoned these early on because was annoyed at having to figure out how escapes worked. picking back up now.
    static List<List<String>> smiley_quirks = <List<String>>[<String>[":\\)", ":)"], <String>[":\\)", ":0)"], <String>[":\\)", ":]"], <String>[":\\)", ":B"], <String>[":\\)", ">: ]"], <String>[":\\)", ":o)"], <String>[":\\)", "^_^"], <String>[":\\)", ";)"], <String>[":\\)", "~_^"], <String>[":\\)", "0u0"], <String>[":\\)", "uwu"], <String>[":\\)", "¯\_(ツ)_/¯ "], <String>[":\\)", ":-)"], <String>[":\\)", ":3"], <String>[":\\)", "XD"], <String>[":\\)", "8D"], <String>[":\\)", ":>"], <String>[":\\)", "=]"], <String>[":\\)", "=}"], <String>[":\\)", "=)"], <String>[":\\)", "o->-<"]];



    static int NOCAPS = 0;
    static int ALLCAPS = 2;
    static int ALTCAPS = 4;
    static int INVERTCAPS = 5;
    static int KANAYACAPS = 3;
    static int NORMALCAPS = 1;

    static int NOPUNC = 0;
    static int ENDPUNC = 1;
    static int PERFPUNC = 2;
    static int EXPUNC = 3;

    List<dynamic> lettersToReplace = []; //array of two element arrays. ["e", "3"], ["two",2] would be two examples. e replaced by 3 and two replaced by 2
    List<dynamic> lettersToReplaceIgnoreCase = [];
    num punctuation = 0; //0 = none, 1 = ends of sentences, 2 = perfect punctuation 3= excessive punctuation
    String prefix = ""; //what do you put at the start of a line?
    String suffix = ""; //what do you put at the end of a line?
    //if in murdermode, rerandomize capitalization quirk.
    int capitalization = 0;  //0 == none, 4 = alternating, 5= inverted, 3 = begining of every word, 1 = normal, 2 = ALL;
    int favoriteNumber = 0; //getRandomInt;    //num favoriteNumber = 8;    //4 and 6 and 12 has green not change, 7 has SOME green not change
    //take an input string and quirkify it.

    Random rand;


    Quirk(Random this.rand) {
        if(this.rand == null) rand = new Random(); //so that blank players can be made that get overridden l8r
        this.favoriteNumber = rand.nextInt(12);
    }


    String translate(String input){
        String ret = input;
        ret = this.handleCapitilization(ret); //i originally had this line commented out. Why? It caused some quirks to not work (like replacing "E" with 3, but the sentence wasn't allCAPS yet)
        ret = this.handlePunctuation(ret);  //don't want to accidentally murder smileys
        ret = this.handleReplacements(ret);
        ret = this.handleReplacementsIgnoreCase(ret);
        ret = this.handleCapitilization(ret);//do it a second time 'cause ignore case made it's replacements all lower case
        if(this.capitalization == 5){
            ret = this.handleCapitilization(ret);//do it a third time cause now it's normal
        }

        ret = this.handlePrefix(ret);  //even if troll speaks in lowercase, 8=D needs to be as is.;
        ret = this.handleSuffix(ret);
        return ret;
    }
    Map<String, dynamic> toJSON(){
        return {"favoriteNumber": this.favoriteNumber};
    }
    String rawStringExplanation(){
        String ret = "\n * Capitalization: ";

        if(this.capitalization==0){
            ret += " all lower case ";
        }else if(this.capitalization==4){
            ret += " alternating ";
        }else if(this.capitalization==5){
            ret += " inverted ";
        }else if(this.capitalization==3){
            ret += " begining of every word ";
        }else if(this.capitalization==1){
            ret += " normal ";
        }else if(this.capitalization==2){
            ret += " all caps ";
        }

        ret += "\n * Punctuation: ";
        if(this.punctuation==0){
            ret += " no punctuation ";
        }else if(this.punctuation==1){
            ret += " ends of sentences ";
        }else if(this.punctuation==2){
            ret += " perfect punctuation ";
        }else if(this.punctuation==3){
            ret += " excessive punctuation ";
        }

        if(this.prefix != ""){
            ret += "\n *  Prefix: " + this.prefix;
        }

        if(this.suffix != ""){
            ret += "\n *  Suffix: " + this.suffix;
        }

        ret += "\n * Favorite Number: ${this.favoriteNumber}";

        if(this.lettersToReplace.length > 0){
            ret += " \n * Replaces: ";
        }
        for(num i = 0; i<this.lettersToReplace.length; i++){
            //querySelector("#debug").append(i);
            ret += "\n \t " + this.lettersToReplace[i][0] + " with " + this.lettersToReplace[i][1];
        }


        return ret;
    }
    String stringExplanation(){
        String ret = "<br>Capitalization: ";

        if(this.capitalization==0){
            ret += " all lower case ";
        }else if(this.capitalization==4){
            ret += " alternating ";
        }else if(this.capitalization==5){
            ret += " inverted ";
        }else if(this.capitalization==3){
            ret += " begining of every word ";
        }else if(this.capitalization==1){
            ret += " normal ";
        }else if(this.capitalization==2){
            ret += " all caps ";
        }

        ret += "<Br> Punctuation: ";
        if(this.punctuation==0){
            ret += " no punctuation ";
        }else if(this.punctuation==1){
            ret += " ends of sentences ";
        }else if(this.punctuation==2){
            ret += " perfect punctuation ";
        }else if(this.punctuation==3){
            ret += " excessive punctuation ";
        }

        if(this.prefix != ""){
            ret += "<br> Prefix: " + this.prefix;
        }

        if(this.suffix != ""){
            ret += "<br> Suffix: " + this.suffix;
        }

        ret += "<br> Favorite Number: ${this.favoriteNumber}";

        if(this.lettersToReplace.length > 0){
            ret += " <br>Replaces: ";
        }
        for(num i = 0; i<this.lettersToReplace.length; i++){
            //querySelector("#debug").append(i);
            ret += "<br>&nbsp&nbsp&nbsp&nbsp " + this.lettersToReplace[i][0] + " with " + this.lettersToReplace[i][1];
        }
        return ret;
    }
    String handlePrefix(String input){
        return this.prefix + " " + input;
    }
    String handleSuffix(String input){
        return input + " " + this.suffix;
    }
    String randomJapaneseBullshit(){
        String japaneseBullshit = "私はあなたの歯の間に私の乳首を感じるようにしたい";
        return japaneseBullshit[(rand.nextDouble() * japaneseBullshit.length).floor()]; //true random
    }
    String replaceEverythingWithRandomJapanese(String input){
        List<String> words = input.split(" ");
        for(num i = 0; i<words.length; i++){
            words[i] = this.randomJapaneseBullshit();
        }
        return words.join(" ");
    }
    String handleReplacements(String input){
        String ret = input;
        for(num i = 0; i<this.lettersToReplace.length; i++){
            //querySelector("#debug").append("Replacing: " +this.lettersToReplace[i][0] );
            String replace = this.lettersToReplace[i][1] ;
            if(replace == "私"){
                ret = this.replaceEverythingWithRandomJapanese(ret);
            }
            ret= ret.replaceAll(this.lettersToReplace[i][0],replace);
        }
        return ret;
    }
    String handleReplacementsIgnoreCase(String input){
        String ret = input;
        for(num i = 0; i<this.lettersToReplaceIgnoreCase.length; i++){
            //querySelector("#debug").append("Replacing: " +this.lettersToReplaceIgnoreCase[i][0] );
            ////print("Replacing: " +this.lettersToReplaceIgnoreCase[i][0] );
            //g makes it replace all, i makes it ignore case
            String replace = this.lettersToReplaceIgnoreCase[i][1] ;
            if(replace == "私"){
                ret = this.replaceEverythingWithRandomJapanese(ret);
            }
            ret= ret.replaceAll(new RegExp(this.lettersToReplaceIgnoreCase[i][0], caseSensitive: false),replace);
        }

        //ret= ret.replaceAll(new RegExp("B", caseSensitive: false),"[B]");
        return ret;
    }
    String handlePunctuation(String input){
        String ret = input;
        if(this.punctuation==0){
            String punctuationless = ret.replaceAll(new RegExp(r"[.?,\/#!;{}=\-_`~]", multiLine:true),"");
            ret = punctuationless.replaceAll(new RegExp(r"""\s{2,}""", multiLine:true)," ");
        }else if(this.punctuation==1){
            String punctuationless = ret.replaceAll(new RegExp(r"[,\/#;{}=\-_`~]", multiLine:true),"");
            ret = punctuationless.replaceAll(new RegExp(r"""\s{2,}""", multiLine:true)," ");
        }else if(this.punctuation==2){
            ret = input;
        }else if(this.punctuation==3){
            ret = multiplyCharacter(ret,"!", this.favoriteNumber);
            ret = multiplyCharacter(ret,"?", this.favoriteNumber);
        }
        return ret;
    }
    void lowBloodVocabulary(){
        //Troll words: year, month, refrigerator, bathtub, ears, heart, brain,rap,nose,mouth,bed,tea,worm,beans,tree,legs,eyes, gold star,born,toilet,foot,spine,vampire,tits,baby,
        //red blood adds all of these, mid blood adds half, and eridan or above adds none.
        //which ones you add are random.
        List<List<String>> words = [["\\byear\\b","sweep"],["SBURB","SGRUB"],["\\bmonth\\b","perigee"],["\\brefrigerator\\b","\\bthermal hull\\b"],["\\bbathtub\\b","ablution trap"],["\\bears\\b","hear ducts "],["\\bheart\\b","pump biscuit"],["\\bbrain\\b","sponge"],["\\brap\\b","slam poetry"],["\\bnose\\b","sniffnode"],["\\bmouth\\b","squawk gaper"],["\\bbed\\b", "cocoon"],["\\btea\\b","scalding leaf fluid"],["\\bworm", "dirt noodle"],["\\bbean","fart nibblet"],["\\btree\\b","frond nub"],["\\bleg\\b","frond"],["\\bgold star\\b","glitter biscuit"],["\\bborn\\b","hatched"],["\\btoilet\\b","load gaper"],["\\bfoot\\b","prong"],["\\bspine\\b","posture pole"],["vampire","rainbow drinker"],["\\btits\\b","rumble spheres"],["\\bbaby\\b","wiggler"],["eye","gander bulb"]];
        this.lettersToReplaceIgnoreCase.addAll(words);
    }



    void addNumberQuirk(){
        if(this.favoriteNumber == 1){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["I","1"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["i","1"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["l","1"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["L","1"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["won","1"]);
        }else if(this.favoriteNumber == 2){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["S","2"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["s","2"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["Z","2"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["z","2"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["too","2"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["to","2"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["two","2"]);
        }else if(this.favoriteNumber == 3){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["E","3"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["e","3"]);
        }else if(this.favoriteNumber == 4){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["A","4"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["a","4"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["for","4"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["four","4"]);
        }else if(this.favoriteNumber == 5){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["S","5"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["s","5"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["Z","5"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["J","5"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["z","5"]);
        }else if(this.favoriteNumber == 6){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["G","6"]);
        }else if(this.favoriteNumber == 7){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["T","7"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["t","7"]);
        }else if(this.favoriteNumber == 8){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["ate","8"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["eight","8"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["EIGHT","8"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["B","8"]);
        }else if(this.favoriteNumber == 9){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["g","9"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["nine","9"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["NINE","9"]);
        }else if(this.favoriteNumber == 10){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["ten","10"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["TEN","10"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["lo","10"]);
        }else if(this.favoriteNumber == 11){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["ll","11"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["II","11"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["ii","11"]);
        }else if(this.favoriteNumber == 12){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["is","12"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["IS","12"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["iz","12"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["IZ","12"]);
        }else if(this.favoriteNumber == 0){
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["o","0"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["O","0"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["oh","0"]);
            if(this.rand.nextDouble()>0.5) this.lettersToReplace.add(["OH","0"]);
        }
    }




    String handleCapitilization(String input){
        String ret = input;
        if(this.capitalization== 0){
            ret = ret.toLowerCase();
        }else if(this.capitalization== 4){
            for(num i = 0; i<input.length; i++){
                if(i%2 == 0){
                    ret = replaceStringAt(ret, i, ret[i].toLowerCase());
                }else{
                    ret = replaceStringAt(ret, i, ret[i].toUpperCase());
                }
            }
        }else if(this.capitalization== 5){
            for(num i = 0; i<input.length; i++){
                if(ret[i] == ret[i].toUpperCase()){
                    ret = replaceStringAt(ret, i, ret[i].toLowerCase());
                }else{
                    ret = replaceStringAt(ret, i, ret[i].toUpperCase());
                }
            }
        }else if(this.capitalization== 3){
            ret = ret.replaceAllMapped(new RegExp(r"\b\w", multiLine:true), (l){ return l.group(0).toUpperCase(); })  ;//this version works with old IE browsers.;
        }else if(this.capitalization== 1){
            ret = input; //no change
        }else if(this.capitalization== 2){
            ret = ret.toUpperCase();
        }
        return ret;
    }



    String replaceStringAt(String str, int index, String character){
        return str.substring(0, index) + character + str.substring(index+character.length);
    }



    static String multiplyCharacter(String str, String character, int times){
        //querySelector("#debug").append("<Br>Going to multiply: " + character + " this many times: " + times);
        String tmp = "";
        for(int i = 0; i<times; i++){
            tmp += character;
        }
        return str.replaceAll(character, tmp);
    }



    static Quirk randomHumanQuirk(Random rand){
        Quirk ret = new Quirk(rand);
        ret.capitalization = rand.nextIntRange(0,2);
        ret.punctuation = rand.nextIntRange(0,3);
        if(ret.capitalization == 2 && rand.nextDouble() >0.2){ //seriously, less all caps.
            ret.capitalization = rand.nextIntRange(0,1);
        }
        int roomLeft = rand.nextIntRange(0,6) - ret.lettersToReplace.length;
        if(roomLeft < 0) roomLeft = 0;
        for(int i = 0; i<roomLeft; i++){
            ret.lettersToReplace.add(getOneNormalReplaceArray(rand));
        }
        //querySelector("#debug").append("Human letters to replace: " + ret.lettersToReplace.length);
        return ret;
    }



    int randomCapitalQuirk(Random rand){
        return rand.nextIntRange(0,5);

    }



//troll quirks are more extreme
    static Quirk randomTrollQuirk(Random rand){
        Quirk ret = new Quirk(rand);
        ret.capitalization = ret.rand.nextIntRange(0,5);
        ret.punctuation = ret.rand.nextIntRange(0,5);
        if(ret.rand.nextDouble() > .5){
            ret.prefix = ret.rand.pickFrom(prefixes);
            if(ret.prefix.length == 1){
                ret.prefix = multiplyCharacter(ret.prefix, ret.prefix[0], ret.favoriteNumber);
            }
        }
        if(ret.rand.nextDouble() > .5){
            if(ret.prefix != "" && ret.rand.nextDouble()>.7){ //mostly just repeat your prefix
                ret.suffix = ret.prefix;
            }else{
                ret.suffix = ret.rand.pickFrom(prefixes);
            }

            if(ret.suffix.length == 1){
                ret.suffix  = multiplyCharacter(ret.suffix, ret.suffix[0], ret.favoriteNumber);
            }
        }

        ret.addNumberQuirk();
        int roomLeft = ret.rand.nextIntRange(0,6) - ret.lettersToReplace.length;
        if(roomLeft < 0) roomLeft = 0;
        for(int i = 0; i<roomLeft; i++){
            ret.lettersToReplace.add(getOneRandomReplaceArray(rand));
        }

        return ret;
    }




    static List<String> getOneNormalReplaceArray(Random rand){
        //these should ignore case.
        return rand.pickFrom(conversational_quirks);
    }



    List<String> getOneRandomFishArray(Random rand){
        return rand.pickFrom(fish_quirks);
    }



//% to cross or x.  8 for b.  69 for oo.  o+ for o
    static List<String> getOneRandomReplaceArray(Random rand){
        List<List<String>> arr = [["x","%"],["X","%"],["s","z"],["w","vv"],["w","v"],["v","w"],["!","~"],["N","|\\/"],["\\b[a-z]*\\b","私"]];
        arr.add(["M","|\\/|"]);
        arr.add(["W","\\/\\/"]);
        arr.add(["H",")("]);
        arr.add(["H","|-|"]);
        arr.add(["H","#"]);
        arr.add(["i","!"]);
        arr.add(["I","!"]);
        arr.add(["o","*"]);
        arr.add(["a","@"]);
        arr.add(["at","@"]);
        arr.add(["and","&"]);
        arr.add(["n","^"]);
        arr.add(["oo","69"]);
        arr.add(["OO","69"]);
        arr.add(["o","o+"]);
        arr.add(["plus","+"]);
        arr.add(["happy",":)"]);
        arr.add(["sad",":("]);
        arr.add(["love","<3"]);
        arr.add(["loo","100"]);
        arr.add(["dog","cat"]);
        arr.add(["s","th"]);
        arr.add(["c","s"]);
        arr.add(["per","purr"]);
        arr.add(["mu","mew"]);
        arr.add(["b","[B]"]);
        arr.add(["B","[B]"]);


        if(rand.nextDouble() > .5){
            return rand.pickFrom(arr);
        }

        return getOneNormalReplaceArray(rand); //if i get here, just do a normal one.
    }


}

