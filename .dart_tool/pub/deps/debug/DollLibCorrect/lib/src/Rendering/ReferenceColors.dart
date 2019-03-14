import "package:CommonLib/Colours.dart";

import "../Dolls/ConsortDoll.dart";
import "../Dolls/KidBased/HomestuckDoll.dart";
import '../Dolls/KidBased/HomestuckLamiaDoll.dart';
import "../Dolls/KidBased/HomestuckTrollDoll.dart";
import "../Dolls/QueenDoll.dart";

abstract class ReferenceColours {
    static Colour WHITE = new Colour.fromHex(0xFFFFFF);
    static Colour BLACK = new Colour.fromHex(0x000000);
    static Colour RED = new Colour.fromHex(0xFF0000);
    static Colour LIME = new Colour.fromHex(0x00FF00);

    static Colour LIME_CORRECTION = new Colour.fromHex(0x00FF2A);

    static Colour GRIM = new Colour.fromHex(0x424242);
    static Colour GREYSKIN = new Colour.fromHex(0xC4C4C4);
    static Colour GRUB = new Colour.fromHex(0x585858);
    static Colour ROBOT = new Colour.fromHex(0xB6B6B6);
    static Colour ECHELADDER = new Colour.fromHex(0x4A92F7);
    static Colour BLOOD_PUDDLE = new Colour.fromHex(0xFFFC00);
    static Colour BLOODY_FACE = new Colour.fromHex(0x440A7F);
    static Colour SYMBOL = new Colour.fromStyleString('#FEFD49');

    static Colour HAIR = new Colour.fromHex(0x313131);
    static Colour HAIR_ACCESSORY = new Colour.fromHex(0x202020);

    static CharSheetPalette CHAR_SHEET_PALETTE = new CharSheetPalette()
        ..aspect_light = '#FEFD49';

    static QueenPalette QUEEN_PALETTE = new QueenPalette()
        ..carapace = '#000000'
        ..cracks = "ffffff";


    static HomestuckPalette SPRITE_PALETTE = new HomestuckPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FEFD49' //eyes
        ..aspect_dark = '#FEC910'
        ..shoe_light = '#10E0FF'
        ..shoe_dark = '#00A4BB'
        ..cloak_light = '#FA4900'
        ..cloak_mid = '#E94200'
        ..cloak_dark = '#C33700'
        ..shirt_light = '#FF8800'  //consort belly
        ..shirt_dark = '#D66E04' //consort belly outline
        ..pants_light = '#E76700'//consort side
        ..pants_dark = '#CA5B00'//consort outline
        ..hair_main = '#313131'
        ..hair_accent = '#202020'
        ..eye_white_left = '#ffba35'
        ..eye_white_right = '#ffba15'
        ..skin = '#ffffff';

    static HomestuckTrollPalette TROLL_PALETTE = new HomestuckTrollPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FEFD49'
        ..aspect_dark = '#FEC910'
        ..wing1 = '#00FF2A'
        ..wing2 = '#FF0000'
        ..aspect_dark = '#FEC910'
        ..shoe_light = '#10E0FF'
        ..shoe_dark = '#00A4BB'
        ..cloak_light = '#FA4900'
        ..cloak_mid = '#E94200'
        ..cloak_dark = '#C33700'
        ..shirt_light = '#FF8800'
        ..shirt_dark = '#D66E04'
        ..pants_light = '#E76700'
        ..pants_dark = '#CA5B00'
        ..hair_main = '#313131'
        ..hair_accent = '#202020'
        ..eye_white_left = '#ffba35'
        ..eye_white_right = '#ffba15'
        ..skin = '#ffffff';

    static HomestuckLamiaPalette LAMIA_PALETTE = new HomestuckLamiaPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FEFD49'
        ..aspect_dark = '#FEC910'
        ..wing1 = '#00FF2A'
        ..wing2 = '#FF0000'
        ..aspect_dark = '#FEC910'
        ..shoe_light = '#10E0FF'
        ..shoe_dark = '#00A4BB'
        ..cloak_light = '#FA4900'
        ..cloak_mid = '#E94200'
        ..cloak_dark = '#C33700'
        ..shirt_light = '#FF8800'
        ..shirt_dark = '#D66E04'
        ..pants_light = '#E76700'
        ..pants_dark = '#CA5B00'
        ..hair_main = '#313131'
        ..hair_accent = '#202020'
        ..eye_white_left = '#ffba35'
        ..eye_white_right = '#ffba15'
        ..skinDark = '#b5b5b5'
        ..horn1 = "#ffba29"
        ..horn2 = "#ff9000"
        ..horn3 = "#ff4200"
        ..skin = '#ffffff';





    static ConsortPalette  CONSORT_PALETTE = new ConsortPalette()
        ..eyes = '#FEFD49'
        ..belly = '#FF8800'
        ..bellyoutline = '#D66E04'
        ..side = '#E76700'
        ..lightest_part = '#ffcd92'
        ..outline = '#CA5B00';

    static HomestuckPalette PROSPIT_PALETTE = new HomestuckPalette()
        ..aspect_light = "#FFFF00"
        ..aspect_dark = "#FFC935"
    // no shoe colours here on purpose
        ..cloak_light = "#FFCC00"
        ..cloak_mid = "#FF9B00"
        ..cloak_dark = "#C66900"
        ..shirt_light = "#FFD91C"
        ..shirt_dark = "#FFE993"
        ..pants_light = "#FFB71C"
        ..pants_dark = "#C67D00";

    static HomestuckPalette DERSE_PALETTE = new HomestuckPalette()
        ..aspect_light = "#F092FF"
        ..aspect_dark = "#D456EA"
    // no shoe colours here on purpose
        ..cloak_light = "#C87CFF"
        ..cloak_mid = "#AA00FF"
        ..cloak_dark = "#6900AF"
        ..shirt_light = "#DE00FF"
        ..shirt_dark = "#E760FF"
        ..pants_light = "#B400CC"
        ..pants_dark = "#770E87";



    static HomestuckPalette ROBOT_PALETTE = new HomestuckPalette()
        ..aspect_light = "#0000FF"
        ..aspect_dark = "#0022cf"
        ..shoe_light = "#B6B6B6"
        ..shoe_dark = "#A6A6A6"
        ..cloak_light = "#484848"
        ..cloak_mid = "#595959"
        ..cloak_dark = "#313131"
        ..shirt_light = "#B6B6B6"
        ..shirt_dark = "#797979"
        ..pants_light = "#494949"
        ..pants_dark = "#393939";

    static HomestuckPalette BLOOD = new HomestuckPalette()
        ..accent = "#993300"
        ..aspect_light = '#BA1016'
        ..aspect_dark = '#820B0F'
        ..shoe_light = '#381B76'
        ..shoe_dark = '#1E0C47'
        ..cloak_light = '#290704'
        ..cloak_mid = '#230200'
        ..cloak_dark = '#110000'
        ..shirt_light = '#3D190A'
        ..shirt_dark = '#2C1207'
        ..pants_light = '#5C2913'
        ..pants_dark = '#4C1F0D';


    static HomestuckPalette BREATH = new HomestuckPalette()
        ..accent = "#3399ff"
        ..aspect_light = '#10E0FF'
        ..aspect_dark = '#00A4BB'
        ..shoe_light = '#FEFD49'
        ..shoe_dark = '#D6D601'
        ..cloak_light = '#0052F3'
        ..cloak_mid = '#0046D1'
        ..cloak_dark = '#003396'
        ..shirt_light = '#0087EB'
        ..shirt_dark = '#0070ED'
        ..pants_light = '#006BE1'
        ..pants_dark = '#0054B0';

    static HomestuckPalette DOOM = new HomestuckPalette()
        ..accent = "#003300"
        ..aspect_light = '#0F0F0F'
        ..aspect_dark = '#010101'
        ..shoe_light = '#E8C15E'
        ..shoe_dark = '#C7A140'
        ..cloak_light = '#1E211E'
        ..cloak_mid = '#141614'
        ..cloak_dark = '#0B0D0B'
        ..shirt_light = '#204020'
        ..shirt_dark = '#11200F'
        ..pants_light = '#192C16'
        ..pants_dark = '#121F10';

    static HomestuckPalette DREAM = new HomestuckPalette()
        ..accent = "#9630BF"
        ..aspect_light = '#cc87e8'
        ..aspect_dark = '#9545b7'
        ..shoe_light = '#ae769b'
        ..shoe_dark = '#8f577c'
        ..cloak_light = '#9630bf'
        ..cloak_mid = '#693773'
        ..cloak_dark = '#4c2154'
        ..shirt_light = '#fcf9bd'
        ..shirt_dark = '#e0d29e'
        ..pants_light = '#bdb968'
        ..pants_dark = '#ab9b55';

    static HomestuckPalette HEART = new HomestuckPalette()
        ..accent = "#ff3399"
        ..aspect_light = '#BD1864'
        ..aspect_dark = '#780F3F'
        ..shoe_light = '#1D572E'
        ..shoe_dark = '#11371D'
        ..cloak_light = '#4C1026'
        ..cloak_mid = '#3C0D1F'
        ..cloak_dark = '#260914'
        ..shirt_light = '#6B0829'
        ..shirt_dark = '#4A0818'
        ..pants_light = '#55142A'
        ..pants_dark = '#3D0E1E';

    static HomestuckPalette HOPE = new HomestuckPalette()
        ..accent = "#ffcc66"
        ..aspect_light = '#FDF9EC'
        ..aspect_dark = '#D6C794'
        ..shoe_light = '#164524'
        ..shoe_dark = '#06280C'
        ..cloak_light = '#FFC331'
        ..cloak_mid = '#F7BB2C'
        ..cloak_dark = '#DBA523'
        ..shirt_light = '#FFE094'
        ..shirt_dark = '#E8C15E'
        ..pants_light = '#F6C54A'
        ..pants_dark = '#EDAF0C';

    static HomestuckPalette LIFE = new HomestuckPalette()
        ..accent = "#494132"
        ..aspect_light = '#76C34E'
        ..aspect_dark = '#4F8234'
        ..shoe_light = '#00164F'
        ..shoe_dark = '#00071A'
        ..cloak_light = '#605542'
        ..cloak_mid = '#494132'
        ..cloak_dark = '#2D271E'
        ..shirt_light = '#CCC4B5'
        ..shirt_dark = '#A89F8D'
        ..pants_light = '#A29989'
        ..pants_dark = '#918673';

    static HomestuckPalette LIGHT = new HomestuckPalette()
        ..accent = "#ff9933"
        ..aspect_light = '#FEFD49'
        ..aspect_dark = '#FEC910'
        ..shoe_light = '#10E0FF'
        ..shoe_dark = '#00A4BB'
        ..cloak_light = '#FA4900'
        ..cloak_mid = '#E94200'
        ..cloak_dark = '#C33700'
        ..shirt_light = '#FF8800'
        ..shirt_dark = '#D66E04'
        ..pants_light = '#E76700'
        ..pants_dark = '#CA5B00';

    static HomestuckPalette MIND = new HomestuckPalette()
        ..accent = "#3da35a"
        ..aspect_light = '#06FFC9'
        ..aspect_dark = '#04A885'
        ..shoe_light = '#6E0E2E'
        ..shoe_dark = '#4A0818'
        ..cloak_light = '#1D572E'
        ..cloak_mid = '#164524'
        ..cloak_dark = '#11371D'
        ..shirt_light = '#3DA35A'
        ..shirt_dark = '#2E7A43'
        ..pants_light = '#3B7E4F'
        ..pants_dark = '#265133';

    static HomestuckPalette SAUCE = new HomestuckPalette()
        ..accent = "#00ff00"
        ..aspect_light = '#00ff00'
        ..aspect_dark = '#00ff00'
        ..shoe_light = '#00ff00'
        ..shoe_dark = '#00cf00'
        ..cloak_light = '#171717'
        ..cloak_mid = '#080808'
        ..cloak_dark = '#080808'
        ..shirt_light = '#616161'
        ..shirt_dark = '#3b3b3b'
        ..pants_light = '#4a4a4a'
        ..pants_dark = '#292929';

    static HomestuckPalette RAGE = new HomestuckPalette()
        ..accent = "#9900cc"
        ..aspect_light = '#974AA7'
        ..aspect_dark = '#6B347D'
        ..shoe_light = '#3D190A'
        ..shoe_dark = '#2C1207'
        ..cloak_light = '#7C3FBA'
        ..cloak_mid = '#6D34A6'
        ..cloak_dark = '#592D86'
        ..shirt_light = '#381B76'
        ..shirt_dark = '#1E0C47'
        ..pants_light = '#281D36'
        ..pants_dark = '#1D1526';

    static HomestuckPalette SPACE = new HomestuckPalette()
        ..accent = "#00ff00"
        ..aspect_light = '#EFEFEF'
        ..aspect_dark = '#DEDEDE'
        ..shoe_light = '#FF2106'
        ..shoe_dark = '#B01200'
        ..cloak_light = '#2F2F30'
        ..cloak_mid = '#1D1D1D'
        ..cloak_dark = '#080808'
        ..shirt_light = '#030303'
        ..shirt_dark = '#242424'
        ..pants_light = '#333333'
        ..pants_dark = '#141414';

    static HomestuckPalette TIME = new HomestuckPalette()
        ..accent = "#ff0000"
        ..aspect_light = '#FF2106'
        ..aspect_dark = '#AD1604'
        ..shoe_light = '#030303'
        ..shoe_dark = '#242424'
        ..cloak_light = '#510606'
        ..cloak_mid = '#3C0404'
        ..cloak_dark = '#1F0000'
        ..shirt_light = '#B70D0E'
        ..shirt_dark = '#970203'
        ..pants_light = '#8E1516'
        ..pants_dark = '#640707';

    static HomestuckPalette VOID = new HomestuckPalette()
        ..accent = "#000066"
        ..aspect_light = '#0B1030'
        ..aspect_dark = '#04091A'
        ..shoe_light = '#CCC4B5'
        ..shoe_dark = '#A89F8D'
        ..cloak_light = '#00164F'
        ..cloak_mid = '#00103C'
        ..cloak_dark = '#00071A'
        ..shirt_light = '#033476'
        ..shirt_dark = '#02285B'
        ..pants_light = '#004CB2'
        ..pants_dark = '#003E91';

    static HomestuckPalette SKETCH = new HomestuckPalette()
        ..accent = "#ffffff"
        ..aspect_light = '#000000'
        ..aspect_dark = '#000000'
        ..shoe_light = '#ffffff'
        ..hair_main = "#000000"
        ..hair_accent = "#ffffff"
        ..shoe_dark = '#000000'
        ..cloak_light = '#000000'
        ..cloak_mid = '#ffffff'
        ..cloak_dark = '#000000'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..pants_dark = '#000000';

    static HomestuckPalette INK = new HomestuckPalette()
        ..accent = "#000000"
        ..hair_main = "#ffffff"
        ..hair_accent = "#000000"
        ..aspect_light = '#ffffff'
        ..aspect_dark = '#ffffff'
        ..shoe_light = '#000000'
        ..shoe_dark = '#ffffff'
        ..cloak_light = '#ffffff'
        ..cloak_mid = '#000000'
        ..cloak_dark = '#ffffff'
        ..shirt_light = '#000000'
        ..shirt_dark = '#ffffff'
        ..pants_light = '#000000'
        ..pants_dark = '#ffffff';



    static HomestuckPalette FUSCHIA = new HomestuckPalette()
        ..accent = '#696969'
        ..aspect_light = '#99004d'
        ..aspect_dark = '#77002b'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#99004d'
        ..cloak_mid = '#77002b'
        ..cloak_dark = '#550009'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#99004d';

    static HomestuckPalette VIOLET = new HomestuckPalette()
        ..accent = '#610061'
        ..aspect_light = '#610061'
        ..aspect_dark = '#400040'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#610061'
        ..cloak_mid = '#390039'
        ..cloak_dark = '#280028'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#610061';

    static HomestuckPalette PURPLE = new HomestuckPalette()
        ..accent = '#631db4'
        ..aspect_light = '#631db4'
        ..aspect_dark = '#410b92'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#631db4'
        ..cloak_mid = '#410b92'
        ..cloak_dark = '#200970'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#631db4';

    static HomestuckPalette INDIGO = new HomestuckPalette()
        ..accent = '#0021cb'
        ..aspect_light = '#0021cb'
        ..aspect_dark = '#0000a9'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#0021cb'
        ..cloak_mid = '#0000a9'
        ..cloak_dark = '#000087'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#0021cb';

    static HomestuckPalette CERULEAN = new HomestuckPalette()
        ..accent = '#004182'
        ..aspect_light = '#004182'
        ..aspect_dark = '#002060'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#004182'
        ..cloak_mid = '#002060'
        ..cloak_dark = '#000040'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#004182';

    static HomestuckPalette JADE = new HomestuckPalette()
        ..accent = '#078446'
        ..aspect_light = '#078446'
        ..aspect_dark = '#056224'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#078446'
        ..cloak_mid = '#056224'
        ..cloak_dark = '#034002'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#078446';

    static HomestuckPalette OLIVE = new HomestuckPalette()
        ..accent = '#416600'
        ..aspect_light = '#416600'
        ..aspect_dark = '#204400'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#416600'
        ..cloak_mid = '#204400'
        ..cloak_dark = '#002200'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#416600';

    static HomestuckPalette LIMEBLOOD = new HomestuckPalette()
        ..accent = '#658200'
        ..aspect_light = '#658200'
        ..aspect_dark = '#436000'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#658200'
        ..cloak_mid = '#436000'
        ..cloak_dark = '#214000'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#658200';

    static HomestuckPalette GOLD = new HomestuckPalette()
        ..accent = '#a1a100'
        ..aspect_light = '#a1a100'
        ..aspect_dark = '#808000'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#a1a100'
        ..cloak_mid = '#808000'
        ..cloak_dark = '#606000'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#a1a100';

    static HomestuckPalette BRONZE = new HomestuckPalette()
        ..accent = '#a25203'
        ..aspect_light = '#a25203'
        ..aspect_dark = '#803001'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#a25203'
        ..cloak_mid = '#803001'
        ..cloak_dark = '#601000'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#a25203';

    static HomestuckPalette BURGUNDY = new HomestuckPalette()
        ..accent = '#A10000'
        ..aspect_light = '#A10000'
        ..aspect_dark = '#800000'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#A10000'
        ..cloak_mid = '#800000'
        ..cloak_dark = '#600000'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#A10000';

    static HomestuckPalette TEAL = new HomestuckPalette()
        ..accent = '#008282'
        ..aspect_light = '#008282'
        ..aspect_dark = '#006060'
        ..shoe_light = '#006060'
        ..shoe_dark = '#333333'
        ..shoe_dark = '#666666'
        ..cloak_light = '#008282'
        ..cloak_mid = '#006060'
        ..cloak_dark = '#004040'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#008282';

    static HomestuckPalette ANON = new HomestuckPalette()
        ..accent = '#696969'
        ..aspect_light = '#696969'
        ..aspect_dark = '#888888'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#696969'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#000000';


    static HomestuckPalette JUICE = new HomestuckPalette()
        ..accent = '#BF2236'
        ..aspect_light = '#FFF775'
        ..aspect_dark = '#E5BB06'
        ..shoe_light = '#508B2D'
        ..shoe_dark = '#316C0D'
        ..cloak_light = '#BF2236'
        ..cloak_mid = '#A81E2F'
        ..cloak_dark = '#961B2B'
        ..shirt_light = '#DD2525'
        ..shirt_dark = '#A8000A'
        ..pants_light = '#B8151F'
        ..pants_dark = '#8C1D1D'
        ..hair_accent = '#FFF775';

    static HomestuckPalette CORRUPT = new HomestuckPalette()
        ..shoe_light = '#00ff00'
        ..shoe_dark = '#00ff00'
        ..cloak_light = '#85afff'
        ..cloak_mid = '#789ee6'
        ..cloak_dark = '#7393d0'
        ..shirt_light = '#291d53'
        ..shirt_dark = '#201546'
        ..pants_light = '#131313'
        ..pants_dark = '#000000'
        ..hair_main = "#000000"
        ..hair_accent = '#00ff00'
        ..eye_white_left = "#000000"
        ..eye_white_right = "#000000"
        ..skin = '#494949';

    static HomestuckPalette PURIFIED = new HomestuckPalette()
        ..shoe_light = '#ffa8ff'
        ..shoe_dark = '#ff5bff'
        ..cloak_light = '#f8dc57'
        ..cloak_mid = '#d1a93b'
        ..cloak_dark = '#ad871e'
        ..shirt_light = '#eae8e7'
        ..shirt_dark = '#bfc2c1'
        ..pants_light = '#03500e'
        ..pants_dark = '#00341a'
        ..eye_white_left = "#ffa8ff"
        ..eye_white_right = "#ffa8ff"
        ..skin = '#8ccad6';

    static HomestuckPalette HISSIE = new HomestuckPalette()
        ..shoe_light = '#333333'
        ..shoe_dark = '#111111'
        ..shirt_light = '#03500e'
        ..shirt_dark = '#084711'
        ..hair_main = "#482313"
        ..hair_accent = '#ffa8ff'
        ..eye_white_left = "#fefefe"
        ..eye_white_right = "#fefefe"
        ..accent = '#000000'
        ..skin = '#f8dc57';


    static HomestuckPalette CROCKERTIER = new HomestuckPalette()
        ..accent = '#ff0000'
        ..aspect_light = '#fcfcfc'
        ..aspect_dark = '#f2f2f2'
        ..shoe_light = '#000000'
        ..shoe_dark = '#313133'
        ..cloak_light = '#ff0000'
        ..cloak_mid = '#ff0100'
        ..cloak_dark = '#ad0001'
        ..shirt_light = '#d30000'
        ..shirt_dark = '#ae0000'
        ..pants_light = '#000000'
        ..pants_dark = '#313133'
        ..hair_accent = '#ff0000';


    static Map<String, Palette> _paletteList;


    static Map<String, Palette> get paletteList {
        if(_paletteList == null) {
            _paletteList = new Map<String, Palette>();
            _paletteList["Blood"] = BLOOD;
            _paletteList["Mind"] = MIND;
            _paletteList["Sauce"] = SAUCE;
            _paletteList["Juice"] = JUICE;
            _paletteList["Rage"] = RAGE;
            _paletteList["Void"] = VOID;
            _paletteList["Time"] = TIME;
            _paletteList["Heart"] = HEART;
            _paletteList["Breath"] = BREATH;
            _paletteList["Light"] = LIGHT;
            _paletteList["Space"] = SPACE;
            _paletteList["Hope"] = HOPE;
            _paletteList["Life"] = LIFE;
            _paletteList["Doom"] = DOOM;
            _paletteList["Dream"] = DREAM;
            _paletteList["Robot"] = ROBOT_PALETTE;
            _paletteList["Prospit"] = PROSPIT_PALETTE;
            _paletteList["Derse"] = DERSE_PALETTE;
            _paletteList["Corrupt"] = CORRUPT;
            _paletteList["Purified"] = PURIFIED;
            _paletteList["Hissie"] = HISSIE;

            _paletteList["CrockerTier"] = CROCKERTIER;
            _paletteList["Sketch"] = SKETCH;
            _paletteList["Ink"] = INK;
            _paletteList["Burgundy"] = BURGUNDY;
            _paletteList["Bronze"] = BRONZE;
            _paletteList["Gold"] = GOLD;
            _paletteList["Lime"] = LIMEBLOOD;
            _paletteList["Olive"] = OLIVE;
            _paletteList["Jade"] = JADE;
            _paletteList["Teal"] = TEAL;
            _paletteList["Cerulean"] = CERULEAN;
            _paletteList["Indigo"] = INDIGO;
            _paletteList["Purple"] = PURPLE;
            _paletteList["Violet"] = VIOLET;
            _paletteList["Fuschia"] = FUSCHIA;
            _paletteList["Anon"] = ANON;
        }

        return _paletteList;
    }
}
