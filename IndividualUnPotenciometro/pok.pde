import processing.serial.*; //al poner .* se importan todas las funciones de una libreria 

Serial port;
int leer;
float mapeado;

Catcher catcher;    
Timer timer;        
Drop[] drops;       
int totalDrops = 0; 

boolean gameOver = false;
import processing.sound.*;
SoundFile file;


PImage fondo;
PImage pokeball;
PImage pokemon;


// Variables de puntaje, nivel y vidas restantes 
int score = 0;      // Puntaje actual
int level = 1;      // Qué nivel se está jugando
int lives = 15;     // 10 vidas por nivel, una gota elimina un 
int levelCounter = 0;


PFont f;

void setup() {
  size(900, 500);

  fondo = loadImage("fondo.png");
  pokeball = loadImage("pokeball.png");
  pokemon = loadImage("pokemon.png");

  //file = new SoundFile(this, "can.mp3");
  //file.play();
  catcher = new Catcher(70); // Zona que atrapa las gotas, de radio 50
  drops = new Drop[30];    // Genera 1000 gotas
  timer = new Timer(300);    // Create a timer that goes off every 300 milliseconds
  timer.start();             // Inicio temporizador

  f = createFont("Courier New", 12, true); // tipografía para textos

  port= new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  background(#B71EA8);
  image(fondo, 0, 0, 900, 500);
  if (0 < port.available())
  {
    leer= port.read();
    mapeado = map(leer, 0, 255, 0, 800);
  }

  // Si se acaba el juego
  if (gameOver) {
    background(30);
    textFont(f, 48);
    textAlign(CENTER);
    fill(200, 160, 43);
    text("Perdio perris", width/2, height/2);
  } else {

    // Localización catcher
    catcher.setLocation(mapeado+10, 400); 
    // Display the catcher
    catcher.display(); 

    // Revisión tiempo
    if (timer.isFinished()) {
      // Deal with raindrops
      // Initialize one drop
      if (totalDrops < drops.length) {
        drops[totalDrops] = new Drop();
        // Increment totalDrops
        totalDrops++;
      }
      timer.start();
    }

    // Movimiento gotas
    for (int i = 0; i < totalDrops; i++ ) {
      if (!drops[i].finished) {
        drops[i].move();
        drops[i].display();
        if (drops[i].reachedBottom()) {
          levelCounter++;
          drops[i].finished(); 
          // Una vida menos si llega una gota al final de la ventana
          lives--;
          // Se acaba el juego con 0 vidas
          if (lives <= 0) {
            gameOver = true;
          }
        } 

        //RATONCITO
        noStroke();  //sin borde
        fill(#19980E); 
        image(pokeball, mapeado, 400); //  poto base

        // El marcador aumenta al atrapar una gota
        if (catcher.intersect(drops[i])) {
          drops[i].finished();
          levelCounter++;
          score++;
        }
      }
    }

    // Si 10 gotas no son atrapadas, termina el juego
    if (levelCounter >= drops.length) {
      // Aumentar nivel
      level++;
      // reiniciar elementos del nivel
      levelCounter = 0;
      lives = 10;
      timer.setTime(constrain(300-level*25, 0, 300));
      totalDrops = 0;
    }

    // Mostrar vidas restantes
    textFont(f, 15);
    fill(250);
    text("Vidas: " + lives, 80, 20);
    rect(78, 24, lives*10, 10);

    text("Peguele a las gotas ", 300, 20);
    text("Gotas: " + score, 300, 40);
  }
}

class Catcher {
  float r;    // radius
  color col;  // color
  float x, y; // location

  Catcher(float tempR) {
    r = tempR;
    col = color(250, 12, 250, 50);  //modifiqué aquí
    x = 0;
    y = 0;
  }

  void setLocation(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  void display() {  //Características del catcher
    noStroke();     //sin borde
    fill(225);       //sin color
    image(pokemon, r*20, r*20);
  }

  // Si el catcher toca una gota
  boolean intersect(Drop d) {
    float distance = dist(x, y, d.x, d.y);   // Calcular distancia
    // Compare distance to sum of radii
    if (distance < r + d.r) { 
      return true;
    } else {
      return false;
    }
  }
}

class Drop {
  float x, y;   // variables ubicación gotas
  float speed;  // velocidad gotas
  color c;
  float r;      // radio de las gotas

  boolean finished = false;

  Drop() {
    r = random(07, 12);       // Las gotitas son de tamaño random
    x = random(width);       // Start with a random x location
    y = -r*9;                // Start a little above the window
    speed = random(2, 5);    // Velocidad random entre 2-5
    //c = color(#F293DE);   // Color dorado
  }

  // Que las gotas caigan
  void move() {
    y += speed;   // Aumenta velocidad
  }

  boolean reachedBottom() {
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }

  void display() {

    for (int i = 1; i < r; i++ ) {
      image(pokemon, x, y, 40, 45);
    }
  }

  void finished() {
    finished = true;
  }
}

class Timer {
  int savedTime;
  int totalTime; 
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  void setTime(int t) {
    totalTime = t;
  }

  //iniciar el temporizador
  void start() {
    savedTime = millis();
  }
  boolean isFinished() { 
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
