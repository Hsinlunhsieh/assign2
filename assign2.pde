// global variables
float frogX, frogY, frogW, frogH, frogInitX, frogInitY;
float leftCar1X, leftCar1Y, leftCar1W, leftCar1H;//car1
float leftCar2X, leftCar2Y, leftCar2W, leftCar2H;//car2
float rightCar1X, rightCar1Y, rightCar1W, rightCar1H;//car3
float rightCar2X, rightCar2Y, rightCar2W, rightCar2H;//car4
float pondY;

float speed;

int life;
int currentTime = 0;

final int GAME_START = 1;
final int GAME_WIN   = 2;
final int GAME_LOSE  = 3;
final int GAME_RUN   = 4;
final int FROG_DIE   = 5;
int gameState;

// Sprites
PImage imgFrog, imgDeadFrog;
PImage imgLeftCar1, imgLeftCar2;
PImage imgRightCar1, imgRightCar2;
PImage imgWinFrog, imgLoseFrog;

void setup(){
  size(640,480);
  textFont(createFont("font/Square_One.ttf", 20));
  // initial state
  gameState = GAME_START;
  
  speed = 5;
  
  // the Y position of Pond
  pondY = 32;
  
  // initial position of frog
  frogInitX = 304;
  frogInitY = 448;
  
  frogW = 32;
  frogH = 32;
  
  leftCar1W=leftCar2W=rightCar1W=rightCar2W = 32;//all cars' width 
  leftCar1H=leftCar2H=rightCar1H=rightCar2H = 32;//all cars' height
  leftCar1X = leftCar2X = 0; //position X of leftCar1,2
  rightCar1X = rightCar2X =640-rightCar1H;//position X of rightCar1,2
  
  leftCar1Y = 128;//position Y of leftCar1
  rightCar1Y =192;//position Y of rightCar1
  leftCar2Y  =256;//position Y of leftCar2
  rightCar2Y =320;//position Y of rightCar2
  
  // prepare the images
  imgFrog = loadImage("data/frog.png");
  imgDeadFrog = loadImage("data/deadFrog.png");
  imgLeftCar1 = loadImage("data/LCar1.png");//img of car1
  imgLeftCar2 = loadImage("data/LCar2.png");//img of car2
  imgRightCar1 = loadImage("data/RCar1.png");//img of car3
  imgRightCar2 = loadImage("data/RCar2.png");//img of car4
  imgWinFrog = loadImage("data/win.png");
  imgLoseFrog = loadImage("data/lose.png");
}

void draw(){
  switch (gameState){
    case GAME_START:
         background(10,110,16);
         text("Press Enter", width/3, height/2);    
         break;
        
    case FROG_DIE:
         if(millis()-currentTime >= 1000){
         frogX=frogInitX;
         frogY=frogInitY;
         gameState = GAME_RUN;
         }
         break;
    case GAME_RUN:
         background(10,110,16);
         
         // draw Pond
         fill(4,13,78);
         rect(0,32,640,32);

         // show frog live
         for(int i=0;i<life;i++){
             image(imgFrog,64+i*48 ,32);
         }

         // draw frog
         image(imgFrog, frogX, frogY);

         // -------------------------------
         // Modify the following code
         // to meet the requirement
         // -------------------------------

         //car1 move
         leftCar1X += speed*3;
         if (leftCar1X > width){
             leftCar1X = 0;
         }
         image(imgLeftCar1, leftCar1X, leftCar1Y);
  
         //car2 move
         leftCar2X += speed*1.5;
         if (leftCar2X > width){
             leftCar2X = 0;
         }
         image(imgLeftCar2, leftCar2X, leftCar2Y);
  
         //car3 move
         rightCar1X -= speed*2;
         if (rightCar1X < 0){
             rightCar1X = width;
         }
         image(imgRightCar1, rightCar1X, rightCar1Y);

         //car4 move
         rightCar2X -= speed*1;
         if (rightCar2X < 0){
             rightCar2X = width;
         }
         image(imgRightCar2, rightCar2X, rightCar2Y);
  
         float frogCX = frogX+frogW/2;
         float frogCY = frogY+frogH/2;
         
         float leftCar1CX  = leftCar1X+leftCar1W/2;
         float leftCar2CX  = leftCar2X+leftCar2W/2;
         float rightCar1CX = rightCar1X+rightCar1W/2;
         float rightCar2CX = rightCar2X+rightCar2W/2;
         //frog wins
         if (frogY <= pondY){
            gameState = GAME_WIN;
         }
         //frog loses
         if (life <= 0){
            gameState = GAME_LOSE;
         }
         // car1 hitTest
         if ((frogCX-leftCar1CX<32)&&(frogCX-leftCar1CX>-32) 
         && (frogCY == 144)){ 
             currentTime = millis();
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
         }
         // car2 hitTest
         if ((frogCX-rightCar1CX>-32)&&(frogCX-rightCar1CX<32)
         && (frogCY == 208)){
             currentTime = millis();
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
         }
         // car3 hitTest
         if ((frogCX-leftCar2CX<32)&&(frogCX-leftCar2CX>-32)
         && (frogCY == 272)){ 
             currentTime = millis();
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
         }

         // car4 hitTest
         if ((frogCX-rightCar2CX>-32)&&(frogCX-rightCar2CX<32)
         && (frogCY == 336)){
             currentTime = millis();
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
         }

         break;
         
    case GAME_WIN:
         background(0);
         image(imgWinFrog,207,164);
         fill(255);
         text("You Win !!",240,height/4);
         break;
    case GAME_LOSE:
         background(0);
         image(imgLoseFrog,189,160);
         fill(255);
         text("You Lose",240,height/4); 
         break;
 }
}

void keyPressed() {
    if (key == CODED) {
      switch( keyCode ){
    case UP:
         frogY -= 32;
         if(frogY < 0){
            frogY = 0;
         }       
         break;
         
    case DOWN:
         frogY += 32;
         if(frogY > height -32){
            frogY = height -32;
         }   
         break;
         
    case RIGHT:
         frogX += 32;
         if(frogX > width -32){
            frogX = width -32;
         }   
         break;
         
    case LEFT:
         frogX -= 32;
         if(frogX < 0){
            frogX = 0;
         }   
         break;
    
     }
    }
    if((key == ENTER) && 
      ((gameState == GAME_START) || 
      (gameState == GAME_WIN) || 
      (gameState == GAME_LOSE))){
       gameState = GAME_RUN;
       life = 3;
       frogX = frogInitX;
       frogY = frogInitY;
 }
}
