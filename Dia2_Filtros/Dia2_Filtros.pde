import processing.video.*;
import controlP5.*;
ControlP5 cp5;

Capture cam;
float bwTreshold = 0.2f;
float differenceTreshold = 10f;

int cameraIndex = 2;

int filterType = 1;

PImage captureBackground;

void setup(){
  size(700, 550);
  startCamera();
  sliderWhite();
  sliderDifference();
}

void startCamera(){
  String[] cameras = Capture.list();
  /*
  for(int i = 0; i < cameras.length; i++){
     println(cameras[i]); 
  }
  */
  println("SELECTED CAMERA: " + cameras[cameraIndex]);
  cam = new Capture(this, cameras[cameraIndex]);
  cam.start();
}

void draw(){
  noStroke();
  switch(filterType){
    case 1:
      webCamGreyFilter();
      break;
    case 2:
      webCamBlackAndWhiteFilter();
      break;
    case 3:
      webCamNegativeFilter();
      break;
    case 4:
      webCamDifferenceFilter();
      break;
    case 5:
      webCamSimpleRead();
      break;
    case 6:
      image(captureBackground,30,30);
      break;
  }
}

void webCamSimpleRead(){
  if (cam.available() == true) {
    background(0);
    cam.read();
  }
  image(cam, 30, 30);
}

void webCamGreyFilter(){
  if (cam.available() == true) {
    background(0);
    cam.read();
    cam.loadPixels();
    
    for(int i = 0; i < cam.width; i++){
      for(int j = 0; j < cam.height; j++){
        int k = i + j * cam.width;
        pushMatrix();
          fill(cam.pixels[k]);
          
          //intensidad de colores
          float r = red(cam.pixels[k]);
          float g = green(cam.pixels[k]);
          float b = blue(cam.pixels[k]);
          float grey = (r+g+b)/3;
          cam.pixels[k] = color(grey, grey, grey);
        popMatrix();
      }
    }
    cam.updatePixels();
    image(cam,30,30);
  }
}

void webCamBlackAndWhiteFilter(){
  if (cam.available() == true) {
    cam.read();
    background(0);
    cam.loadPixels();
    
    for(int i = 0; i < cam.width; i++){
      for(int j = 0; j < cam.height; j++){
        int k = i + j * cam.width;
        pushMatrix();
          fill(cam.pixels[k]);
          
          //intensidad de colores
          float r = red(cam.pixels[k]);
          float g = green(cam.pixels[k]);
          float b = blue(cam.pixels[k]);
          float promedio = ((r+g+b)/3)/255;
  
          if(promedio < bwTreshold){
            cam.pixels[k] = color(0, 0, 0);
          }else{
            cam.pixels[k] = color(255, 255, 255);
          }
        popMatrix();
      }
    }
    cam.updatePixels();
    image(cam,30,30);
  }
}

void webCamNegativeFilter(){
  if (cam.available() == true) {
    cam.read();
    background(0);
    cam.loadPixels();
    
    for(int i = 0; i < cam.width; i++){
      for(int j = 0; j < cam.height; j++){
        int k = i + j * cam.width;
        pushMatrix();
          fill(cam.pixels[k]);
          
          //intensidad de colores
          float r = 255 - red(cam.pixels[k]);
          float g = 255 - green(cam.pixels[k]);
          float b = 255 - blue(cam.pixels[k]);
          cam.pixels[k] = color(r, g, b);
        popMatrix();
      }
    }
    cam.updatePixels();
    image(cam,30,30);
  }
}

void webCamDifferenceFilter(){
  //Pixeles dentro del rango PONE BLANCO
  //Pixeles diferentes PONGO LA CAMARA
  if (cam.available() == true) {
    cam.read();
    background(0);
    cam.loadPixels();
    
    for(int i = 0; i < cam.width; i++){
      for(int j = 0; j < cam.height; j++){
        int k = i + j * cam.width;
        pushMatrix();
          fill(cam.pixels[k]);
          
          //intensidad de colores
          float r = red(cam.pixels[k]);
          float g = green(cam.pixels[k]);
          float b = blue(cam.pixels[k]);
          float pCam = (r+g+b)/3;
          
          float rb = red(captureBackground.pixels[k]);
          float gb = green(captureBackground.pixels[k]);
          float bb = blue(captureBackground.pixels[k]);
          float pBack = (rb+gb+bb)/3;
          
          float difference = abs(pCam - pBack);
          
          if(difference < differenceTreshold ){
            cam.pixels[k] = color(255);  
          }else{
            cam.pixels[k] = color(r, g, b);
          }
        popMatrix();
      }
    }
    cam.updatePixels();
    image(cam,30,30);
  }
}

boolean captureImage(int qty){
  if (cam.available() == true) {
    //cam.read();
    cam.loadPixels();
    captureBackground = new PImage(cam.width,cam.height,RGB);
    for(int i = 0; i< cam.pixels.length;i++){
        captureBackground.pixels[i] = cam.pixels[i];
    }
    captureBackground.updatePixels();
    return true;
  }else{
    if(qty < 1000){
      captureImage(qty + 1);
    }else{
      return false;
    }
  }
  return false;
}

//SLIDERS
void sliderWhite(){
  cp5 = new ControlP5(this);
  cp5.addSlider("White_Black")
    .setPosition(10,10)
     .setSize(200,10)
     .setRange(.1,1)
     .setValue(.2)
     .setNumberOfTickMarks(10); 
}

void White_Black(float v){
  bwTreshold = v;
}

void sliderDifference(){
  cp5 = new ControlP5(this);
  cp5.addSlider("Difference_Treshold")
    .setPosition(300,10)
     .setSize(200,10)
     .setRange(1,100)
     .setValue(10)
     .setNumberOfTickMarks(10); 
}

void Difference_Treshold(float v){
  differenceTreshold = v;
}

//KEYBOARD
void keyPressed(KeyEvent k){
  int code = k.getKeyCode();
   switch (code){
     case 49:
       filterType = 1;
       break;
     case 50:
       filterType = 2;
       break;
     case 51:
       filterType = 3;
       break;
     case 52:
       if(captureImage(0)){
         filterType = 4;
       }else{
         println("TOO slow");
       };
       
       break;
     case 53:
       filterType = 5;
       break;
     case 54:
       if(captureImage(0)){
         filterType = 6;
       }else{
         println("TOO slow");
       }
       break;
     default:
       println("DEFAULT");
       break;
   }
}