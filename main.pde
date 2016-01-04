PImage img;
Button[] button;
Button saveImage;
float buttonY, buttonW, buttonH, gap;
float[] buttonX;
float[] noiseArr;
float noise;
int numToDraw;
int startTime;
int numTypes;
int p; 
Boolean button1Bool;
Boolean button2Bool;
Boolean button3Bool;
Boolean button4Bool; 
Boolean button5Bool;
Boolean button6Bool;

void setup() {

  button2Bool = true;
  button1Bool = false;
  button3Bool = false;
  button4Bool = false; 
  button5Bool = false; 
  button6Bool = false;
  background(255);
  img = loadImage("Penguins.jpg");
  

  numToDraw = 6000;

  startTime = millis();
  size(img.width, img.height);
  img.loadPixels();


  saveImage = new Button(gap, gap, 50, 50, "save"); 


  numTypes = 6;
  button = new Button[numTypes];

  for (int i=0; i<numTypes; i++) {
    gap = 10;
    buttonX = new float[numTypes];
    buttonX[i] = gap+i*(width/numTypes);
    buttonW = width/numTypes - (2*gap);
    buttonY = 6*height/7;
    buttonH = height/7-gap;
    button[0] = new Button(gap, buttonY, buttonW, buttonH, "lines");
    button[1] = new Button(gap+width/numTypes, buttonY, buttonW, buttonH, "Pointillism");
    button[2] = new Button(gap+2*width/numTypes, buttonY, buttonW, buttonH, "Cubism");
    button[3] = new Button(gap+3*width/numTypes, buttonY, buttonW, buttonH, "Perlin Noise");
    button[4] = new Button(gap+4*width/numTypes, buttonY, buttonW, buttonH, "blah");
    button[5] = new Button(gap+5*width/numTypes, buttonY, buttonW, buttonH, "other");
    button[i].drawAllButtons();
  }
  createProperties();
}
void draw() {
  if (millis()-startTime<5000) {
    drawPenguins();
  }
  for ( int i=0; i<numTypes; i++) {
    button[i].drawAllButtons();
  }
  saveImage.drawAllButtons();
}

void drawPenguins() {
  if (button1Bool == true) {
    for (int i =0; i<numToDraw; i++) {
      int p = floor(random(0, img.pixels.length));
      color _imageColor = img.pixels[p];
      int parm = 20; 
      int blue = floor(random(blue(_imageColor)-parm, blue(_imageColor)+parm));
      int red = floor(random(red(_imageColor)-parm, red(_imageColor)+parm));
      int green = floor(random(green(_imageColor)-parm, green(_imageColor)+parm));
      float imgBrightness = brightness(_imageColor);

      color imageColor = color(red, green, blue, 170);
      stroke(imageColor);
      strokeWeight(random(1, 3));
      //noStroke();
      int q = p%width;
      int t = floor(p/width);
      float angle = imgBrightness/255*PI;
      line(q, t, q+10*cos(angle), t+10*sin(angle));
    }
  }
  else if (button2Bool == true) {
    for (int i =0; i<numToDraw; i++) {
      p = floor(random(0, img.pixels.length));
      color _imageColor = img.pixels[p];
      int parm = 30; 
      int blue = floor(random(blue(_imageColor)-parm, blue(_imageColor)+parm));
      int red = floor(random(red(_imageColor)-parm, red(_imageColor)+parm));
      int green = floor(random(green(_imageColor)-parm, green(_imageColor)+parm));
      fill(red, green, blue);
      noStroke();
      int q = p%width;
      int t = floor(p/width);
      float size = 5;
      //rectMode(CORNER);
      ellipse(q, t, size, size);
    }
  }
  else if (button3Bool == true) {
    for (int i =0; i<numToDraw; i++) {
      p = floor(random(0, img.pixels.length));
      color particleColor = img.pixels[p];

      fill(particleColor, 100);
      noStroke();
      int q = p%width;
      int t = floor(p/width);
      float size = random(5, 15);
      rectMode(CENTER);
      rect(q, t, size, size);
    }
  }
  else if (button4Bool == true) {
    int arrlength = width*height;
    for (int i=0; i<numToDraw; i++) {
      int p = floor(random(0, arrlength));
      float q = p%width;
      float t = p/width;  
      color imgColor = img.pixels[p];
      stroke(imgColor, 100);
      strokeWeight(1);
      float angle = 2*PI*noiseArr[p];
      float size = 20;
      line(q, t, q+size*cos(angle)/2, t+size*sin(angle));
    }
  }
  else if (button5Bool == true) {
    for (int i=0; i<numToDraw; i++) {
      p = floor(random(0, img.pixels.length));
      color _imageColor = img.pixels[p];
      int parm = 30; 
      int blue = floor(random(blue(_imageColor)-parm, blue(_imageColor)+parm));
      int red = floor(random(red(_imageColor)-parm, red(_imageColor)+parm));
      int green = floor(random(green(_imageColor)-parm, green(_imageColor)+parm));
      stroke(red, green, blue);
      float size = 10;
      int q = p%width;
      int t = floor(p/width);
      int pRight = p+1;
      int pLeft = p-1; 
      int pUp = p-width; 
      int pDown = p+width;
      if (p+width>img.pixels.length-1) {
        pDown= p;
      }
      if (p-width<0) {
        pUp = p;
      }
      if (p+1>img.pixels.length-1) {
        pRight = p;
      }
      if (p-1<0) {
        pLeft = p;
      }
      float rightBright = 255-brightness(img.pixels[pRight]);
      float leftBright =  255-brightness(img.pixels[pLeft]);
      float upBright = 255-brightness(img.pixels[pUp]);
      float downBright =  255-brightness(img.pixels[pDown]);

      PVector right = new PVector(10*rightBright/255+1, 0); 
      PVector left = new PVector(-10*leftBright/255+1, 0);
      PVector up = new PVector(0, 1+10*upBright/255);
      PVector down = new PVector(0, -1+10*downBright/255);

      PVector dir = new PVector(0, 0);
      dir.add(right);
      dir.add(left);
      dir.add(up);
      dir.add(down);

      //stroke(particleColor);
      strokeWeight(2);
      line(q, t, q+dir.x, t+dir.y);
    }
  }
  if (button6Bool == true) {
    for (int i =0; i<numToDraw; i++) {
      int p = floor(random(0, img.pixels.length));
      color _imageColor = img.pixels[p];
      float imgBrightness = brightness(_imageColor);

      color imageColor = color(0, 0, 0, (255-imgBrightness)/255*130+1);
      stroke(imageColor);
      int q = p%width;
      int t = floor(p/width);
      float angle = imgBrightness/255*PI;
      line(q, t, q+5*cos(angle), t+5*sin(angle));
    }
  }
}
void mousePressed() {

  if (button[0].mouseOverMe() == true) {
    button[0].buttonColor = #FF0000;
    button1Bool = true;
    button2Bool = false;
    button3Bool = false;
    button4Bool = false;
    button5Bool = false;
    button6Bool = false;
    startTime = millis();
    background(240);
  }
  else  if (button[1].mouseOverMe() == true) {
    button[1].buttonColor = #FF0000;
    button2Bool = true;
    button1Bool = false;
    button3Bool = false;
    button4Bool = false;
    button5Bool = false;
    button6Bool = false;
    startTime = millis();
    background(240);
  }
  else  if (button[2].mouseOverMe() == true) {
    button[2].buttonColor = #FF0000;
    button3Bool = true;
    button1Bool = false;
    button2Bool = false;
    button4Bool = false;
    button5Bool = false;
    button6Bool = false;
    startTime = millis();
    background(240);
  }
  else  if (button[3].mouseOverMe() == true) {
    button[3].buttonColor = #FF0000;
    button3Bool = false;
    button1Bool = false;
    button2Bool = false;
    button4Bool = true;
    button5Bool = false;
    button6Bool = false;
    startTime = millis();
    background(240);
  }
  else  if (button[4].mouseOverMe() == true) {
    button[4].buttonColor = #FF0000;
    button3Bool = false;
    button1Bool = false;
    button2Bool = false;
    button4Bool = false;
    button5Bool = true;
    button6Bool = false;
    startTime = millis();
    background(240);
  }
  else  if (button[5].mouseOverMe() == true) {
    button[5].buttonColor = #FF0000;
    button3Bool = false;
    button1Bool = false;
    button2Bool = false;
    button4Bool = false;
    button6Bool = true;
    button5Bool = false;
    startTime = millis();
    background(240);
  }
  else  if (saveImage.mouseOverMe() == true) {
    saveImage.buttonColor = #FF0000;
    saveThePenguins();
  }
}
void mouseReleased() {
  //
  for (int i=0; i<numTypes; i++) {
    button[i].buttonColor = 0xFF000066;
    saveImage.buttonColor = 0xFF000066;
  }
}

void saveThePenguins() {
  String filename = month() +"-"+day()+"-"+year()+"-"+hour()+"-"+minute()+"-"+second();

  save(filename+".jpg");
}

void createProperties() {
  p = 0;
  int arrlength = width*height;
  noiseArr = new float[arrlength];
  for (int i=0; i<arrlength; i++) {
    float q = p%width;
    float t = p/width;
    noiseArr[i] = noise(q*.01, t*.01);
    p +=1;
  }
}
