import processing.video.*;

PImage img;
float angulo = 0;

//VIDEO
Capture cam;

void setup(){
  size(800, 600, P3D);
  img = loadImage("cat.jpg");
  
  startCamera();
}

void startCamera(){
  String[] cameras = Capture.list();
  for(int i = 0; i < cameras.length; i++){
     println(cameras[i]); 
  }
  cam = new Capture(this, cameras[3]);
  cam.start();
}

void draw(){
  background(0);
  noStroke();
  
  //rotateImage(img);
  //rotateAndScalateGray(img);
  //webCamSimpleRead();
  webCamTraslateAndGrey();
  
  //image(img,300,300);
}

void webCamTraslateAndGrey(){
  if (cam.available() == true) {
    cam.read();
    //background(0);
    translate(339,239);
    rotateY(radians(angulo));
    angulo +=10;
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
          translate(i, j, grey);
          box(1);
        popMatrix();
      }
    }
  }
}

void webCamSimpleRead(){
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
}

void rotateAndScalateGray(PImage img){
  translate(339,239);
  rotateY(radians(angulo));
  angulo +=10;
  img.loadPixels();
  
  for(int i = 0; i < img.width; i++){
    for(int j = 0; j < img.height; j++){
      int k = i + j * img.width;
      
      pushMatrix();
        fill(img.pixels[k]);
        
        //intensidad de colores
        float r = red(img.pixels[k]);
        float g = green(img.pixels[k]);
        float b = blue(img.pixels[k]);
        float grey = (r+g+b)/3;
        translate(i, j, grey);
        box(1);
      popMatrix();
    }
  }
}

void rotateImage(PImage img){
  translate(339,239);
  rotateY(radians(angulo));
  angulo +=10;
  img.loadPixels();
  
  for(int i = 0; i < img.width; i++){
    for(int j = 0; j < img.height; j++){
      int k = i + j * img.width;
      
      pushMatrix();
        fill(img.pixels[k]);
        translate(i, j, 0);
        box(1);
      popMatrix();
    }
  }
}