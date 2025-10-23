
// Set-up for all interactions




// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█


// Global Variables
float flashlightRadius = 50;
int collectedPresentsCounter = 0;

// Interaction-Based ArrayLists
ArrayList<Clickable> clickableObj = new ArrayList<>();
ArrayList<Hoverable> hoverableObj = new ArrayList<>();

// An array of coordinates for all of the presents in the game
float[][] presentCoordinates = {
  {110, 620},
  {98, 234},
  {1070, 720},
  {640, 720},
  {720, 720},
  {370, 708},
  {840, 110},
  {1190, 235},
  {490, 620}
};

// Sounds
SoundFile click;
SoundFile yay;
SoundFile cheer;

// Interactable Object Variables
StoreSign storeSign;
StoreSign speelgoedSign;
StoreSign giftsSign;
StoreSign gamesSign;

SecretImage robbers;

LightSource flashlight;




// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█


void loadInteractableObjects() {

  // Load Images In
  PImage train = loadImage("Train.png");
  PImage robbersImg = loadImage("Robbers.png");

  PImage storeSignOff = loadImage("StoreSignOff.png");
  PImage storeSignOn = loadImage("StoreSignOn.png");
  PImage speelgoodOn = loadImage("SpeelgoedOn.png");
  PImage speelgoodOff = loadImage("SpeelgoedOff.png");
  PImage gamesOn = loadImage("GamesOn.png");
  PImage gamesOff = loadImage("GamesOff.png");
  PImage giftsOn = loadImage("GiftsOn.png");
  PImage giftsOff = loadImage("GiftsOff.png");


  // Load Sounds In
  click = new SoundFile(this, "Click.mp3");
  yay = new SoundFile(this, "Yay.mp3");
  cheer = new SoundFile(this, "Cheer.mp3");

  // Create Interactable Objects
  storeSign = new StoreSign(storeSignOff, storeSignOn, true, 790, height-windowOffset-100, 360, 108);
  float signGap = 30;
  speelgoedSign = new StoreSign(speelgoodOff, speelgoodOn, true, 90, height-windowOffset-55);
  giftsSign = new StoreSign(giftsOff, giftsOn, true, speelgoedSign.xPos+speelgoedSign.xSize+signGap, height-windowOffset-55);
  gamesSign = new StoreSign(gamesOff, gamesOn, true, giftsSign.xPos+giftsSign.xSize+signGap, height-windowOffset-55);

  robbers = new SecretImage(robbersImg, true, 843, 420, 75, 160);

  for (float[] coords : presentCoordinates) {
    new ChristmasPresent(coords[0], coords[1]);
    // It is used and saved, but from within the constructor. I don't know how to silence warnings in Processing so it will stay here.
  }

  flashlight = new LightSource(0, 0, flashlightRadius*2);
}


void drawPresentInstructions() {
  
  // Draw the present counter
  pushMatrix();
    translate(20, 20);
    fill(#66000000);
    rect(0, 0, 300, 40);
  
    fill(#FFFFFF);
    textSize(24);
    textAlign(CENTER, CENTER);
    text("Hidden Presents Left: " + Integer.toString(presentCoordinates.length-collectedPresentsCounter), 0, 0, 300, 40);
  popMatrix();
  
    // Draw instructions on what to do
  pushMatrix();
    translate(20, 80);
    fill(#66000000);
    rect(0, 0, 300, 60);
  
    fill(#FFFFFF);
    textSize(16);
    text("Use your flashlight to try and find secrets!\nCan you collect all Christmas Presents?", 0, 0, 300, 60);
  popMatrix();
  
}


void drawInteractableObjects() {

  // Draw all hoverable objects
  println(hoverableObj.size());
  for (Hoverable tempObj : hoverableObj) {
    tempObj.render();
  }
  
  // Draw interactable objects
  storeSign.render();
  speelgoedSign.render();
  giftsSign.render();
  gamesSign.render();

  // Draw the flashlight's light
  flashlight.render();
  
}



// █ █▄░█ ▀█▀ █▀▀ █▀█ █▀▀ ▄▀█ █▀▀ █▀▀ █▀
// █ █░▀█ ░█░ ██▄ █▀▄ █▀░ █▀█ █▄▄ ██▄ ▄█


// We're using interfaces here both to categorize all of the clickable objects of different classes into one single array to check whenever the mouse is pressed,
// but also to be able (possibly) expand this structure to allow for other kinds of common interactions.
interface Clickable {

  void onClick(float xMouse, float yMouse);

  // boolean isInBounds(float xCheck, float yCheck);
  // (Not used at the moment, but if it was needed to have a way to check whether the mouse
  // was within the bounds of multiple complicated shapes at once, then this would be good approach
}

interface Hoverable {
  void isLit(float xCheck, float yCheck, float radius);
  void render();
}
