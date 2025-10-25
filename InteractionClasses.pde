
// Contains the actual classes of interactable objects




// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█


// Checks whether or not a specific coordinate is within the bounds of the image.
boolean isInRectBounds(float xCheck, float yCheck, float xPos, float yPos, float xSize, float ySize) {
  if ( (xCheck>xPos && xCheck<xPos+xSize) && (yCheck>yPos && yCheck<yPos+ySize) ) {
    return true;
  } else {
    return false;
  }
}




// █▀▀ █░░ ▄▀█ █▀ █▀ █▀▀ █▀
// █▄▄ █▄▄ █▀█ ▄█ ▄█ ██▄ ▄█



// Image signs on the storefront
class StoreSign implements Clickable {
  PImage defaultImg, clickImg; // The default and clicked images
  float xPos, yPos, xSize, ySize;

  boolean clicked = false; // Whether or not the button is in it's clicked state or not.
  boolean keepState;       // If true, it will keep the button in it's clicked state until explicitly clicked on again.

  // Constructor that defaults to the default resolution of the image
  // Keep in mind this is computed only in relation to the defaultImg. It's expected that both are of the same resolution.
  StoreSign(PImage defaultImg, PImage clickImg, boolean keepState, float xPos, float yPos) {

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

  // Constructor that takes in custom sizes;
  StoreSign(PImage defaultImg, PImage clickImg, boolean keepState, float xPos, float yPos, float xSize, float ySize) {
    this.defaultImg = defaultImg;
    this.clickImg   = clickImg;
    this.keepState  = keepState;

    this.xPos  = xPos;
    this.xPos  = xPos;
    this.yPos  = yPos;
    this.xSize = xSize;
    this.ySize = ySize;

    clickableObj.add(this);
  }


  // Is activated whenever the mouse is clicked.
  // The method needs to be public for it to be able to override the 'default' one from the Clickable interface;
  @Override public void onClick(float xMouse, float yMouse) {

    if (keepState) {
      // If keepState is on, then only toggle the state as long as the mouse clicks on the object.
      if (isInRectBounds(xMouse, yMouse, xPos, yPos, xSize, ySize)) {
        clicked = !clicked;
        click.play();
      }
    } else {
      // If keepState isn't on, then set the state of the button according to whether the mouse is actually within it's bounds or not.
      clicked = isInRectBounds(xMouse, yMouse, xPos, yPos, xSize, ySize);
      if (clicked) click.play();
    }
  }


  // Checks it's own state and places the respective image depending on it.
  void render() {
    if (clicked) {
      image(clickImg, xPos, yPos, xSize, ySize);
    } else {
      image(defaultImg, xPos, yPos, xSize, ySize);
    }
  }
}



// Mostly used for the flashlight
class LightSource {

  float xPos, yPos, radius;

  LightSource(float xPos, float yPos, float radius) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.radius = radius;
  }

  void render() {
    fill(#66FAF2D4);
    circle(xPos, yPos, radius);
  }

  void move(float newX, float newY) {
    xPos = newX;
    yPos = newY;
  }
}



// Images the visibility of which is dependant upon where the flashlight is flashing.
class SecretImage implements Hoverable {
  float xPos, yPos, xSize, ySize;
  PImage img;
  // boolean state handles the initial (default) state of the secret (if it's visible or not) while boolean visible handles whether it's visible at a specific moment in time or not
  boolean state, visible;

  SecretImage(PImage img, boolean state, float xPos, float yPos, float xSize, float ySize) {
    this.img = img;
    this.state = state;
    this.xPos = xPos;
    this.yPos = yPos;
    this.xSize = xSize;
    this.ySize = ySize;

    // Sets the initial visibility based on the default state
    this.visible = state;

    // Add the secret image into the connector array for all hoverable objects.
    hoverableObj.add(this);
  }

  // Algorithm that determines whether the mouse is within distance "radius" of the image (normally radius = flashlightRadius)
  // This method will reappear a couple of times, however the alternative of having a public method that can be shared by all of the hoverable objects
  // seemed inefficient in it of itself, as we would have had to parse a lot of object-specific arguments.
  @Override public void isLit(float xCheck, float yCheck, float radius) {
    if ((xCheck+radius > xPos && xCheck-radius < xPos+xSize) && (yCheck+radius > yPos && yCheck-radius < yPos+ySize)) {
      visible = !state;
    } else visible = state;
  }

  // If the image is set to be visible, then draw it!
  void render() {
    if (visible) image(img, xPos, yPos, xSize, ySize);
    ;
  }
}




class ChristmasPresent implements Clickable, Hoverable {

  float xPos, yPos, xSize = 30, ySize = 30;
  color boxColor, ribbonColor;
  boolean visible, state = false; // Here: state refers to whether or not a present was collected as well.

  ChristmasPresent(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos-ySize; // Anchor point

    // Generate a random color-way for each present
    boxColor = color(random(1, 255), random(1, 255), random(1, 255));
    ribbonColor = color(random(1, 255), random(1, 255), random(1, 255));

    // Add the present itself to both connector ArrayLists.
    hoverableObj.add(this);
    clickableObj.add(this);
  }


  void render() {
    // Checks if the present was either already collected or is supposed to be visible
    if (state || visible) {
      pushMatrix();
      translate(xPos, yPos);
      fill(boxColor);
      rect(0, 0, xSize, ySize*0.2);
      rect(xSize*0.1, 0, xSize*0.8, ySize);

      fill(ribbonColor);
      rect(xSize/2-xSize*0.1, 0, xSize*0.2, ySize);
      popMatrix();
    }
  }

  @Override public void isLit(float xCheck, float yCheck, float radius) {
    if ((xCheck+radius > xPos && xCheck-radius < xPos+xSize) && (yCheck+radius > yPos && yCheck-radius < yPos+ySize)) {
      visible = !state;
    } else visible = state;
  }

  @Override public void onClick(float xCheck, float yCheck) {
    if (state) return; // If it was already collected, then do nothing

    if (isInRectBounds(xCheck, yCheck, xPos, yPos, xSize, ySize)) {
      yay.play();
      collectedPresentsCounter++;
      state = true;
      if (collectedPresentsCounter == presentCoordinates.length) cheer.play();
    }
  }
}



class GreenArmyPerson implements Hoverable {
  float xPos, yPos, xSize = 30, ySize = 30, minX = 107+xSize, maxX = 600-xSize;
  PImage img;
  boolean exposed = false; // Determines whether the light shines on it or not, and if it does, will stop moving.

  // Variables that handle the movement
  int direction = 1;
  float movementSpeed = 0.5;

  GreenArmyPerson(PImage img) {
    this.img = img;

    // Compute positioning for each person
    yPos = 620-ySize;
    xPos = random(minX, maxX);

    // Compute random movement speed multiplier
    movementSpeed = movementSpeed*random(0.8, 1.2);

    // Add to hoverable array
    hoverableObj.add(this);
  }

  void freeMove() {

    // Bounce the GAP off the walls of the windows once it reaches the borders
    if (xPos>maxX) direction = -1;
    if (xPos<minX) direction = 1;

    // Move the GAP in the determined direction
    xPos = xPos+ direction*movementSpeed;
  }

  void render() {
    if (!exposed) freeMove(); // As long as it's not exposed, it will freely move.

    // println(round(xPos));

    // Flip the entire "canvas" of each GAP when they're supposed to move the other way around.
    pushMatrix();
    translate(xPos, yPos);
    scale(direction, 1);
    image(img, 0, 0, xSize, ySize);
    popMatrix();
  }

  @Override public void isLit(float xCheck, float yCheck, float radius) {
    if ((xCheck+radius > xPos && xCheck-radius < xPos+xSize) && (yCheck+radius > yPos && yCheck-radius < yPos+ySize)) {
      exposed = true;
    } else exposed = false;
  }
}

class Food implements Clickable {
  PImage image;
  float xPos, yPos, xSize, ySize;
  boolean visible = true;
  Food(PImage image, float x, float y, float w, float h) {
    this.image = image;
    this.xPos = x;
    this.yPos = y;
    this.xSize = w;
    this.ySize = h;
    clickableObj.add(this);
  }
  void render() {
    if (visible) {
      image(image, xPos, yPos, xSize, ySize);
    }
  }
  @Override public void onClick(float xMouse, float yMouse) {
    if (isInRectBounds(xMouse, yMouse, xPos, yPos, xSize, ySize) && visible) {
      eatSound.play();
      visible = false;
    }
  }
}

class Train implements Clickable {
  PImage trainImage;
  float xPos, yPos, xSize, ySize;

  // Add in any other fields here
  boolean moved = false;

  // Add in the constructor here
  Train(PImage trainImage, float x, float y, float w, float h) {
    this.trainImage = trainImage;
    this.xPos = x;
    this.yPos = y;
    this.xSize = w;
    this.ySize = h;
    clickableObj.add(this);
  }

  void render() {
  image(trainImage, xPos, yPos, xSize, ySize);
  if (xPos < 450 && moved) {
    xPos = xPos + 2;
  }
}

  @Override public void onClick(float xMouse, float yMouse) {
    if (!moved && isInRectBounds(xMouse, yMouse, xPos, yPos, xSize, ySize)) {
      moved = true;
      // Play the whistle sound
      trainWhistle.play();
    }
  }
}
