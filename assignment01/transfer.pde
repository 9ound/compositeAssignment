// transfer the colour properties of image R(reference) to image T(target)

PImage applyScalingsFromTo(PImage r, PImage t) {
  PImage n = t.copy();
  
  // calculate the standard deviation
  
  // anything we do for L, we do for A and B
  float [] s = new float [3];
  
  float [] sdRef = getStandardDeviationsFrom(r);
  float [] sdTarget = getStandardDeviationsFrom(t);
  float [] mTarget = getMeansFrom(t);
  
  // how different the Std of the reference are from the target
  for (int i = 0; i < s.length; i += 1) {
    s[i] = 1 - userVarianceScaling + userVarianceScaling * sdRef[i] / sdTarget[i];
  }
  
  
  n.loadPixels();

  for (int i = 0; i < t.pixels.length; i += 1) {
    if (alpha(n.pixels[i]) != 0) {
      int [] cp = rgb2Lab(red(n.pixels[i]), green(n.pixels[i]), blue(n.pixels[i]));
      
      for (int j = 0; j < cp.length; j += 1) {
        cp[j] = int(s[j] * (cp[j] - mTarget[j]) + mTarget[j]);
      }
      
      int [] rgb = lab2RGB(cp[0], cp[1], cp[2]);
      n.pixels[i] = color(rgb[0], rgb[1], rgb[2]);
    }
  }

  n.updatePixels();

  return n;
}
