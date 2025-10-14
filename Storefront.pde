
// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█

// Shadows & Gradients
PImage leftGradient;
PImage rightGradient;
PImage topGradient;
PImage bottomGradient;

// Images & Textures
PImage brickWallTexture;
TiledImage brickWall;

PImage tileGroutTexture;
TiledImage tileGrout;

PImage panelJointTexture;
TiledImage panelJoint;

PImage secondFloorWindowTexture;
TiledImage secondFloorWindow;

// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█

// Procedurally draws multiple gradients on top of each other to mess with their opacity.
void addVariableGradient(PImage type, int opacityMultiplier, float xPos, float yPos, float xSize, float ySize) {
  for (int i = 1; i<opacityMultiplier; i++) {
    image(type, xPos, yPos, xSize, ySize);
  }
}

void loadStorefrontAssets() {
  
  // Load in the gradients
  leftGradient = loadImage("LeftGradient.png");
  rightGradient = loadImage("RightGradient.png");
  topGradient = loadImage("TopGradient.png");
  bottomGradient = loadImage("BottomGradient.png");
  
  // Load in images
  brickWallTexture = loadImage("BrickWallTexture.png");
  tileGroutTexture = loadImage("TileGrout.png");
  panelJointTexture = loadImage("PanelJoint.png");
  secondFloorWindowTexture = loadImage("SecondFloorWindow.png");
  
  // Compute and save the textures
  brickWall = new TiledImage(brickWallTexture, 0, 0, width, height, 100, 100);
  panelJoint = new TiledImage(panelJointTexture, 70, 80, 1140, 85, "", 9, 1);
  
  secondFloorWindow = new TiledImage(secondFloorWindowTexture, 96, -100, width-98*2, 237, "", 2, 1);
  
}

void drawStoreName() {

}

void drawStorefront() {
  
  // What offset from the ground each part of the scene is drawn at.
  float buildingOffset = 565;
  float windowOffset = 400;
  
  noStroke();
  
  // Render the brick wall background
  brickWall.render();
  secondFloorWindow.render();
  addVariableGradient(leftGradient, 3, 24, 0, 12, height-buildingOffset);
  addVariableGradient(rightGradient, 3, 48, 0, 12, height-buildingOffset);
  
  addVariableGradient(leftGradient, 3, width-48, 0, 12, height-buildingOffset);
  addVariableGradient(rightGradient, 3, width-24, 0, 12, height-buildingOffset);
  
  
  // Render the top part of the storefront
  pushMatrix();
    translate(0,height-buildingOffset);
    
    // Connection Between Store and Building
    fill(#D9D9D9);
    rect(0,0,width,165);
    image(topGradient,0,32,width,8);
    
    fill(#4C4C4C);
    rect(0,16,width,16);
    image(topGradient,0,16,width,8);
    
    // Sign Holder
    fill(#9A9C97);
    rect(panelJoint.xPos, panelJoint.yPos, panelJoint.xSize, panelJoint.ySize);
    panelJoint.render();
    
    fill(#F6F6F6);
    rect(0, 0, width, 16);
    image(topGradient, 0, 0, width, 8);
    rect(panelJoint.xPos, panelJoint.yPos, panelJoint.xSize, 8);
    image(topGradient,panelJoint.xPos, panelJoint.yPos+8, panelJoint.xSize, 8);
    
  popMatrix();
  
  // Render the actual windows of the storefront (where the magic happens!)
  pushMatrix();
    translate(0,height-windowOffset);
    
  popMatrix();
  
}




// █▀▀ █░░ ▄▀█ █▀ █▀ █▀▀ █▀
// █▄▄ █▄▄ █▀█ ▄█ ▄█ ██▄ ▄█
