import controlP5.*;
ControlP5 cp5;

float anguloRotationY = 0;
float anguloRotationX = 0;
float translationX = 320;
float translationY = 300;
float factorRotacion = 15;
float factorTranslacion = 15;
float ancho = 10;
float alto = 100;
float recursion = 5;
float cantRamas = 3;
float anguloRama = 30;
float factorZoom = 5;

// Zoom
float scaleFactor;

void setup(){
  size(640,480,P3D);
  sliderAngulo();
  sliderRecursion();
  sliderRamas();
  view();
}

void draw(){
  background(0);
  drawTree();
}

void drawTree(){
 pushMatrix();
    movimiento();
    rotateY(radians(anguloRotationY));
    rotateX(radians(anguloRotationX));
    arbol(1);
  popMatrix(); 
}

void movimiento(){
  translate(translationX,translationY,0);
  scale(scaleFactor);
}

void arbol(float nivel){
  if(nivel > recursion) return;
  
  float anchoN = ancho / nivel;
  float altoN = alto / nivel;
  float altoH = alto/ (nivel + 1);
  
  float desplazamiento = -(altoN - altoH)/2;
  //float desplazamiento = -((altoN/2)*cos(30));
  float ramaSeparation = 360/cantRamas;
  //println("Nivel: " + nivel + " anchoN: " + anchoN + " altoN: " + altoN + " altoH: " + altoH + " Desp: " + desplazamiento);
  //println("Desp: " + desplazamiento);
  box(anchoN,altoN,anchoN);
  
  for(int i = 0; i< cantRamas; i++){
    pushMatrix();
      translate(0, -altoH, 0);
      rotateY(radians(ramaSeparation * i));
      rotate(radians(anguloRama));
      translate(0, desplazamiento, 0);  
      arbol(nivel + 1);
    popMatrix();
  }
}

//KEY PRESS
void keyPressed(KeyEvent k){
  int code = k.getKeyCode();
   println("KEY CODE PRESS: " + k.getKeyCode());
   switch (code){
     case 39:
       anguloRotationY += factorRotacion;
       break;
     case 37:
       anguloRotationY -= factorRotacion;
       break;
     case 38:
       anguloRotationX += factorRotacion;
       break;
     case 40:
       anguloRotationX -= factorRotacion;
       break;
     case 65:
       //A
       translationX -= factorTranslacion;
       break;
     case 68:
       //D
       translationX += factorTranslacion;
       break;
     case 87:
       //W
       translationY -= factorTranslacion;
       break;
     case 83:
       //S
       translationY += factorTranslacion;
       break;
     case 82:
       view();
       println(translationY);
       println(translationX);
       break;
     default:
       println("DEFAULT");
       break;
   }
   println("ANGULO" + anguloRotationY)  ;
}

//MOVIMIENTO
void mouseDragged(){
  translationX= translationX + (mouseX - pmouseX);
  translationY =translationY + (mouseY - pmouseY);
}

void mouseWheel(MouseEvent e)
{
  scaleFactor += (e.getAmount()*factorZoom) / 100;
}

void view(){
  scaleFactor = 1;
  translationX = 320;
  translationY = 300;
  anguloRotationY = 0;
  anguloRotationX = 0;
}


//SLIDERS
void sliderRecursion(){
  cp5 = new ControlP5(this);
  cp5.addSlider("slider_recursion")
    .setPosition(10,10)
     .setSize(300,10)
     .setRange(1,10)
     .setValue(5)
     .setNumberOfTickMarks(10); 
}

void slider_recursion(float v){
  println("Cant Recursion: " + v);
  recursion = v;
}

void sliderRamas(){
  cp5 = new ControlP5(this);
  cp5.addSlider("slider_ramas")
    .setPosition(10,30)
     .setSize(210,10)
     .setRange(1,7)
     .setValue(3)
     .setNumberOfTickMarks(7); 
}

void slider_ramas(float v){
  println("Cant Ramas: " + v);
  cantRamas = v;
}

void sliderAngulo(){
  cp5 = new ControlP5(this);
  cp5.addSlider("slider_angulo")
    .setPosition(10,50)
     .setSize(300,10)
     .setRange(0,100)
     .setValue(30)
     .setNumberOfTickMarks(10); 
}

void slider_angulo(float v){
  println("Cant Angulo: " + v);
  anguloRama = v;
}