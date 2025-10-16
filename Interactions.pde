
// Interactionable Objects for the Storefront




// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█


// Interaction-Based ArrayLists
ArrayList<Clickable> clickableObj = new ArrayList<>();

// Images
PImage train;

PImage storeSignOff;
PImage storeSignOn;

// Interactable Object Variables
ClickableImage storeSign;




// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█


void loadInteractableObjects() {
  
  // Load Images In
  train = loadImage("Train.png");
  storeSignOff = loadImage("StoreSignOff.png");
  storeSignOn = loadImage("StoreSignOn.png");
  
  // Create Interactable Objects
  storeSign = new ClickableImage(storeSignOff, storeSignOn, true, 820, height-windowOffset-85);
  
}


void drawInteractableObjects() {
  
  storeSign.render();
  
}




// █▀▀ █░░ ▄▀█ █▀ █▀ █▀▀ █▀
// █▄▄ █▄▄ █▀█ ▄█ ▄█ ██▄ ▄█


// We're using interfaces here both to categorize all of the clickable objects of different classes into one single array to check whenever the mouse is pressed, 
// but also to be able (possibly) expand this structure to allow for other kinds of common interactions.
interface Clickable {

  void onClick(float xMouse, float yMouse);
  
  // boolean isInBounds(float xCheck, float yCheck);
  // (Not used at the moment, but if it was needed to have a way to check whether the mouse
  // was within the bounds of multiple complicated shapes at once, then this would be good approach
  
}

class ClickableImage implements Clickable {
  PImage defaultImg, clickImg; // The default and clicked images
  float xPos, yPos, xSize, ySize;
  
  boolean clicked = false; // Whether or not the button is in it's clicked state or not.
  boolean keepState;       // If true, it will keep the button in it's clicked state until explicitly clicked on again.
  
  // Constructors
  
  // Constructor that accounts for a custom size.
  ClickableImage(PImage defaultImg, PImage clickImg, boolean keepState, float xPos, float yPos, float xSize, float ySize) {
    this.defaultImg = defaultImg;
    this.clickImg   = clickImg;
    this.keepState  = keepState;
    
    this.xPos  = xPos;
    this.xPos  = xPos;
    this.yPos  = yPos;
    this.xSize = xSize;
    this.ySize = ySize;
    
    // Adds this specific object to the ArrayList of clickable objects.
    clickableObj.add(this);
  }
  
  // Constructor that defaults to the default resolution of the image
  // Keep in mind this is computed only in relation to the defaultImg. It's expected that both are of the same resolution.
  ClickableImage(PImage defaultImg, PImage clickImg, boolean keepState, float xPos, float yPos) {
    this.defaultImg = defaultImg;
    this.clickImg   = clickImg;
    this.keepState  = keepState;
    
    this.xPos  = xPos;
    this.xPos  = xPos;
    this.yPos  = yPos;
    this.xSize = defaultImg.width;
    this.ySize = defaultImg.height;
    
    clickableObj.add(this);
  }
  
  
  // Methods
  
  
  // Checks whether or not a specific coordinate is within the bounds of the image.
  boolean isInBounds(float xCheck, float yCheck) {
    if ( (xCheck>xPos && xCheck<xPos+xSize) && (yCheck>yPos && yCheck<yPos+ySize) ) { return true; }
    else { return false; }
  }
  
  
  // Is activated whenever the mouse is clicked.
  // The method needs to be public for it to be able to override the 'default' one from the Clickable interface;
  @Override public void onClick(float xMouse, float yMouse) {
    
    println(clicked);
    if (keepState) {
      // If keepState is on, then only toggle the state as long as the mouse clicks on the object.
      if (isInBounds(xMouse,yMouse)) { clicked = !clicked; }
    }
    else {
      // If keepState isn't on, then set the state of the button according to whether the mouse is actually within it's bounds or not.
      clicked = isInBounds(xMouse, yMouse);
    }
    
  }
  
  
  // Checks it's own state and places the respective image depending on it.
  void render() {
    if (clicked) { image(clickImg, xPos, yPos, xSize, ySize); }
    else { image(defaultImg, xPos, yPos, xSize, ySize); }
  }
  
}
