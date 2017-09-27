import controlP5.*;

ControlP5 cp5;

//Declaracion de variables
int x = 0;
float y = 0;
String a;

// Parte del ciclo de vida de un sketch
// Ciclo de vida - Serie de metodos que se invocan en algun punto controlados por un tercero

// 1 s vez al inicio, de entrada
void setup(){
  //Tamañl de sketch - size()
  size(640,480);
  manejoSlider();

  x = 30;
  //println("dude");
  //saludar();
}

// Metodo que se repite mientras se ejecute el sketch
void draw(){
  //FONDO - background(r,g,b)/(1)/etc
  background(0);
  rect(30, 30, 100 + x , 100 + x);
  x++;
}

void manejoSlider(){
   //USAR CcontrolP5
  cp5 = new ControlP5(this);
  //SLIDERS!
  cp5.addSlider("slider_test")
    .setPosition(10,10)
     .setSize(500,10)
     .setRange(0,10)
     .setValue(5)
     .setNumberOfTickMarks(10); 
     
   println("NOMA" + cp5.getValue("slider_test"));
  
}
//Listener de tu slider
void slider_test(float v){
  println("Valor: " + v);
}

//KEY PRESS
void keyPressed(KeyEvent k){
   println(k.getKeyCode());
  
}

//Ejemplo Metodos
void saludar(){
 println("HOLA"); 
}