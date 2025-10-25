
// Main Tab (Initializing & Connections)

// Credits: Click Sound Effect by u_u4pf5h7zip from Pixabay
//          Yay Sound Effect by freesound_community from Pixabay
//          Wet Bandits Image from Alamy / Courtesy of Hughes Entertainment and 20th Century Fox
//          Cheer Sound Effect by DRAGON-STUDIO from Pixabay
//          Bricks & Planks Textures from cc0-textures.com
//          Inter-Toys for their logo and branding.
//          Jingle Bells Music by Otto from Pixabay
//          Green Army People photos from Victor Buy





// █░░ █ █▄▄ █▀█ ▄▀█ █▀█ █ █▀▀ █▀
// █▄▄ █ █▄█ █▀▄ █▀█ █▀▄ █ ██▄ ▄█


import processing.sound.*;




// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█


// Global Positions
// What offset from the ground each part of the scene is drawn at.
float buildingOffset = 565;
float windowOffset = 400;




// ▄▀█ █▀ █▀ █▀▀ ▀█▀ █▀
// █▀█ ▄█ ▄█ ██▄ ░█░ ▄█


// Background Music
SoundFile music;




// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█


void setup() {
 
 size(1280,720,P2D); // P2D is more efficient than the default rendering engine. 
 surface.setLocation(100,100); // Force the window to appear on the screen (and not off-screen, can happen sometimes)
 pixelDensity(1); // Disable pixel scaling on high-resolution devices (causes issues when a device is connected to external monitors)
 surface.setResizable(false); // Disable window resizing (a lot of positioning is absolute and not relative, would break stuff)
 
 // Methods that load in different variables
 loadStorefrontAssets();
 loadInteractableObjects();
 
 // Handle the background music
 music = new SoundFile(this, "JingleBells.mp3");
 music.amp(0.2);
 music.loop();
 
}


void draw() {
  
  background(#FFFFFF);
  noStroke();
  
  // Draw the background scene itself
  drawBuilding();
  drawStoreSignHolder();
  drawStorefrontFrame();

  // Make the entire scene darker (Christmas night <3 )
  fill(#44000000);
  rect(0, 0, width, height);
  
  // Draw the interactable objects
  drawInteractableObjects();
  
  // Draw the overlapping part of the storefront
  drawStoreWindowFrame();
  
  drawPresentInstructions(); // Gameplay instructions
  
  // println("MouseX: " + mouseX + " // MouseY: " + mouseY); // Hopefully we won't forget to comment this one out, it's a dev/debug tool
  
}




// █▀▀ █░█ █▀▀ █▄░█ ▀█▀   █░█ ▄▀█ █▄░█ █▀▄ █░░ █▀▀ █▀█ █▀
// ██▄ ▀▄▀ ██▄ █░▀█ ░█░   █▀█ █▀█ █░▀█ █▄▀ █▄▄ ██▄ █▀▄ ▄█

// I tried defining a global variable for the resolution, but any approach ended up inducing bugs due to restrictions with the size() method. So, please excuse this repetition
// Forces the window to not be resizable, admittedly in a bit of an improper way. I tried some of the methods online that attempted to mess with the 'hidden' settings for Processing, but none seemed to work.

void windowResized() {
  surface.setSize(1280, 720);
}

void mousePressed() {
  
  // Loop through all of clickableObj and define a temporary Clickable object to work with
  for (Clickable tempObj : clickableObj) {
    tempObj.onClick(mouseX, mouseY);
  }
  
}

void mouseMoved() {
  flashlight.move(mouseX, mouseY);
  for (Hoverable tempObj : hoverableObj) {
    tempObj.isLit(mouseX, mouseY, flashlightRadius);
  }
}
