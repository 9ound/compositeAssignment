static final color RED = #FF0000;
static final color GREEN = #00FF00;
static final color BLUE = #0000FF;
static final color WHITE = #FFFFFF;


PImage getImageHistogram(PImage p) {
  int[] histogramR = new int[256];
  int[] histogramG = new int[256];
  int[] histogramB = new int[256];
  
  p.loadPixels();
  for (int i = 0; i < p.pixels.length; i += 1) {
    if (alpha(p.pixels[i]) > 0) {
      histogramR[int(red(p.pixels[i]))] += 1;
      histogramG[int(green(p.pixels[i]))] += 1;
      histogramB[int(blue(p.pixels[i]))] += 1;
    }
  }

  int histMax = maxOf(histogramR, histogramG, histogramB);

  stroke(255);
  PGraphics canvas = createGraphics(histogramR.length, 200);
  canvas.beginDraw();
  canvas.stroke(255);
  for (int i = 0; i < histogramR.length; i += 1) {
    drawBinInContextFor(canvas, histogramR[i], histMax, i, RED);
    drawBinInContextFor(canvas, histogramG[i], histMax, i, GREEN);
    drawBinInContextFor(canvas, histogramB[i], histMax, i, BLUE);
  }
  canvas.endDraw();

  return canvas;
}

void drawBinInContextFor(PGraphics canvas, int v, int r, int pos, color c) {
  float h = map(v, 0, r, 0, canvas.height);
  canvas.stroke(c);
  canvas.line(pos, canvas.height - h, pos, canvas.height);
}

int maxOf(int [] a, int [] b, int [] c) {
  int maxA = max(a);
  int maxB = max(b);
  int maxC = max(c);

  return max(maxA, maxB, maxC);
}


PImage getImageBrightnessHistogram(PImage p) {
  int[] histogram = new int[256];

  p.loadPixels();
  for (int i = 0; i < p.pixels.length; i += 1) {
    histogram[int(brightness(p.pixels[i]))] += 1;
  }
  int histMax = max(histogram);

  stroke(255);
  PGraphics canvas = createGraphics(histogram.length, 200);
  canvas.beginDraw();
  canvas.stroke(255);
  for (int i = 0; i < histogram.length; i += 1) {
    drawBinInContextFor(canvas, histogram[i], histMax, i, WHITE);
  }
  canvas.endDraw();

  return canvas;
}
