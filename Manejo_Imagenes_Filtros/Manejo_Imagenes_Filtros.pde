PImage img, img2, img3, img4;
float maximo = 15;
float a = 0.8f;

void setup(){
  size(800,600);
  img = loadImage("puppy.jpg");
  img2 = loadImage("cat.jpg");
  //img3 = new PImage(img2.width,img2.height,RGB);
  //img4 = new PImage(img.width,img.height,RGB);
}

void draw(){
  //updateCanvas();
  //updateImg(img2);
  //blackWhiteImg(img);
  //greyScale(img);
  //borderDetection(img2, img3);
  transparencia(img,img2,img4);
  //sepiaFilter(img);
  //image(img,0,0);
  //image(img2,350,100);
}

void updateCanvas(){
  loadPixels();
    for(int i=0; i<pixels.length;i++){
      float gActual = green(pixels[i]);
      float rActual = red(pixels[i]);
      float bActual = blue(pixels[i]);
      pixels[i] = color(rActual, gActual, 0);
    }
  updatePixels();
  image(img,0,0);
  image(img2,350,100);
}

void updateImg(PImage img){
  //carga la información a la matris de pixeles! -> pixels[]
  img.loadPixels();
  
    for(int i=0; i<img.pixels.length;i++){
      float gActual = green(img.pixels[i]);
      float rActual = red(img.pixels[i]);
      float bActual = blue(img.pixels[i]);
      img.pixels[i] = color(rActual, gActual, 0);
    }
  
  //UpdatePixels agarra la matris de pixels y la pasa a donde quieras.
  img.updatePixels();
  //pixels[]; Es un arreglo de UNA DIMENSION cada valor es un INT calculado de RGBAlpha
  //Pixels es de TODO el canvas
  image(img,300,300);
}

void blackWhiteImg(PImage img){
  img.loadPixels();
  for(int i = 0; i< img.width;i++){
    for(int j = 0; j< img.height;j++){
      int k = i + j * img.width;
      if(j%2 == 0){ //contra i es vertical... contra k es uno y uno
        img.pixels[k] = color(0,0,0);
      }
      /*else{
        float gActual = green(img.pixels[i]);
        float rActual = red(img.pixels[i]);
        float bActual = blue(img.pixels[i]);
        
        img.pixels[i] = color(rActual, gActual, bActual);
      }*/
      
    }
  }
  img.updatePixels();
  image(img,0,0);
}

void greyScale(PImage img){
  img.loadPixels();
  for(int i = 0; i< img.width;i++){
    for(int j = 0; j< img.height;j++){
      int k = i + j * img.width;
      float gActual = green(img.pixels[k]);
      float rActual = red(img.pixels[k]);
      float bActual = blue(img.pixels[k]);
      
      float promedio = (gActual + rActual + bActual)/3;
      
      img.pixels[k] = color(promedio, promedio, promedio);
    }
  }
  img.updatePixels();
  image(img,0,0);
}

void sepiaFilter(PImage img){
  img.loadPixels();
  for(int i = 0; i< img.width;i++){
    for(int j = 0; j< img.height;j++){
      int k = i + j * img.width;
      float G = green(img.pixels[k]);
      float R = red(img.pixels[k]);
      float B = blue(img.pixels[k]);
      
      float tr = 0.393*R + 0.769*G + 0.189*B;
      float tg = 0.349*R + 0.686*G + 0.168*B;
      float tb = 0.272*R + 0.534*G + 0.131*B;
      
      img.pixels[k] = color(tr, tg, tb);
    }
  }
  img.updatePixels();
  image(img,0,0);
}

void borderDetection(PImage img, PImage img2){
  img2 = new PImage(img.width,img.height,RGB);
  
  img2.loadPixels();
  img.loadPixels();
  for(int i = 0; i< img.width - 1;i++){
    for(int j = 0; j< img.height;j++){
      int k = i + j * img.width;
      float G = green(img.pixels[k]);
      float R = red(img.pixels[k]);
      float B = blue(img.pixels[k]);
      
      float promedio = (R + G + B)/3;
      
      int k2 = k + 1;
      float G2 = green(img.pixels[k2]);
      float R2 = red(img.pixels[k2]);
      float B2 = blue(img.pixels[k2]);
      
      float promedio2 = (R2 + G2 + B2)/3;
      
      //Detectar si esta en un Maximo Aceptable la diferencia entre promedios!
      if(abs(promedio - promedio2) > maximo){
        img2.pixels[k] = color(255, 0, 0);
      }else{
        img2.pixels[k] = color(0, 0, 0);
      }
    }
  }
  img.updatePixels();
  img2.updatePixels();
  
  image(img,0,0);
  image(img2,300,0);
}

void transparencia(PImage img, PImage img2, PImage img3 ){
  //Img1 la de atras
  //Img2 adelante
  //Img3 la transparente.
  
  img3 = new PImage(img.width,img.height,RGB);

  img.loadPixels();
  img2.loadPixels();
  
  for(int i = 0; i< img.width - 1;i++){
    for(int j = 0; j< img.height;j++){
      int k = i + j * img.width;
      if(i >= img2.width || j>= img2.height){
         img3.pixels[k] = img.pixels[k]; 
      }else{
        //proporcion de dos colores! con el ALFA qe definimos arriba.
        int k2 = i + j * img2.width;
        
         float nR = red(img.pixels[k]) * (1-a) + red(img2.pixels[k2]) * a;
         float nG = green(img.pixels[k]) * (1-a) + green(img2.pixels[k2]) * a;
         float nB = blue(img.pixels[k]) * (1-a) + blue(img2.pixels[k2]) * a;
         img3.pixels[k] = color(nR,nG,nB);         
      }
    } 
  }
  
  img3.updatePixels();
  image(img,0,0);
  //image(img2,0,0);
  image(img3,0,0);
}