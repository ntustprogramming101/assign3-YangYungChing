final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int STOP=0; 
final int DOWNWARD=1;
final int LEFTWARD=2; 
final int RIGHTWARD=3;
int movement=STOP;
final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg,lifeImage,cabbageImage,groundhogImage,stone1Image,stone2Image,groundhogLeft,groundhogRight,groundhogDown;

boolean upPressed, downPressed, rightPressed, leftPressed;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;
int lifeDistance=70;

float cabbageX=floor(random(0,8))*80;
float cabbageY=floor(random(2,6))*80;

float groundhogX=320;
float groundhogY=80;


PImage soilImage[] = new PImage[6];
int soilW=80,soilH=80;
int Y;


int count=8;
int soilX;
int soilY;
int a=0;



void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	
  lifeImage=loadImage("img/life.png");
  cabbageImage=loadImage("img/cabbage.png");
  groundhogImage=loadImage("img/groundhogIdle.png");
  stone1Image=loadImage("img/stone1.png");
  stone2Image=loadImage("img/stone2.png");

  
  soilImage[0]=loadImage("img/soil0.png");
  soilImage[1]=loadImage("img/soil1.png");
  soilImage[2]=loadImage("img/soil2.png");
  soilImage[3]=loadImage("img/soil3.png");
  soilImage[4]=loadImage("img/soil4.png");
  soilImage[5]=loadImage("img/soil5.png");
  
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  
  
 
}


void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

 
    

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT-a, width, GRASS_HEIGHT);

		
    //downPressed
   
    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int x=0; x<8; x++ ){
      for(int y=0; y<4; y++ ){
        soilX=soilW*x;
        soilY=soilH*y;
    for(int i = 0; i <6; i++){
     
      
      
      PImage img= soilImage[i];  
      Y=160+soilY+320*i;
      
  image(img, soilX, Y-a, soilW, soilH);
  
  }
  
  }

    
    
  // Stone1
  for(int i=0; i<count; i++ ){
    float spacing= width/count;
    float stone1X= i*spacing;
    float stone1Y= i*spacing;
    image(stone1Image,stone1X,160+stone1Y-a);
  }
  // Stone2
  for(int r=0; r<4; r++){
  for(int i=0; i<2; i++){
  for(int j=0; j<2; j++){
    int stone1Y=160+640+80*r;
    if(r%3==0){
      image(stone1Image,80*1+320*i,stone1Y+320*j-a);
      image(stone1Image,80*2+320*i,stone1Y+320*j-a);
    }else{
      image(stone1Image,0+320*i,stone1Y+320*j-a);
      image(stone1Image,80*3+320*i,stone1Y+320*j-a);
    }
  
  }
  } 
  }
   // Stone3
   for(int i=0; i<count; i++ ){
   for(int k=0; k<3; k++){
   for(int j=0; j<3; j++){
    float spacing= width/count;
    float stone1X= i*spacing;
    float stone1Y= 160+640+640+640-80-i*spacing;
    image(stone1Image,stone1X-240*k,stone1Y+240*j-a);
  }
  }
  }
   for(int i=0; i<count; i++ ){
   for(int k=0; k<3; k++){
   for(int j=0; j<3; j++){
    float spacing= width/count;
    float stone1X= i*spacing;
    float stone1Y= 160+640+640+640-80-i*spacing;
    image(stone1Image,80+stone1X-240*k,stone1Y+240*j-a);
    image(stone2Image,80+stone1X-240*k,stone1Y+240*j-a);
  }
  }
  }
  
  
}



		// Player

		// Health UI


    //groundhog
    image(groundhogImage,groundhogX,groundhogY);
    switch(movement){
        case STOP:
          groundhogImage = loadImage("img/groundhogIdle.png");
          groundhogY+=0;
        break;
        
        case DOWNWARD:
        a+=5;
        if(a%80==0){
        downPressed = false;}
        if(a>1600){
          a=1600;
          groundhogY+=5;
          groundhogImage = loadImage("img/groundhogDown.png");
          if(groundhogY%80==0){movement=STOP;}
        }else{
          groundhogY+=0;
          groundhogImage = loadImage("img/groundhogDown.png");
          if((Y-a)%80==0){movement=STOP;}
 
        }
        break;
        
        case LEFTWARD:
          groundhogX-=5;
          groundhogImage = loadImage("img/groundhogLeft.png");
          if(groundhogX%80==0){movement=STOP;}
        break;
        
        case RIGHTWARD:
          groundhogX+=5;
          groundhogImage = loadImage("img/groundhogRight.png");
          if(groundhogX%80==0){movement=STOP;}
        break;
     }


    // cabbage
    
    
    
    //life
    for(int i=0;i<playerHealth;i++){
      image(lifeImage,10+i*lifeDistance,10);
      
      if(playerHealth>5)playerHealth=5;
    }
    
   
    
     
      

      
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
    
      
    if(groundhogX%80==0 && groundhogY%80==0){
    switch(keyCode){
    case DOWN:
    downPressed = true;
    if(groundhogY+80<height){movement=DOWNWARD;}
    break;
    case RIGHT:
    rightPressed = true;
    if(groundhogX+80<width){movement=RIGHTWARD;}
    break;
    case LEFT:
    leftPressed = true;
    if(groundhogX>0){movement=LEFTWARD;}
    break;
  }
}
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
}
