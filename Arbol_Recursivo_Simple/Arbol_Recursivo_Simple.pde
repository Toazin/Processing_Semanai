import controlP5.*;

ControlP5 cp5;

float height;
float weigth;
float anchoArbol;
float altoArbol;
float angulo;
float niveles;
int x;
int y;

void setup(){
  height = 640;
  weigth = 480;
  anchoArbol = 10;
  altoArbol = 100;
  angulo = 30;
  niveles = 10;
  size(640,480);
  manejoSlider();
}

// Metodo que se repite mientras se ejecute el sketch
void draw(){

  background(0);
  noStroke();
  troncoPrincipal(height, weigth,anchoArbol,altoArbol);

}
//
void troncoPrincipal(float h, float w, float ancho, float alto){
  pushMatrix();
    //Transformacion - modifica forma o ubicaicon de objecto
    translate(h/2,w/2 + 100);
    arbol(1);
  popMatrix();
}

void arbol(float nivel){
  float anchoN = anchoArbol / nivel;
  float altoN = altoArbol / nivel;
  
  //if(nivel > niveles) return;
  if(anchoN < .8f) return;
  rect(0,0,anchoN,altoN);
  
  float anchoFuturo = anchoArbol / (nivel+1);
  float altoFuturo = altoArbol / (nivel+1);
  
    pushMatrix();
      rotate(radians(-angulo));
      translate(0, -altoFuturo * 0.9f);
      arbol(nivel + 1);
    popMatrix();
    
    pushMatrix();
      rotate(radians(angulo));
      translate(anchoFuturo,-altoFuturo * 0.9f);
      arbol(nivel+ 1);
    popMatrix();
}

void manejoSlider(){
   //USAR CcontrolP5
  cp5 = new ControlP5(this);
  //SLIDERS!
  cp5.addSlider("slider_angluo")
    .setPosition(10,10)
     .setSize(500,10)
     .setRange(0,100)
     .setValue(30)
     .setNumberOfTickMarks(10); 
}
//Listener de tu slider
void slider_angluo(float v){
  println("NuevoAngulo: " + v);
  angulo = v;
}

//KEY PRESS
void keyPressed(KeyEvent k){
   println(k.getKeyCode());
  
}