
import "Dolls/Doll.dart";
import "Dolls/HomestuckDoll.dart";
import "Dolls/HomestuckTrollDoll.dart";
import "dart:html";
import 'dart:async';
import "SpriteLayer.dart";
import "includes/colour.dart";
import "includes/palette.dart";
import "random.dart";
import "loader/loader.dart";
import "Dolls/ConsortDoll.dart";
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

    static Colour HAIR = new Colour.fromHex(0x313131);
    static Colour HAIR_ACCESSORY = new Colour.fromHex(0x202020);

    static HomestuckPalette SPRITE_PALETTE = new HomestuckPalette()
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

    static Map<String, Palette> _paletteList;


    static Map<String, Palette> get paletteList {
        if(_paletteList == null) {
            _paletteList = new Map<String, Palette>();
            _paletteList["Robot"] = ROBOT_PALETTE;
            _paletteList["Prospit"] = PROSPIT_PALETTE;
            _paletteList["Derse"] = DERSE_PALETTE;
        }

        return _paletteList;
    }
}
