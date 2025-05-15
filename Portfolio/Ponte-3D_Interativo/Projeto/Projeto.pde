
// Projeto de Computação Grafica ================================================
// Aluno: João Silva

//Comandos =======================================================================

// "W A S D" - Mover a Camara
// "+ -" - Aumentar e diminuir o zoom
// SPACEBAR - Coloca o cenario a girar
// "MOUSE / Botão esquerdo" - Animação de Abrir e Fechar a Ponte
// "MOUSE / Botão direito" - Muda entre dia e noite
// "L" - Acender os Candieiros


// Variaveis da Agua =================================================================

int cols, rows;
int scl = 50;
int w = 1100;
int h = 4050;

float flying = 0;

float [][] terrain;

// Texturas =====================================================================================

PImage estrada, pilar, suporte; // Texturas
PImage estrada_2, pilar_2, arco; // da Ponte

PImage cenario_1, cenario_2, agua, lampada, lampada_3; // Cenario

PImage c_lado, para_brisa, teto, pcd, pct; // Carro

float ang1 = 0, angC = PI/2, angP = 0; // Angulo para girar cenario / Angulo da camara / Angulo de abertura da ponte
int zoom = 2000; // Zoom da Camara
int altC = -200; // Altura da Camara
float xC, yC, zC; // Coordenadas da Camara
int pc = -1900; // Posição do carro

boolean girar = false; // Variavel do modo de girar o Cenario
boolean abrirP = false; // Variavel da Animação da Ponte
boolean night = false; // variavel da luz natural
boolean luzes = false; // variavel da luz natural

void settings() {
  size(1200, 800, P3D);
}

void setup() {

  // Agua variaveis ========================================================================

  cols = w / scl;
  rows = h / scl;

  terrain = new float [cols][rows];

  // Texturas ================================================================================

  estrada = loadImage("Estrada.jpg");
  suporte = loadImage("Suporte.jpg");
  pilar = loadImage("Pilar.jpg");
  estrada_2 = loadImage("Estrada_2.jpg");
  pilar_2 = loadImage("Pilar_2.jpg");
  arco = loadImage("Arco.jpg");
  c_lado = loadImage("Carro_Lado.jpg");
  para_brisa = loadImage("Para_Brisa.jpg");
  teto = loadImage("Teto.jpg");
  pcd = loadImage("Para_Choques_D.jpg");
  pct = loadImage("Para_choques_T.jpg");
  cenario_1 = loadImage("Cenario_1.jpg");
  cenario_2 = loadImage("Cenario_2.jpg");
  agua = loadImage("Agua.jpg");
  lampada = loadImage("Lampada_1.jpg");
  lampada_3 = loadImage("Lampada_3.jpg");
}

void draw() {

  // Camara ========================================================================

  xC = width/2+zoom*cos(angC);
  yC = altC;
  zC =  zoom*sin(angC);

  camera(xC, yC, zC, width/2, 0, 0, 0, 1, 0);

  if (xC > 1800 || xC < -600) { // Este codigo é para impedir que
    if (altC >= 0) {            // a camara entre no interior do cenario
      altC = 0;
    }
  }

  // Defenição do Centro e do Eixo de Rotação ======================================

  translate(width/2, 0, 0);
  rotateY(ang1);

  if (girar == true) {
    ang1 = ang1 + radians(1);
  }

  //Luzes ===========================================================================

  if (night == false) {
    background(170, 255, 255);
    ambientLight(255, 255, 255);
  } else {
    background(0, 15, 30);
    ambientLight(70, 70, 70);
    if (luzes == true) {
      lampada= loadImage("Lampada_2.jpg");
      pointLight(125, 100, 0, 1400, -600, 250);
      pointLight(125, 100, 0, -1400, -600, -250);
    } else {
     lampada= loadImage("Lampada_1.jpg");
    }
  }

  // Plano Chão ====================================================================
  strokeWeight(0);


  beginShape(QUADS);
  int a = 1; // Codigo para espelhar o cenario
  for (int i = 1; i <= 2; i++ ) {
    if (i % 2 == 0) {
      a = 1;
    } else {
      a = -a;
    }
    texture(cenario_1);

    vertex(2200*a, 88, 2000, 1, 1);
    vertex(1200*a, 88, 2000, 0, 1);
    vertex(1200*a, 88, -2000, 0, 0);
    vertex(2200*a, 88, -2000, 1, 0);

    vertex(1200*a, 375, 2000, 0.4, 0.4);
    vertex(500*a, 375, 2000, 0, 0.4);
    vertex(500*a, 375, -2000, 0, 0);
    vertex(1200*a, 375, -2000, 0.4, 0);

    endShape();
  }


  beginShape(QUADS);
  for (int i = 1; i <= 2; i++ ) {
    if (i % 2 == 0) {
      a = 1;
    } else {
      a = -a;
    }

    texture(cenario_2);

    vertex(1200*a, 375, 2000, 0, 1);
    vertex(1200*a, 375, -2000, 0, 0);
    vertex(1200*a, 88, -2000, 1, 0);
    vertex(1200*a, 88, 2000, 1, 1);

    vertex(500*a, 375, 2000, 1, 0);
    vertex(500*a, 375, -2000, 1, 1);
    vertex(400*a, 800, -2000, 0, 1);
    vertex(400*a, 800, 2000, 0, 0);
  }
  // Centro _______________________________________________________________________

  vertex(400, 800, 2000, 0.7, 0.7);
  vertex(-400, 800, 2000, 0, 0.7);
  vertex(-400, 800, -2000, 0, 0);
  vertex(400, 800, -2000, 0.7, 0);

  endShape();

  // Candieiros ====================================================================
  
  pushMatrix();
  translate(1300, 88-(500/2), 250);
  desenharCandieiro(60, 500, 60, lampada_3, lampada_3, lampada);
  popMatrix();
  pushMatrix();
  translate(-1300, 88-(500/2), -250);
  desenharCandieiro(60, 500, 60, lampada_3, lampada_3, lampada);
  popMatrix();

  // Mar ===========================================================================

  pushMatrix();
  desenharAgua(agua);
  popMatrix();


  //Ponte ==========================================================================

  // Estrada da Ponte ==============================================================
  pushMatrix();
  translate(300, 100);
  translate(300, 0, 0);
  rotateZ(-angP);
  translate(-300, 0, 0);
  desenharPrismaRetangular (600, 25, 300, estrada, estrada_2);
  popMatrix();
  pushMatrix();
  translate(-300, 100);
  translate(-300, 0, 0);
  rotateZ(angP);
  translate(300, 0, 0);
  desenharPrismaRetangular (600, 25, 300, estrada, estrada_2);
  popMatrix();

  pushMatrix();
  translate(900, 100);
  desenharPrismaRetangular (600, 25, 300, estrada, estrada_2);
  popMatrix();
  pushMatrix();
  translate(-900, 100);
  desenharPrismaRetangular (600, 25, 300, estrada, estrada_2);
  popMatrix();

  //Postes Horizontais ==========================================================

  pushMatrix();
  translate(575/2, 90, 175);
  translate(575/2+25, 0, 0);
  rotateZ(-angP);
  translate(-575/2-25, 0, 0);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();
  pushMatrix();
  translate(-575/2, 90, 175);
  translate(-575/2-25, 0, 0);
  rotateZ(angP);
  translate(575/2+25, 0, 0);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();
  pushMatrix();
  translate(575/2, 90, -175);
  translate(575/2+25, 0, 0);
  rotateZ(-angP);
  translate(-575/2-25, 0, 0);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();
  pushMatrix();
  translate(-575/2, 90, -175);
  translate(-575/2-25, 0, 0);
  rotateZ(angP);
  translate(575/2+25, 0, 0);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();

  pushMatrix();
  translate(625+575/2, 90, 175);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();
  pushMatrix();
  translate(-625-575/2, 90, 175);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();
  pushMatrix();
  translate(625+575/2, 90, -175);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();
  pushMatrix();
  translate(-625-575/2, 90, -175);
  desenharPrismaRetangular (575, 50, 50, pilar_2, pilar_2);
  popMatrix();

  // Pilares da Ponte =============================================================

  for (int i = 0; i < 4; i++) {

    float x, y, z;
    y = -175;

    if (i <= 1) {
      x = 600;
    } else {
      x = -600;
    }
    if (i % 2 == 0) {
      z = 175;
    } else {
      z = -175;
    }

    pushMatrix();
    translate(x, y, z);
    desenharPrismaRetangular (50, 800, 50, pilar, pilar);
    translate(0, 475, 0);
    desenharPrismaRetangular (75, 150, 75, suporte, suporte);
    popMatrix();
  }

  //Arcos ================================================================

  for (int i = 0; i < 4; i++) {

    float x, y, z;
    z = 0;

    if (i <= 1) {
      x = 600;
    } else {
      x = -600;
    }
    if (i % 2 == 0) {
      y = -150;
    } else {
      y = -375;
    }
    pushMatrix();
    translate(x, y, z);
    rotateY(PI/2);
    desenharArco(200, 150, 10, arco);
    popMatrix();
  }

  //Cabos ========================================================================

  strokeWeight(5);
  line(625, -570, 175, 1200, 100, 175);
  line(625, -570, -175, 1200, 100, -175);
  line(-625, -570, 175, -1200, 100, 175);
  line(-625, -570, -175, -1200, 100, -175);

  line(575, -570, 175, 600-575*cos(-angP), 90-575*sin(-angP), 175);
  line(575, -570, -175, 600-575*cos(-angP), 90-575*sin(-angP), -175);
  line(-575, -570, 175, -600+575*cos(angP), 90+575*sin(angP), 175);
  line(-575, -570, -175, -600+575*cos(angP), 90+575*sin(angP), -175);
  strokeWeight(0);

  // Animação da Ponte a Abrir =======================================================

  if (abrirP == true) {
    if (pc > 650 || pc < -790) {
      if (angP > radians(-50)) {
        angP = angP - radians(0.5);
      }
    }
  } else {
    if (angP < 0) {
      angP = angP + radians(0.5);
    }
  }

  // Animação do Carro ===============================================================

  pushMatrix();
  rotateY(PI/2);
  translate(-75, 25, pc);
  desenharCarroca(100, 100, 300, c_lado, para_brisa, teto, pcd, pct);
  popMatrix();

  if (angP > radians(-1)) {
    pc = pc +10;
  } else if (pc > 600 || pc < -800) {
    pc = pc +10;
  }
  if (pc > 2000) {
    pc = -1900;
  }
}

// Configuração do Rato =============================================================

void mousePressed() {
  if (mouseButton == LEFT) {
    if (abrirP == false) {
      abrirP = true;
    } else {
      abrirP = false;
    }
  }
  if (mouseButton == RIGHT) {
    if (night == false) {
      night = true;
    } else {
      night = false;
    }
  }
}

// Configuração do Teclado ==========================================================

void keyPressed() {

  switch (key) {
    case ('-'):
    if (zoom == 2200) {
      zoom = 2200;
    } else {
      zoom = zoom +100;
    }
    break;
    case ('+'):
    if (zoom == 100) {
      zoom = 100;
    } else {
      zoom = zoom -100;
    }
    break;
    case(' '):
    if (girar == true) {
      girar = false;
      ang1 = 0;
    } else {
      girar = true;
      zoom = 2000;
      altC = -400;
    }
    break;
    case ('a'):
    angC = angC + radians(10);
    break;
    case ('d'):
    angC = angC - radians(10);
    break;
    case ('w'):
    if (altC == -1000) {
      altC = -1000;
    } else {
      altC = altC - 100;
    }
    break;
    case ('s'):
    if (xC < 1800 && xC > -600) {
      if (altC == 300) {
        altC = 300;
      } else {
        altC = altC + 100;
      }
    } else {
      if (altC >= 0) {
        altC = 0;
      } else {
        altC = altC + 100;
      }
    }
    break;
    case ('l'):
    if (luzes == true) {
      luzes = false;
    } else {
      luzes = true;
    }
    break;
  }
}
