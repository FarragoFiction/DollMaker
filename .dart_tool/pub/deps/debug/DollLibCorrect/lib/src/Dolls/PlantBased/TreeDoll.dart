import "dart:math" as Math;
import "../../../DollRenderer.dart";
import "../../Rendering/ReferenceColors.dart";
import "../../commonImports.dart";
import "../Doll.dart";
import "../Layers/SpriteLayer.dart";


/*

prototype for a doll that has positioned layers
 */
class TreeDoll extends Doll{

    List<TreeForm> forms = new List<TreeForm>();
    //for drawing leaves on, only want to get branches once
    CanvasElement branchCache;
    //for drawing fruit and other hangables only want to get tree once
    CanvasElement leavesAndBranchCache;

    List<SpriteLayer> get hangables => renderingOrderLayers.where((SpriteLayer s) => s is PositionedDollLayer && (s.name.contains("Hang") || !s.name.contains("Leaf"))  );
    List<SpriteLayer> get clusters => renderingOrderLayers.where((SpriteLayer s) => s is PositionedDollLayer && (s.name.contains("Cluster") || s.name.contains("Leaf")));


    @override
    List<Palette> validPalettes = new List<Palette>.from(ReferenceColours.paletteList.values);


    TreeForm get form {
        for(TreeForm form in forms) {
            if(form.hasForm(this)) return form;
        }
        //just assume it's a tree
        return forms.first;
    }

  int minFruit = 3;
  int maxFruit = 13;
  int minLeaf = 13;
  int maxLeaf = 33;




  @override
  String originalCreator = "jadedResearcher and dystopicFuturism";

  @override
  int renderingType =33;

  bool fruitTime = false;
  bool flowerTime = false;

  @override
  int width = 500;
  @override
  int height = 500;

  @override
  String name = "Tree";

    @override
    Colour get associatedColor {
         return  (palette as HomestuckPalette).shoe_light;
    }

  @override
  String relativefolder = "images/Tree";
  final int maxBranches = 32;
  final int maxLeaves = 18;

  int fruitWidth = 50;
  int fruitHeight = 50;
    int leafWidth = 100;
    int leafHeight = 100;

    //have limited memory so i have more even distribution
    int lastXForHangable = 0;
    int lastYForHangable = 0;


  SpriteLayer branches;
  PositionedLayer leavesFront;
  PositionedLayer leavesBack;

  Doll leafTemplate;
  Doll fruitTemplate;
  Doll flowerTemplate;

  //not a get, so i can add flowers/fruit to it over time.
  @override
  List<SpriteLayer>   renderingOrderLayers = new List <SpriteLayer>();
  @override
  List<SpriteLayer>   dataOrderLayers =new List <SpriteLayer>();


  @override
  Palette palette = new HomestuckPalette()
    ..accent = '#FF9B00'
    ..aspect_light = '#FF9B00'
    ..aspect_dark = '#FF8700'
    ..shoe_light = '#7F7F7F'
    ..shoe_dark = '#727272'
    ..cloak_light = '#A3A3A3'
    ..cloak_mid = '#999999'
    ..cloak_dark = '#898989'
    ..shirt_light = '#EFEFEF'
    ..shirt_dark = '#DBDBDB'
    ..pants_light = '#C6C6C6'
    ..eye_white_left = '#ffffff'
    ..eye_white_right = '#ffffff'
    ..pants_dark = '#ADADAD'
    ..hair_main = '#ffffff'
    ..hair_accent = '#ADADAD'
    ..skin = '#ffffff';



  TreeDoll() {
      //print("making a new tree");
      forms.addAll(<TreeForm>[new TreeForm(), new BushForm(), new LeftForm(), new RightFrom()]);
      rand.nextInt(); //init;
      initPalettes();
      initLayers();
      randomize();
  }

  void initPalettes() {
      for(int i = 0; i < 13*2; i++) {
          validPalettes.add(makeRandomPalette());
      }
  }



  //HELL YES i found the source of the save bug.
  //i'm not supposed to use premade palettes like this, instead,
  //how does the drop downs work?
  @override
  void randomizeColors() {
    if(rand == null) rand = new Random(seed);
    validPalettes.remove(ReferenceColours.ANON);
    validPalettes.remove(ReferenceColours.BRONZE);
    validPalettes.remove(ReferenceColours.GOLD);
    validPalettes.remove(ReferenceColours.OLIVE);
    validPalettes.remove(ReferenceColours.LIMEBLOOD);
    validPalettes.remove(ReferenceColours.JADE);
    validPalettes.remove(ReferenceColours.TEAL);
    validPalettes.remove(ReferenceColours.CERULEAN);
    validPalettes.remove(ReferenceColours.INDIGO);
    validPalettes.remove(ReferenceColours.PURPLE);
    validPalettes.remove(ReferenceColours.VIOLET);
    validPalettes.remove(ReferenceColours.FUSCHIA);

    Palette newPallete = rand.pickFrom(validPalettes);
    copyPalette(newPallete);
  }

    Future<CanvasElement> renderJustBranches() async {
        await beforeRender();
        CanvasElement newCanvas = new CanvasElement(width: width, height: height);
        await DollRenderer.drawSubsetLayers(newCanvas, this, <SpriteLayer>[branches]);
        return newCanvas;
    }

    Future<CanvasElement> renderJustLeavesAndBranches() async {
        await beforeRender();
        CanvasElement newCanvas = new CanvasElement(width: width, height: height);
        List<SpriteLayer> leaves = <SpriteLayer>[leavesFront,branches, leavesBack];
        leaves.addAll(clusters);
        await DollRenderer.drawSubsetLayers(newCanvas, this, leaves);
        return newCanvas;
    }

    Future<CanvasElement> renderJustHangables() async {
        await beforeRender();
        CanvasElement newCanvas = new CanvasElement(width: width, height: height);
        List<SpriteLayer> leaves = <SpriteLayer>[];
        leaves.addAll(hangables);
        //print("going to be rendering hangables: $hangables");
        await DollRenderer.drawSubsetLayers(newCanvas, this, leaves);
        return newCanvas;
    }

    void transformHangablesInto([Doll template]) {
      if(template == null) {
            if(fruitTemplate ==null) {
                spawnFruit();
            }

            template = fruitTemplate;
      }
        List<SpriteLayer> h = <SpriteLayer>[];
        h.addAll(hangables);
        for(PositionedDollLayer layer in h) {
            Doll backupDoll = layer.doll;
            layer.doll = template.clone();
            layer.doll.orientation = backupDoll.orientation;
            layer.doll.rotation = backupDoll.rotation;
        }
    }

    @override
    ImprovedByteReader initFromReader(ImprovedByteReader reader, [bool layersNeedInit = true]) {
      reader = super.initFromReader(reader, layersNeedInit);
      //print("reader is $reader");
      try {
          //builder.appendExpGolomb(rotation);
          //        builder.appendExpGolomb(orientation);
          fruitTemplate = Doll.loadSpecificDollFromReader(reader,true);
        //  print("loaded a fruit template");
          flowerTemplate = Doll.loadSpecificDollFromReader(reader,true);
          //print("loaded a floewr template");
          //leaves are last because might not be stored
          leafTemplate = Doll.loadSpecificDollFromReader(reader,true);
          //print("loaded a leaf template");
      }catch(e,s) {
          //not a problem, this was just for debugging
          //print("no template data, $e, $s");
      }
      return reader;
    }

        @override
    ByteBuilder appendDataBytesToBuilder(ByteBuilder builder) {
      builder = super.appendDataBytesToBuilder(builder);


      if(fruitTemplate != null) {
          fruitTemplate.appendDataBytesToBuilder(builder);
      }

      if(flowerTemplate != null) {
          flowerTemplate.appendDataBytesToBuilder(builder);
      }
        //store it even if you aren't using it (kind of like recessive)
      //or it will bitch like a mother fucker
      if(leafTemplate != null) {
          leafTemplate.appendDataBytesToBuilder(builder);
      }

      return builder;
    }


    @override
    void afterBreeding(List<Doll> dolls) {
      //print("after breeding  being called");
        List<Doll> leaves = new List<Doll>();
        List<Doll> fruit = new List<Doll>();
        List<Doll> flowers = new List<Doll>();

        for(Doll d in dolls) {
            if(d is TreeDoll) {
                if(d.leafTemplate != null) leaves.add(d.leafTemplate);
                if(d.flowerTemplate != null) flowers.add(d.flowerTemplate);
                if(d.fruitTemplate != null) fruit.add(d.fruitTemplate);

            }
        }
        //print("breeding with ${leaves.length} leaves, ${flowers.length} flowers, and ${fruit.length} fruit");
        if(leaves.isNotEmpty)leafTemplate = Doll.breedDolls(leaves);
        if(flowers.isNotEmpty)flowerTemplate = Doll.breedDolls(flowers);
        if(fruit.isNotEmpty) {
          //  print("fruits to breed are $fruit");
            fruitTemplate = Doll.breedDolls(fruit);
            //print("chosen fruit template is $fruitTemplate");
        }
    }

  @override
  void randomizeNotColors() {
      //print("randomizing not colors, rendering order layers is $renderingOrderLayers");
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }

    //make clusters instead
    if(rand.nextBool()) {
        leavesFront.imgNumber = 0;
        leavesBack.imgNumber = 0;
    }
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  @override
    Doll spawn() {
        TreeDoll copy = this.clone();
        copy.renderingOrderLayers.clear();
        copy.initLayers();
        copy.randomize();
        return copy;
    }

  /*
    pick a valid ish point at random
    draw this tree (no color replacement).
    check right and down from this point till you find a valid point. if you never do, give up.
    (never look left and up because whatever, this should be good enough for now)

    if it's not for leaf, then in addition to leaves front and back, it ALSO checks for cluster leaves
   */

  Future<Null> getBranchCache() async {
      if(branchCache == null) {
          branchCache = new CanvasElement(
              width: width, height: height);
          //not a for loop because don't do fruit
          await branches.drawSelf(branchCache);
      }

      return branchCache;
  }


  Future<Null> getTreeCache() async {
      if(leavesAndBranchCache == null) {
          leavesAndBranchCache = new CanvasElement(
              width: width, height: height);
          await leavesFront.drawSelf(leavesAndBranchCache);
          await branches.drawSelf(leavesAndBranchCache);
          await leavesBack.drawSelf(leavesAndBranchCache);
          List<SpriteLayer> tmp = clusters;
          for (SpriteLayer l in tmp) {
              await l.drawSelf(leavesAndBranchCache);
          }
      }
      return leavesAndBranchCache;
  }

  Future<Math.Point> randomValidPointOnTree(bool forLeaf) async {
      //print("looking for a valid point on tree");
      Point guess = spacedHangableXY();
      int xGuess = guess.x;
      if(xGuess == form.canopyWidth) xGuess = form.leafX;
      int yGuess = guess.y;
      if(yGuess == form.canopyHeight) yGuess = form.leafY;
      CanvasElement pointFinderCanvas;
      //handles caching shit, no need to redraw for each leave/fruit
      if(forLeaf) {
          pointFinderCanvas = await getBranchCache();
      }else {
          pointFinderCanvas = await getTreeCache();
      }

      //only look at leaf locations
      ImageData img_data = pointFinderCanvas.context2D.getImageData(xGuess, yGuess, form.canopyWidth-xGuess, form.canopyHeight-yGuess);
      for(int x = 0; x<form.canopyWidth-xGuess; x ++) {
          for(int y = 0; y<form.canopyHeight-yGuess; y++) {
              int i = (y * (form.canopyWidth-xGuess) + x) * 4;
              if(img_data.data[i+3] >100) {
                  //the '0' point for the data is xguess,yguess so take that into account.
                 // print("found valid position at ${x+xGuess}, ${y+yGuess} because alpha is ${img_data.data[i+3]}");
                  return keepInBounds(new Math.Point(x + xGuess, y + yGuess), forLeaf);
              }
          }

      }
      //print("returning null");
      return null;
  }

  Math.Point keepInBounds(Math.Point p, bool forLeaf) {
      int x = p.x;
      int y = p.y;
      int bufferWidth = fruitWidth;
      int bufferHeight = fruitHeight;
      if(forLeaf) {
        bufferWidth = leafWidth;
        bufferHeight = leafHeight;
      }
      if(p.x > width-bufferWidth) x = width-bufferWidth;
      if(p.x < bufferWidth) x = bufferWidth;

      if(p.y > height-bufferHeight) y = height-bufferHeight;
      if(p.y < bufferHeight) y = bufferHeight;
      return new Math.Point(x,y);

  }



  Math.Point spacedHangableXY() {
      int space = fruitWidth;
      //print("spacing fruits roughly $space apart");
      //go down a row
      if(lastXForHangable >= width-fruitWidth) {
          lastXForHangable = fruitWidth;
          //y only moves at row end
          lastYForHangable += rand.nextInt(space*2)+(space).round();
      }

      //don't go off screen.
      if(lastYForHangable >= height-fruitWidth) {
        lastYForHangable = fruitHeight;
      }

      //can move anywhere from 1 to 6 fruits away
      lastXForHangable += rand.nextInt(space*6)+(space).round();
      int yJitterDirection = 1;
      if(rand.nextBool()) yJitterDirection = -1;
      lastYForHangable += yJitterDirection* rand.nextInt(space*0.5.round());


      return new Point(lastXForHangable, lastYForHangable);
  }

  //deprecated
    int randomValidHangableX() {
      return rand.nextIntRange(form.leafX+leafWidth, form.leafX + form.canopyWidth-leafWidth);
  }

  //deprecated
  int randomVAlidHangableY() {
      return rand.nextIntRange(form.leafY+leafHeight, form.leafY + form.canopyHeight-leafHeight);
  }

   Colour getRandomFruitColor() {
      //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
      double color = rand.nextDouble(0.16); //up to green
      //60 to 180 is green so avoid that
      //.16 to 0.5
      if(rand.nextBool()) {
          color = rand.nextDouble(0.5) + 0.5; //blue to pink
      }
      return new Colour.hsv(color,1.0,rand.nextDouble()+0.5);
  }

     Colour getRandomLeafColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.44-0.16)+0.16;// up to green minus the reds
        return new Colour.hsv(color,rand.nextDouble()+0.5,rand.nextDouble()+0.1);
    }

     Colour getRandomBarkColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.13);// up to yellow
        return new Colour.hsv(color,rand.nextDouble()+0.25,rand.nextDouble()+0.1);
    }

   Palette makeRandomPalette() {
      //print("making a random palette for $name");
      HomestuckPalette newPalette = new HomestuckPalette();

      newPalette.add(HomestuckPalette.SHOE_LIGHT, getRandomFruitColor(),true);
     makeOtherColorsDarker(newPalette, HomestuckPalette.SHOE_LIGHT, <String>[HomestuckPalette.SHOE_DARK, HomestuckPalette.ACCENT]);

      newPalette.add(HomestuckPalette.ASPECT_LIGHT, getRandomFruitColor(),true);
      makeOtherColorsDarker(newPalette, HomestuckPalette.ASPECT_LIGHT, <String>[HomestuckPalette.ASPECT_DARK]);

      newPalette.add(HomestuckPalette.HAIR_MAIN, getRandomFruitColor(),true);
      makeOtherColorsDarker(newPalette, HomestuckPalette.HAIR_MAIN, <String>[HomestuckPalette.HAIR_ACCENT]);

      newPalette.add(HomestuckPalette.SHIRT_LIGHT, getRandomBarkColor(),true);
      makeOtherColorsDarker(newPalette, HomestuckPalette.SHIRT_LIGHT, <String>[HomestuckPalette.SHIRT_DARK]);

      newPalette.add(HomestuckPalette.PANTS_LIGHT, getRandomBarkColor(),true);
      makeOtherColorsDarker(newPalette, HomestuckPalette.PANTS_LIGHT, <String>[HomestuckPalette.PANTS_DARK]);

      newPalette.add(HomestuckPalette.CLOAK_LIGHT, getRandomLeafColor(),true);
      makeOtherColorsDarker(newPalette, HomestuckPalette.CLOAK_LIGHT, <String>[HomestuckPalette.CLOAK_MID, HomestuckPalette.CLOAK_DARK]);
      return newPalette;
  }


  bool hasHangablesAlready() {
      return hangables.isNotEmpty;
  }

    bool hasClustersAlready() {
        return clusters.isNotEmpty;
    }

  Future<Null> createLeafClusters() async {
      //print("leaf cluster being made, leavesfront is ${leavesFront.imgNumber}");
      if(leavesFront.imgNumber != 0 || hasClustersAlready()) return;
      rand = new Random(seed);

      //print ('first creating clusters');
      if(rand.nextBool()) {
            //less leaves but bigger on average
            minLeaf = (minLeaf/2).round();
            maxLeaf = (maxLeaf/2).round();
            leafWidth = leafWidth * 2;
            leafHeight = leafHeight * 2;

      }
      int amount = rand.nextIntRange(minLeaf,maxLeaf);
      if(leafTemplate == null) {
          rand = new Random(seed);
          leafTemplate = new LeafDoll();
          leafTemplate.rand = rand.spawn();
          leafTemplate.randomizeNotColors(); //now it will fit my seed.
          leafTemplate.copyPalette(palette);
      }
      rand = new Random(seed);

      for(int i = 0; i < amount; i++) {
          LeafDoll clonedDoll = leafTemplate.clone();
          Math.Point point = await randomValidPointOnTree(true);
//          print("second point is $point and doll is $clonedDoll");

          if(point != null) {
              int xpos = point.x;
              int ypos = point.y;
              double scale = 0.5+rand.nextDouble()*1.5;
              int w = (leafWidth * scale).round();
              int h = (leafHeight * scale).round();
              if(rand.nextBool()) {
                  clonedDoll.orientation = Doll.TURNWAYS;
              }

              //don't rotate too much (still hang from the "top") but have some wiggle
              clonedDoll.rotation = rand.nextIntRange(-45, 45);
  //            print("rotation is set to be ${clonedDoll.rotation}");
              if(clonedDoll.rotation <0) clonedDoll.rotation = 365-clonedDoll.rotation;
              PositionedDollLayer newLayer = new PositionedDollLayer(clonedDoll, w, h, (xpos-w/2).round(), ypos-(h/2).round(), "LeafCluster$i");
              addDynamicLayer(newLayer);
          }
      }
    }

  Future<Null> createHangables() async {
      if(hasHangablesAlready()) return;
      rand = new Random(seed);

      //reset after leaf shenanigans
        lastXForHangable = 0;
        lastYForHangable = 0;
        double chosenNum = rand.nextDouble();
        //print("creating hangables and chosen num is $chosenNum is it less than 0.45? ${chosenNum < 0.45}");
      //not both at once, fruit is more important than flowers (both can be true but in that case fruit)
        if(fruitTime) {
            await createFruit();
        }else if(flowerTime) {
            await createFlowers();
        }
        //slows shit down too much unless i mean too
        /*else {
            await createGloriousBullshit();
        }*/
  }

  Future<Null> createFlowers() async {
     //print ('first creating flowers');
      //if i know the fruit is weird, make less of it
      if(fruitTemplate != null && !(fruitTemplate is FruitDoll)) {
        minFruit = 1;
        maxFruit = 3;
      }
     int amount = rand.nextIntRange(minFruit,maxFruit);
     rand = new Random(seed);

     if(flowerTemplate == null) {
         flowerTemplate = new FlowerDoll();
         flowerTemplate.rand = rand.spawn();
         flowerTemplate.randomizeNotColors(); //now it will fit my seed.
         flowerTemplate.copyPalette(palette);
     }

     rand = new Random(seed);
     for(int i = 0; i < amount; i++) {
         Math.Point point = await randomValidPointOnTree(false);
         Doll clone = flowerTemplate.clone();
         if(rand.nextBool()) clone.orientation = Doll.TURNWAYS;
         //print("second point is $point");
         if(point != null) {
             int xpos = point.x;
             int ypos = point.y;


             PositionedDollLayer newLayer = new PositionedDollLayer(
                 clone, fruitWidth, fruitHeight, xpos, ypos, "Hanging$i");
             addDynamicLayer(newLayer);
         }
     }
     //print ("fourth is done");
  }

  FruitDoll spawnFruit() {
      fruitTemplate = new FruitDoll();
      rand = new Random(seed);
      fruitTemplate.rand = rand.spawn();
      fruitTemplate.randomizeNotColors(); //now it will fit my seed.
      fruitTemplate.copyPalette(palette);
  }

  Future<Null> createFruit() async{
      //print ('first creating fruit');
      if(fruitTemplate != null && !(fruitTemplate is FruitDoll)) {
          minFruit = 1;
          maxFruit = 3;
      }
      int amount = rand.nextIntRange(minFruit,maxFruit);
      if(fruitTemplate == null) {
          spawnFruit();
      }
      //make sure it's synced one last time (could have wrong name if it were loaded or whatever)
      if(fruitTemplate is FruitDoll) (fruitTemplate as FruitDoll).setName();
      rand = new Random(seed);
      for(int i = 0; i < amount; i++) {
          FruitDoll clonedDoll = fruitTemplate.clone();
          if(rand.nextBool()) clonedDoll.orientation = Doll.TURNWAYS;
          Math.Point point = await randomValidPointOnTree(false);
          //print("second point is $point");

          if(point != null) {
              int xpos = point.x;
              int ypos = point.y;
              PositionedDollLayer newLayer = new PositionedDollLayer(clonedDoll, fruitWidth, fruitHeight, xpos, ypos, "Hanging$i");
              addDynamicLayer(newLayer);
          }
      }
      //print ("fourth is done");
  }

  Future<Null> createGloriousBullshit() async {
      rand = new Random(seed);
      int type = rand.pickFrom(Doll.allDollTypes);
      //print("creating glorious bullshit, type is $type");

      Doll doll = Doll.randomDollOfType(type);
      doll.rand = rand.spawn();
      doll.randomize(); //now it will fit my seed.
      doll.copyPalette(palette);
      rand = new Random(seed);

      int amount = rand.nextIntRange(minFruit,maxFruit);
      for(int i = 0; i < amount; i++) {
          Math.Point point = await randomValidPointOnTree(false);
          //print("point is $point");

          if(point != null) {
              int xpos = point.x;
              int ypos = point.y;
              PositionedDollLayer newLayer = new PositionedDollLayer(
                  doll.clone(), fruitWidth, fruitHeight, xpos, ypos,
                  "Hanging$i");
              addDynamicLayer(newLayer);
          }
      }
  }

  @override
  Future<Null> beforeRender() async{
      //print ("doing a before render");
      leavesBack.x = form.leafX;
      leavesBack.y = form.leafY;
      leavesFront.x = form.leafX;
      leavesFront.y = form.leafY;
      await createLeafClusters();
      await createHangables();

  }

  @override
  void initLayers() {

      branches = new SpriteLayer("Branches","$folder/branches/", 1, maxBranches);
      leavesBack = new PositionedLayer(0,0,"BackLeaves","$folder/leavesBack/", 1, maxLeaves);
      leavesFront = new PositionedLayer(0,0,"FrontLeaves","$folder/leavesFront/", 1, maxLeaves);
      leavesBack.syncedWith.add(leavesFront);
      leavesFront.syncedWith.add(leavesBack);
      leavesBack.slave = true;
      //have to do it here because not a get, can be modified
      renderingOrderLayers = <SpriteLayer>[leavesBack,branches, leavesFront];
      dataOrderLayers = <SpriteLayer>[leavesBack,branches, leavesFront];
  }

}


//forms decide where valid leaf/flower/etc locations are

class TreeForm {
    List<int> branchesNumbers = <int>[5,6,7,8,9,20,21,22,31,32];
    int leafX = 75;
    int leafY = 0;
    int canopyWidth = 368;
    int canopyHeight = 300;

    bool hasForm(TreeDoll doll) {
        return branchesNumbers.contains(doll.branches.imgNumber);
    }
}


class BushForm extends TreeForm {
    @override
    List<int> branchesNumbers = <int>[0,1,2,3,4,23,24,25,26,27,28,29,30];
    @override
    int leafX = 75;
    @override
    int leafY = 150;
    @override
    int canopyWidth = 475;
    @override
    int canopyHeight = 400;
}

class LeftForm extends TreeForm {
    @override
    List<int> branchesNumbers = <int>[15,16,17,18,19];
    @override
    int leafX = 0;
    @override
    int leafY = 0;
    @override
    int canopyWidth = 475;
    @override
    int canopyHeight = 300;
}

class RightFrom extends TreeForm {
    @override
    List<int> branchesNumbers = <int>[10,11,12,13,14];
    @override
    int leafX = 150;
    @override
    int leafY = 0;
    @override
    int canopyWidth = 475;
    @override
    int canopyHeight = 300;
}