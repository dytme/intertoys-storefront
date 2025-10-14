
// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█


float sineClock = 0.0;




// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█


void setup() {
 
 size(1280,720,P2D); // P2D is more efficient than the default rendering engine. 
 surface.setLocation(100,100); // Force the window to appear on the screen (and not off-screen, can happen sometimes)
 pixelDensity(1); // Disable pixel scaling on high-resolution devices (causes issues when a device is connected to external monitors)
 surface.setResizable(false); // Disable window resizing (a lot of positioning is absolute and not relative, would break stuff)
 
 // Methods that load in different variables
 loadStorefrontAssets();
 
}


void draw() {
  
  background(#FFFFFF);
  
  // Draw the animated interactions
  
  
  // Draw the interactable elements
  
  
  // Draw the scene itself
  drawStorefront();
  
  
  // Handle the animation clock(s)
  sineClock += 0.1;
  if (sineClock >= TWO_PI) { sineClock = -TWO_PI; } // Prevent rounding errors with big floats by resetting sineClock
  
}




// █▀▀ █░█ █▀▀ █▄░█ ▀█▀   █░█ ▄▀█ █▄░█ █▀▄ █░░ █▀▀ █▀█ █▀
// ██▄ ▀▄▀ ██▄ █░▀█ ░█░   █▀█ █▀█ █░▀█ █▄▀ █▄▄ ██▄ █▀▄ ▄█

// I tried defining a global variable for the resolution, but any approach ended up inducing bugs due to restrictions with the size() method. So, please excuse this repetition
// Forces the window to not be resizable, admittedly in a bit of an improper way. I tried some of the methods online that attempted to mess with the 'hidden' settings for Processing, but none seemed to work.

void windowResized() {
  surface.setSize(1280, 720);
}
