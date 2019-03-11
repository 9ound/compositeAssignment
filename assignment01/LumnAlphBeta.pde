// transfer RGB into LAB (Luminance, alpha, beta)
int [] rgb2Lab(float r, float g, float b) {
  int [] lab = new int[3];

  lab[0] = int(0.3475 * r + 0.8231 * g + 0.5559 * b);
  lab[1] = int(0.2162 * r + 0.4316 * g - 0.6411 * b);
  lab[2] = int(0.1304 * r - 0.1033 * g - 0.0269 * b);

  return lab;
}

int [] lab2RGB(float l, float a, float b) {
  int [] rgb = new int[3];

  rgb[0] = int(0.5773 * l + 0.2621 * a + 5.6947 * b);   // red
  rgb[1] = int(0.5774 * l + 0.6072 * a - 2.5444 * b);   // green
  rgb[2] = int(0.5832 * l - 1.0627 * a + 0.2073 * b);   // blue

  return rgb;
}
