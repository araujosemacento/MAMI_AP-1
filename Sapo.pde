float passo = 1.0/6;
float tempo, xPos, yPos, alchor;
float vel = 60;
float theta = radians(60);
float grav = 9.81;
PImage fundo, sapo1, sapo2, sapo3, sapo4, portal1, portal2, moldura;
boolean redo;
float[] px = {};
float[] py = {};
int t;

void setup() {
  size(800, 400);
  fundo = loadImage("fundo.jpg");
  sapo1 = loadImage("sapo1.png");
  sapo2 = loadImage("sapo2.png");
  sapo3 = loadImage("sapo3.png");
  sapo4 = loadImage("sapo4.png");
  portal1 = loadImage("portal1.png");
  portal2 = loadImage("portal2.png");
  moldura = loadImage("frame.png");
  smooth();
  float aux = passo;
  passo *= 2;
  while (yPos <= height) {
    calculo();
    px = adicionar(px, xPos);
    py = adicionar(py, yPos);
    tempo += passo;
  }
  passo = aux;
  tempo = 0;
}

void draw() {
  image(fundo, 0, 0, 800, 400);
  trajeto();
  calculo();
  image(portal1, 180, height - 80, 110, 50);
  image(portal2, 180 + alchor, height - 80, 110, 50);
  imageMode(CENTER);
  if (xPos > 0 && xPos < alchor*0.25) {
    image(sapo1, xPos + 225, yPos - 80, 67, 45);
  } else if (xPos >= alchor*0.25 && xPos < alchor*0.5) {
    image(sapo2, xPos + 225, yPos - 80, 72, 45);
  } else if (xPos >= alchor*0.5 && xPos < alchor*0.75) {
    image(sapo3, xPos + 225, yPos - 80, 76, 36);
  } else if (xPos >= alchor*0.75 && xPos < alchor) {
    image(sapo4, xPos + 225, yPos - 80, 79, 40);
  }
  imageMode(CORNER);
  if (redo == true) {
    tempo = 0.0;
    redo = false;
  }
  if (yPos > height && redo == false) {
    redo = true;
  }
  dados();
  tempo += passo;
}

void calculo() {
  xPos = vel * cos(theta) * tempo;
  yPos = height - (xPos * tan(theta) - (grav * xPos * xPos)/(2 * vel * cos(theta) * vel * cos(theta)));
  alchor = (vel * vel * sin(2 * theta)) / grav;
}

float[] adicionar(float[] array, float elem) {
  float[] aux = new float [array.length + 1];
  for (int i = 0; i < array.length; i++) {
    aux[i] = array[i];
  }
  aux[array.length] = elem;
  return aux;
}

void trajeto() {
  stroke(255);
  strokeWeight(5);
  for (int i = 0; i < px.length; i++) {
    point(px[i] + 230, py[i] - 80);
  }
}

void dados() {
  noStroke();
  fill(5, 105, 55);
  rect(10, 15, 250, 150);
  image(moldura, -10, -5, 300, 200);
  fill(255);
  textFont(createFont("Times New Roman", 22));
  if (yPos > height+10 || xPos > px[px.length/2] && xPos < px[px.length/2 + 1]-5) {
    t++;
  }
  text("Tempo: " + t + " s", 45, 55);
  text("Altura: " + floor(height - yPos)/50.0 + " m", 45, 85);
  text("Deslocamento: " + floor(xPos)/100.0 + " m", 45, 115);
  text("Velocidade: " + floor((vel * sin(theta)) - (grav * tempo))/20.0 + " m/s", 45, 145);
}
