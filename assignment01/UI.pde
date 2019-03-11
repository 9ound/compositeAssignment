void keyPressed() {
  if ( key == CODED ) {
    if ( keyCode == LEFT ) {
      swapFG = !swapFG;    
    } else if ( keyCode == RIGHT ){
      swapFG = !swapFG;
    }
  }
    
  if ( key == 'b' ) {
    currentBG = ( currentBG + 1 ) % backgrounds.length; 
    
  } else if ( key == 'v' ) {
    if ( currentBG > 0 ) {
      currentBG -= 1;
    } else {
      currentBG = backgrounds.length-1;
    }
  }
  
  switch (key) {
  case 't' :
    adjustColours = !adjustColours;
    break;

  case CODED:
    adjustTransferAmount();
    break;
    
  case ' ' :
      bgMovies[0].pause();
      fgMovies[0].pause();
    break;
  }
}

void adjustTransferAmount() {
  switch (keyCode) {
  case UP:
    userVarianceScaling = min(userVarianceScaling + USER_VARIANCE_SCALING_DELTA, 1.0);
    break;
  case DOWN:
    userVarianceScaling = max(0, userVarianceScaling - USER_VARIANCE_SCALING_DELTA);
    break;
  }
}
