/*

 ██╗███╗░░░███╗░█████╗░░██████╗░███████╗    ████████╗██╗██╗░░░░░███████╗██████╗░
 ██║████╗░████║██╔══██╗██╔════╝░██╔════╝    ╚══██╔══╝██║██║░░░░░██╔════╝██╔══██╗
 ██║██╔████╔██║███████║██║░░██╗░█████╗░░    ░░░██║░░░██║██║░░░░░█████╗░░██████╔╝
 ██║██║╚██╔╝██║██╔══██║██║░░╚██╗██╔══╝░░    ░░░██║░░░██║██║░░░░░██╔══╝░░██╔══██╗
 ██║██║░╚═╝░██║██║░░██║╚██████╔╝███████╗    ░░░██║░░░██║███████╗███████╗██║░░██║
 ╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝    ░░░╚═╝░░░╚═╝╚══════╝╚══════╝╚═╝░░╚═╝
 
 Version: 1.0
 
 Author: Sammy (d_ytme)
 Last Edit Date: 14/10/2025
 
 A custom image processing library (to be) which allows you to seamlessly tile textures accross right-angled shapes.
 
 */


class TiledImage {

  PGraphics tiledImage; // Credit to ChatGPT for helping me understand the syntax of and how to actually use PGraphics!
                        // The public documentation is very sparse and the dev one is... 'above my paygrade'.

  // Not only is using a PGraphics element here really good for performance, it also acts as a clipping mask!
  //     Which means both that we don't have to do as many computations for some tiling modes,
  //     but also that it's a fallback in case the user passes some really funky numbers.

  PImage img; // Passes through the actual image that we're tiling

  // Fields that determine the boundaries of the tiled image
  float xPos, xSize, yPos, ySize;

  // Fields that determine the size of a single image (Depends on mode)
  float xImgSize, yImgSize; // (0 = Default)

  String constraintAxis = "x"; // Determines the constrained axis (Depends on mode)

  // Fields that determine how many instances of the image should be repeated on each axis (Depends on mode)
  int xImgCount, yImgCount; // (0 = Auto-Compute)



  // ▀█▀ █ █░░ █ █▄░█ █▀▀   █▀▄▀█ █▀█ █▀▄ █▀▀ █▀
  // ░█░ █ █▄▄ █ █░▀█ █▄█   █░▀░█ █▄█ █▄▀ ██▄ ▄█
  // (Constructors)


  // Forced Size
  
  TiledImage(PImage img, float xPos, float yPos, float xSize, float ySize, float xImgSize, float yImgSize) {
    this.img   = img;
    this.xPos  = xPos;
    this.xSize = xSize;
    this.yPos  = yPos;
    this.ySize = ySize;

    this.xImgSize = xImgSize;
    this.yImgSize = yImgSize;


    // If no size was provided for an axis, fall back to the default size of the image;
    if (Float.isNaN(xImgSize) || xImgSize == 0.0) {
      xImgSize = img.width;
    }
    if (Float.isNaN(yImgSize) || yImgSize == 0.0) {
      yImgSize = img.height;
    }
    
    // After the specific computations were done, call on the method that actually tiles the image
    computePGraphic();

  }


  // Image Count
  
  TiledImage(PImage img, float xPos, float yPos, float xSize, float ySize, String constraintAxis, int xImgCount, int yImgCount) {
    this.img   = img;
    this.xPos  = xPos;
    this.xSize = xSize;
    this.yPos  = yPos;
    this.ySize = ySize;

    this.constraintAxis = constraintAxis;
    this.xImgCount      = xImgCount;
    this.yImgCount      = yImgCount;
    
    
    // Store the aspect ratio of the original image
    float aspectRatio = img.width/img.height;    
    
    if (constraintAxis == "x") { // Constrain the scaling to the x-axis and clip the y-axis.
    
      xImgSize = xSize/xImgCount;
      yImgSize = xImgSize*aspectRatio;
      
    } else if (constraintAxis == "y") { // Constrain the scaling to the y-axis and clip the x-axis.
      
      yImgSize = ySize/yImgCount;
      xImgSize = yImgSize*aspectRatio;
      
    } else { // If we don't care about the aspect ratio of the image and just want to force the tiling to fit in the area.
    
      xImgSize = xSize/xImgCount;
      yImgSize = ySize/yImgCount;
      
    }
    
    // After the specific computations were done, call on the method that actually tiles the image
    computePGraphic();
    
  }
  
  
  
  
  // █▀▄▀█ █▀▀ ▀█▀ █░█ █▀█ █▀▄ █▀
  // █░▀░█ ██▄ ░█░ █▀█ █▄█ █▄▀ ▄█
  
  
  void computePGraphic() {
    
    tiledImage = createGraphics(Math.round(xSize), Math.round(ySize), P2D); // Create the actual PGraphics instance
    tiledImage.beginDraw();
      tiledImage.clear();
      
      // We loop through however many instances of the image would fit the tiling area on the horizontal axis, and then for each horizontal instance do the same on the vertical.
      for (int i = 0; i<Math.ceil(xSize/xImgSize); i++ ) {
        for (int j = 0; j<Math.ceil(ySize/yImgSize); j++ ) {
          // tiledImage.image() NOT JUST image()  ->  It will otherwise not be generated within TiledImage
          tiledImage.image(img, xImgSize*i, yImgSize*j, xImgSize, yImgSize);
        }
      }
      
    tiledImage.endDraw();
    
  }


  void render() {
    
    // If there is a tiledImage defined already, render it.
    if (tiledImage != null) { image(tiledImage, xPos, yPos); }
  }
  
  
}
