import processing.video.*;

//video components
String [] backgrounds     = { "bg1.mp4", "bg2.mp4", "bg3.mp4", "bg4.mp4" };
Movie  [] bgMovies        = new Movie[ backgrounds.length ];

String [] foregrounds     = { "greenscreenTiger.mov", "bluescreenDino.mov" };
Movie  [] fgMovies        = new Movie[ foregrounds.length ];

String [] backgroundImgs  = { "desert.jpg", "jungle.jpeg", "underWater.jpeg" };
PImage [] BGImgs          = new PImage [ backgroundImgs.length ];
PImage background; 

boolean swapFG = true;
int currentBG  = 0;

//chromakey components
PImage fgImage;

color [] greenscreen = { #00FF00 };
color [] bluescreen = { #0000FF };

float closeColourDistance = 200;

//colourgrade components
PImage bgImage;

final float USER_VARIANCE_SCALING_DELTA = 0.05;
float userVarianceScaling = 0.4;

boolean adjustColours = false;

//=================================================================//
//                                                                 //
//                                                                 //
//                                                                 //
//=================================================================//

void setup() {
  size( 1280, 720 );
  
  background = loadImage(backgroundImgs[currentBG]);
  background.resize( 1280, 720 );
  
  background( 0 );
  
  
  loadVid();
}

void draw() {
  drawBG();
  drawFG();
  showTransferAmount();
}

void loadVid() {
  //background
  for ( int i = 0; i < backgrounds.length; i++ ) {
    bgMovies[i] = new Movie(this, backgrounds[i]);
    bgMovies[i].loop();
  }
  
  //foreground
  for ( int i = 0; i < foregrounds.length; i++ ) {
    fgMovies[i] = new Movie(this, foregrounds[i]);
    fgMovies[i].loop();
  }
}

void drawBG() { 
  //bgMovies[currentBG].read();
  //image( bgMovies[currentBG], 0, 0 );
  background = loadImage(backgroundImgs[currentBG]);
  
}

void drawFG() {
  if ( swapFG == true ) {
    fgMovies[0].read();
    fgImage = chromakey( fgMovies[0], greenscreen );
    image(fgImage, 0, 100);
    
      if (adjustColours) {
        showTransferAmount();
        //fgImage = applyScalingsFromTo( bgMovies[currentBG], fgImage );
        fgImage = applyScalingsFromTo( background, fgImage );
        println(getMeansFrom(bgMovies[currentBG]));
        println(getStandardDeviationsFrom(bgMovies[currentBG]));
    }
    
  } else if ( swapFG == false ) {
      fgMovies[1].read();
      fgImage = chromakey( fgMovies[1], bluescreen );
      image( fgImage, 0, 100 );
      
        if (adjustColours) {
          showTransferAmount();
          fgImage = applyScalingsFromTo( bgMovies[currentBG], fgImage );
        }
  }
  
  image( getImageHistogram(fgImage), 0, height - 200 );
  //image( getImageHistogram( bgMovies[currentBG]), width - 300, height - 200 );
  image( getImageHistogram( background ), width - 300, height - 200 );
}

void showTransferAmount() {
  fill(0);
  rect(width - 105, 5, 50, 20);
  fill(255);
  text(userVarianceScaling, width - 100, 20);
}
