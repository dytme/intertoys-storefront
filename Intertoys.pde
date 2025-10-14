
// █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀
// ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█


float sineClock = 0.0;




// █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
// █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█


void setup() {
 size(1280,720,P2D); // P2D is more efficient than the default rendering engine. 
 pixelDensity(1); // Disable pixel scaling on high-resolution devices (causes issues when a device is connected to external monitors)
}


void draw() {
  
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
