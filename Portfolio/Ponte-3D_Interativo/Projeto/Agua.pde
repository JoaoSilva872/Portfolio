void desenharAgua(PImage a) {

  flying -= 0.01;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -80, 80);
      xoff += 0.1;
    }
    yoff += 0.1;
  }

  translate(0, height/2 + 50, 15);
  rotateX(PI / 2);
  translate(-w/2, -h/2);

  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    texture(a);
    for (int x = 0; x < cols; x++) {
      float u = map(x, 0, cols-1, 0, 1); 
      float v0 = map(y, 0, rows-1, 0, 1); 
      float v1 = map(y+1, 0, rows-1, 0, 1);

      vertex(x * scl, y * scl, terrain[x][y], u, v0);
      vertex(x * scl, (y + 1) * scl, terrain[x][y+1],u, v1);
    }
    endShape();
  }
}
