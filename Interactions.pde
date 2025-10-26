
// Set-up for all interactions




// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█


// Global Variables
float flashlightRadius = 25;
int collectedPresentsCounter = 0;
boolean displayEasterEgg = false;
int konamiProgress = 0;

// Interaction-Based ArrayLists
ArrayList<Clickable> clickableObj = new ArrayList<>();
ArrayList<Hoverable> hoverableObj = new ArrayList<>();
ArrayList<Food> candyCanes = new ArrayList<>();
ArrayList<Integer> konamiInput = new ArrayList<Integer>();

// An array of coordinates for all of the presents in the game
float[][] presentCoordinates = {
  {110, 620},
  {98, 234},
  {1020, 720},
  {640, 720},
  {700, 720},
  {370, 708},
  {840, 110},
  {1150, 235},
  {490, 620}
};

// Konami code inputs
int[] konamiSequence = {
  UP, UP, DOWN, DOWN, LEFT, RIGHT, LEFT, RIGHT
};
char[] konamiChars = {'b', 'a'};



// ▄▀█ █▀ █▀ █▀▀ ▀█▀ █▀
// █▀█ ▄█ ▄█ ██▄ ░█░ ▄█


// Sounds
SoundFile click, yay, cheer, eatSound, trainWhistle;

// Images
PImage easterEggImage;

// Interactable Objects
StoreSign storeSign, speelgoedSign, giftsSign, gamesSign;

// Hidden Objects
SecretImage robbers;

// Light Sources
LightSource flashlight;

// Green Army People Textures Array
PImage[] gapTextures = new PImage[4];
// Food
Food cookie;
// Train
Train train;



// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█


void loadInteractableObjects() {

  // Load Images In
  PImage trainImage = loadImage("Train.png");
  PImage robbersImg = loadImage("Robbers.png");

  PImage storeSignOff = loadImage("StoreSignOff.png");
  PImage storeSignOn = loadImage("StoreSignOn.png");
  PImage speelgoodOn = loadImage("SpeelgoedOn.png");
  PImage speelgoodOff = loadImage("SpeelgoedOff.png");
  PImage gamesOn = loadImage("GamesOn.png");
  PImage gamesOff = loadImage("GamesOff.png");
  PImage giftsOn = loadImage("GiftsOn.png");
  PImage giftsOff = loadImage("GiftsOff.png");
  PImage candyCaneImage = loadImage("candyCane.png");
  PImage cookieImage = loadImage("cookie.png");

  // Loop through all objects of the gapTextures array and load in the respective image dynamically.
  for (int i = 0; i<gapTextures.length; i++) {
    gapTextures[i] = loadImage(("GAP"+(i+1)+".png"));
  }

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
  train = new Train(trainImage, 121, 590, 150, 30);
  
  
  // I'm not sure why this warning keeps popping up, but the object is going to be used later on;
  // Just not from these for-loops, these are only used to create them.

  // Set up the Green Army People
  for (int i = 1; i <= 15; i++) {
    new GreenArmyPerson(gapTextures[floor(random(0, 3.99))]);
  }
  
  // Set up the hidden presents around the map
  for (float[] coords : presentCoordinates) {
    new ChristmasPresent(coords[0], coords[1]);
  }
  
  
  // Set up Food Objects
  cookie = new Food(cookieImage, 641, 425, 90, 90);
  for (int i = 0; i <= 6; i++) {
    Food candyCane = new Food(candyCaneImage, 121+170*i, 340, 80, 80);
    candyCanes.add(candyCane);
  }


  flashlight = new LightSource(0, 0, flashlightRadius*2.2);
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
  for (Hoverable tempObj : hoverableObj) {
    tempObj.render();
  }

  // Draw interactable objects
  storeSign.render();
  speelgoedSign.render();
  giftsSign.render();
  gamesSign.render();
  train.render();
  
  // Render Food Objects
  cookie.render();
  for (Food candyCane : candyCanes) {
    candyCane.render();
  }
  
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
  void render(); // Is used to render all of the hoverable objects in one go, instead of having to do separate code for each class.
}
