
// Visual Aspect + Decorations for the Storefront




// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█


// Shadows & Gradients
PImage leftGradient;
PImage rightGradient;
PImage topGradient;
PImage bottomGradient;


// Tiled Images
TiledImage brickWall;
TiledImage planksWall;

TiledImage leftPillar;
TiledImage middlePillar;
TiledImage rightPillar;

TiledImage panelJoint;

TiledImage secondFloorWindow;

TiledImage christmasGarland;
TiledImage shelfGarland;


// Image Assets
PImage christmasTree;




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
  PImage brickWallTexture = loadImage("BrickWallTexture.png");
  PImage planksWallTexture = loadImage("PlanksWallTexture.png");
  PImage pillarTexture = loadImage("PillarTexture.png");
  PImage panelJointTexture = loadImage("PanelJoint.png");
  PImage secondFloorWindowTexture = loadImage("SecondFloorWindow.png");
  
  PImage christmasGarlandTexture = loadImage("Garland.png");
  christmasTree = loadImage("Christmas Tree.png");

  // Compute and save the textures
  brickWall = new TiledImage(brickWallTexture, 0, 0, width, height, 100, 100);
  planksWall = new TiledImage(planksWallTexture, 0, height-400, width, 400, 250, 250);
  panelJoint = new TiledImage(panelJointTexture, 70, 80, 1140, 85, "", 9, 1);
  christmasGarland = new TiledImage(christmasGarlandTexture, panelJoint.xPos, 0, panelJoint.xSize, 85, "y", 6, 1);
  shelfGarland = new TiledImage(christmasGarlandTexture, 0, height-100, width/2, 85, "y", 5, 1);
  secondFloorWindow = new TiledImage(secondFloorWindowTexture, 96, -100, width-98*2, 237, "", 2, 1);

  leftPillar = new TiledImage(pillarTexture, 0, 0, 95, windowOffset, 35, 35);
  middlePillar = new TiledImage(pillarTexture, leftPillar.xSize+520, 0, 120, windowOffset, 35, 35);
  rightPillar = new TiledImage(pillarTexture, width-95, 0, 95, windowOffset, 35, 35);

}


void drawTilePillar(float xPos, float yPos, float xSize, float ySize) {
  fill(#9A9C97);
  rect(xPos, yPos, xSize, ySize);
}


// Render the second floor
void drawBuilding() {

  brickWall.render();
  secondFloorWindow.render();

  // Add the 2 'dimples' in the brick on either side of the wall
  addVariableGradient(leftGradient, 3, 24, 0, 12, height-buildingOffset);
  addVariableGradient(rightGradient, 3, 48, 0, 12, height-buildingOffset);

  addVariableGradient(leftGradient, 3, width-48-12, 0, 12, height-buildingOffset);
  addVariableGradient(rightGradient, 3, width-24-12, 0, 12, height-buildingOffset);

  // Render the background for the toys
  planksWall.render();
  // Darken Background
  fill(#66000000);
  rect(planksWall.xPos, planksWall.yPos, planksWall.xSize/2, planksWall.ySize-100);
  // Add shelf edge
  fill(#66AA5206);
  rect(planksWall.xPos, height-100, planksWall.xSize/2, 8);
  addVariableGradient(topGradient, 3, 0, height-92, planksWall.xSize/2, 36);
  shelfGarland.render();
  
}


// Render the top part of the storefront
void drawStoreSignHolder() {
  pushMatrix();
  translate(0, height-buildingOffset);
  
    // Connection Between Store and Building
    fill(#D9D9D9);
    rect(0, 0, width, 165);
    image(topGradient, 0, 32, width, 8);
  
    fill(#4C4C4C);
    rect(0, 16, width, 16);
    image(topGradient, 0, 16, width, 8);
  
    // Sign Holder
    fill(#9A9C97);
    rect(panelJoint.xPos, panelJoint.yPos, panelJoint.xSize, panelJoint.ySize);
    panelJoint.render();
  
    fill(#F6F6F6);
    rect(0, 0, width, 16);
    image(topGradient, 0, 0, width, 8);
    rect(panelJoint.xPos, panelJoint.yPos, panelJoint.xSize, 8);
    image(topGradient, panelJoint.xPos, panelJoint.yPos+8, panelJoint.xSize, 8);
  
    image(rightGradient, panelJoint.xPos-12, panelJoint.yPos, 12, panelJoint.ySize);
    image(leftGradient, panelJoint.xPos+panelJoint.xSize, panelJoint.yPos, 12, panelJoint.ySize);

  popMatrix();
}


// Render the actual windows of the storefront (where the magic happens!)
void drawStorefrontFrame() {
  pushMatrix();
  translate(0, height-windowOffset);
  
    // Render the fake windows for the door frame.
    fill(#576B90);
    rect(planksWall.xPos+planksWall.xSize/2, 0, planksWall.xSize/2, planksWall.ySize);
  
    // Window Frame
    fill(#E0DB5A);
  
    rect(leftPillar.xSize, 0, 520, 12);
    rect(leftPillar.xSize, windowOffset-12, 520, 12);
  
    rect(leftPillar.xSize, 0, 12, windowOffset);
    rect(leftPillar.xSize+254, 0, 12, windowOffset);
    rect(leftPillar.xSize+508, 0, 12, windowOffset);
  
  
    // Door Frame
    rect(width/2, 0, width/2, 12);
  
    float leftFrameXOffset = middlePillar.xPos+middlePillar.xSize;
    rect(leftFrameXOffset, 0, 12, windowOffset);
    rect(leftFrameXOffset, windowOffset-12, 12+64, 12);
    rect(leftFrameXOffset+64, 0, 36, windowOffset);
    image(rightGradient, leftFrameXOffset+64+4, 0, 8, windowOffset);
  
    float rightFrameXOffset = width-rightPillar.xSize;
    rect(rightFrameXOffset-12, 0, 12, windowOffset);
    rect(rightFrameXOffset-64, windowOffset-12, 12+64, 12);
    rect(rightFrameXOffset-64-36, 0, 36, windowOffset);
    image(leftGradient, rightFrameXOffset-64-4-8, 0, 8, windowOffset);
  
    // Sliding Doors
    noFill();
    stroke(#4C4C4C);
    strokeWeight(8);
    rect(leftFrameXOffset+104, 16, 121-4, 380);
    rect(leftFrameXOffset+104+121+4, 16, 121-4, 380);
  
    noStroke();
  
    // Pillars
    leftPillar.render();
    image(leftGradient, 70, 0, 12, windowOffset);
  
    middlePillar.render();
    rightPillar.render();
  
    image(rightGradient, width-70-12, 0, 12, windowOffset);
  
    // Shadow between sign holder and window frames
    addVariableGradient(topGradient, 3, panelJoint.xPos, 0, panelJoint.xSize, 24);
    
    // Window Decorations
    christmasGarland.render();
    image(christmasTree, middlePillar.xPos-30,windowOffset-231);

  popMatrix();
}


void drawStorefront() {

  noStroke();

  // Call upon each part of the storefront to be rendered
  drawBuilding();
  drawStoreSignHolder();
  drawStorefrontFrame();

  // Make the entire scene darker (Christmas night <3 )
  fill(#44000000);
  rect(0, 0, width, height);
}
