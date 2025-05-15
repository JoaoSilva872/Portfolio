
// Cubo/ Prisma Retangular  ===================================================

void desenharPrismaRetangular (float w, float h, float d, PImage a, PImage b) {

  textureMode(NORMAL);

  float halfW = w/2;
  float halfH = h/2;
  float halfD = d/2;

  beginShape(QUADS);

  // Lado Cima (Y=-h)
  texture(a);
  vertex(-halfW, -halfH, halfD, 0, 1); //A
  vertex(halfW, -halfH, halfD, 1, 1); //B
  vertex(halfW, -halfH, -halfD, 1, 0); //C
  vertex(-halfW, -halfH, -halfD, 0, 0); //D

  endShape(CLOSE);
  beginShape(QUADS);

  texture(b);

  // Lado Baixo (Y=h)
  vertex(-halfW, halfH, halfD, 0, 1); //E
  vertex(-halfW, halfH, -halfD, 0, 0); //H
  vertex(halfW, halfH, -halfD, 1, 0); //G
  vertex(halfW, halfH, halfD, 1, 1); //F

  // Frente (Z=d)
  vertex( -halfW, -halfH, halfD, 0, 0); // A
  vertex(-halfW, halfH, halfD, 0, 1); // E
  vertex(halfW, halfH, halfD, 1, 1); // F
  vertex( halfW, -halfH, halfD, 1, 0); // B

  // Tras (Z=-d)
  vertex(-halfW, -halfH, -halfD, 0, 0); //D
  vertex(halfW, -halfH, -halfD, 1, 0); //C
  vertex(halfW, halfH, -halfD, 1, 1); //G
  vertex(-halfW, halfH, -halfD, 0, 1); //H


  // Lado direito (X=w)
  vertex( halfW, -halfH, halfD, 1, 0); //B
  vertex(halfW, halfH, halfD, 1, 1); //F
  vertex(halfW, halfH, -halfD, 0, 1); //G
  vertex(halfW, -halfH, -halfD, 0, 0); //C

  // Lado esquerdo (X=-w)
  vertex( -halfW, -halfH, halfD, 1, 0); //A
  vertex(-halfW, -halfH, -halfD, 0, 0); //D
  vertex(-halfW, halfH, -halfD, 0, 1); //H
  vertex(-halfW, halfH, halfD, 1, 1); //E

  endShape(CLOSE);
}



// Arco =====================================================================

void desenharArco(float w, float h, float l, PImage a) {
  float d = w/2;
  float nSeg = 20;
  float step = -PI/nSeg;

  textureMode(IMAGE);

  // Faces de Baixo

  beginShape(QUADS);
  texture(a);

  for (int i = 0; i < nSeg; i++) {
    vertex(cos(i*step)*d, sin(i*step)*d, -l, 150, 0);
    vertex(cos((i+1)*step)*d, sin((i+1)*step)*d, -l, 0, 0);
    vertex(cos((i+1)*step)*d, sin((i+1)*step)*d, l, 0, 200);
    vertex(cos(i*step)*d, sin(i*step)*d, l, 150, 200);
  }
  vertex(d, 0, -l, 0, 0);
  vertex(d+w/4, 0, -l, 0, 150);
  vertex(d+w/4, 0, l, 200, 150);
  vertex(d, 0, l, 200, 0);

  vertex(-d, 0, -l, 200, 0);
  vertex(-d-w/4, 0, -l, 200, 150);
  vertex(-d-w/4, 0, l, 0, 150);
  vertex(-d, 0, l, 0, 0);

  endShape(CLOSE);

  // Face direita

  beginShape();

  texture(a);

  vertex(d+w/4, 0, l);
  vertex(d+w/4, 0, -l);
  vertex(d+w/4, -h, -l);
  vertex(d+w/4, -h, l);

  endShape();

  // Face Esquerda

  beginShape();

  texture(a);

  vertex(-d-w/4, 0, l);
  vertex(-d-w/4, -h, l);
  vertex(-d-w/4, -h, -l);
  vertex(-d-w/4, 0, -l);

  endShape();

  // Face de Cima

  beginShape();

  texture(a);

  vertex(-d-w/4, -h, l, 200, 0);
  vertex(d+w/4, -h, l, 0, 0);
  vertex(d+w/4, -h, -l, 0, 150);
  vertex(-d-w/4, -h, -l, 200, 150);

  endShape();

  // Face Frente

  beginShape();

  texture(a);

  for (int i = 0; i <= nSeg; i++) {
    vertex(cos(-i*step)*-d, sin(-i*step)*-d, l, 100-d/2*cos(-i*step), 150-d/2*sin(-i*step));
  }
  vertex(d+w/4, 0, l, 200, 150);
  vertex(d+w/4, -h, l, 200, 0);
  vertex(-d-w/4, -h, l, 0, 0);
  vertex(-d-w/4, 0, l, 0, 150);



  endShape();

  // Face Trás

  beginShape();

  texture(a);

  for (int i = 0; i <= nSeg; i++) {
    vertex(cos(i*step)*d, sin(i*step)*d, -l, 100+d/2*cos(i*step), 150+d/2*sin(i*step));
  }
  vertex(-d-w/4, 0, -l, 0, 150);
  vertex(-d-w/4, -h, -l, 0, 0);
  vertex(d+w/4, -h, -l, 200, 0);
  vertex(d+w/4, 0, -l, 200, 150);



  endShape();
}

// Carro ========================================================================

void desenharCarroca(float w, float h, float l, PImage a, PImage b, PImage c, PImage d, PImage e) {

  beginShape(QUADS);
  textureMode(NORMAL);
  texture(b);

  // Para-brisas dianteiro

  vertex(w/2, 0, 2*l/10, 1, 1);
  vertex(w/2, -h/2, 1*l/10, 1, 0);
  vertex(-w/2, -h/2, 1*l/10, 0, 0);
  vertex(-w/2, 0, 2*l/10, 0, 1);
  endShape();

  // Para-brisas Traseiro

  vertex(-w/2, 0, -3*l/10, 0, 1);
  vertex(-w/2, -h/2, -2*l/10, 0, 0);
  vertex(w/2, -h/2, -2*l/10, 1, 0);
  vertex(w/2, 0, -3*l/10, 1, 1);

  endShape();

  // Para-choques dianteiro

  beginShape();
  texture(d);

  vertex(w/2, h/2, l/2, 1, 1);
  vertex(-w/2, h/2, l/2, 0, 1);
  vertex(-w/2, 0, l/2, 0, 0);
  vertex(w/2, 0, l/2, 1, 0);

  endShape();

  // Para-choques Traseiro

  beginShape();
  texture(e);


  vertex(-w/2, h/2, -l/2, 0, 1);
  vertex(-w/2, 0, -l/2, 0, 0);
  vertex(w/2, 0, -l/2, 1, 0);
  vertex(w/2, h/2, -l/2, 1, 1);

  endShape();

  beginShape(QUADS);
  texture(c);
  // Capô

  vertex(w/2, 0, l/2, 1, 1);
  vertex(-w/2, 0, l/2, 0, 1);
  vertex(-w/2, 0, 2*l/10, 0, 0);
  vertex(w/2, 0, 2*l/10, 1, 0);

  // Teto

  vertex(w/2, -h/2, 1*l/10, 1, 1);
  vertex(-w/2, -h/2, 1*l/10, 0, 1);
  vertex(-w/2, -h/2, -2*l/10, 0, 0);
  vertex(w/2, -h/2, -2*l/10, 1, 0);

  // Porta da Bagagem

  vertex(w/2, 0, -l/2, 1, 1);
  vertex(-w/2, 0, -l/2, 0, 1);
  vertex(-w/2, 0, -3*l/10, 0, 0);
  vertex(w/2, 0, -3*l/10, 1, 0);

  // Face de Baixo

  vertex(w/2, h/2, l/2, 0, 0);
  vertex(-w/2, h/2, l/2, 0, 0);
  vertex(-w/2, h/2, -l/2, 0, 0);
  vertex(w/2, h/2, -l/2, 0, 0);

  endShape();

  beginShape();
  texture(a);

  // Lado direito

  vertex(w/2, h/2, l/2, 1, 1);
  vertex(w/2, 0, l/2, 1, 0.5);
  vertex(w/2, 0, 2*l/10, 0.7, 0.5);
  vertex(w/2, -h/2, 1*l/10, 0.6, 0);
  vertex(w/2, -h/2, -2*l/10, 0.3, 0);
  vertex(w/2, 0, -3*l/10, 0.2, 0.5);
  vertex(w/2, 0, -l/2, 0, 0.5);
  vertex(w/2, h/2, -l/2, 0, 1);

  endShape();

  beginShape();
  texture(a);
  // Lado Esquerdo

  vertex(-w/2, h/2, -l/2, 0, 1);
  vertex(-w/2, 0, -l/2, 0, 0.5);
  vertex(-w/2, 0, -3*l/10, 0.2, 0.5);
  vertex(-w/2, -h/2, -2*l/10, 0.3, 0);
  vertex(-w/2, -h/2, 1*l/10, 0.6, 0);
  vertex(-w/2, 0, 2*l/10, 0.7, 0.5);
  vertex(-w/2, 0, l/2, 1, 0.5);
  vertex(-w/2, h/2, l/2, 1, 1);


  endShape();
}

void desenharCandieiro(float w, float h, float l, PImage a, PImage b, PImage c) {

  pushMatrix();
  beginShape(QUADS);
  texture(b);

  // Face de Cima =======================================================

  vertex(-w/2, -h/2, l/2, 0, 1); //A
  vertex(w/2, -h/2, l/2, 1, 1); //B
  vertex(w/2, -h/2, -l/2, 1, 0); //C
  vertex(-w/2, -h/2, -l/2, 0, 0); //D

  // Face de Baixo =======================================================

  vertex((2*-w/2)/3, -h/2 + h/6, (2*l/2)/3, 0, 1); //E
  vertex((2*-w/2)/3, -h/2 + h/6, (2*-l/2)/3, 0, 0); //H
  vertex((2*w/2)/3, -h/2 + h/6, (2*-l/2)/3, 1, 0); //G
  vertex((2*w/2)/3, -h/2 + h/6, (2*l/2)/3, 1, 1); //F

  endShape();
  beginShape(QUADS);
  texture(c);

  // Lado Direito ========================================================

  vertex(w/2, -h/2, -l/2, 0, 0); //C
  vertex(w/2, -h/2, l/2, 1, 0); //B
  vertex((2*w/2)/3, -h/2 + h/6, (2*l/2)/3, 1, 1); //F
  vertex((2*w/2)/3, -h/2 + h/6, (2*-l/2)/3, 0, 1); //G

  // Lado Esquerdo ========================================================

  vertex(-w/2, -h/2, l/2, 1, 0); //A
  vertex(-w/2, -h/2, -l/2, 0, 0); //D
  vertex((2*-w/2)/3, -h/2 + h/6, (2*-l/2)/3, 0, 1); //H
  vertex((2*-w/2)/3, -h/2 + h/6, (2*l/2)/3, 1, 1); //E

  // Lado Frente ========================================================

  vertex(w/2, -h/2, l/2, 1, 0); //B
  vertex(-w/2, -h/2, l/2, 0, 0); //A
  vertex((2*-w/2)/3, -h/2 + h/6, (2*l/2)/3, 0, 1); //E
  vertex((2*w/2)/3, -h/2 + h/6, (2*l/2)/3, 1, 1); //F

  // Lado Trás ========================================================

  vertex(-w/2, -h/2, -l/2, 0, 0); //D
  vertex(w/2, -h/2, -l/2, 1, 0); //C
  vertex((2*w/2)/3, -h/2 + h/6, (2*-l/2)/3, 1, 1); //G
  vertex((2*-w/2)/3, -h/2 + h/6, (2*-l/2)/3, 0, 1); //H

  endShape();
  popMatrix();
  pushMatrix();
  translate(0, -((-h/2)-(-h/2 + h/6))/2, 0);
  desenharPrismaRetangular(w/3, (5*h)/6, l/3, a, a);
  popMatrix();
}
