PImage bg1,bg2;
PImage enemy, fighter,hp,treasure;
PImage start1, start2, end1, end2;

int bg1X,bg1Y,bg2X,bg2Y;

float rollSpeed,bloodAmount;
float treasureX,treasureY;
float enemyX, enemyY, enemySpeed;
float fighterX, fighterY, fighterSpeed;

boolean isPlaying;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean showTreasureImage = true;
boolean showLose;


final int START = 0;
final int PLAYING = 1;
final int WIN = 2;
final int LOSE = 3;
final float BLOOD = 19.2;

int gameState = START;
int counter =0;



void setup () {
  size(640, 480) ;
  
  //loadimage
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  
  //bg position
  bg1X = 0;
  bg2X = -640;
  
  //speed
  rollSpeed = 1;
  enemySpeed = 3;
  fighterSpeed = 5;
  
  //blood amount 
  bloodAmount = BLOOD*2;
  
  //treaaure position random  
  treasureX = random(0,600);
  treasureY = random(0,440);
  
  //enemy position random
  enemyX = 0;
  enemyY = height/2;
  
  //fighter position
  fighterX = width-60;
  fighterY = height/2;
  
  
  
}

void draw() {
  
  switch(gameState){
  
  case START:
    image(start2,0,0);
    
    //hover
    if(mouseX>=220&&mouseX<=420&&mouseY>=380&&mouseY<=400){
      image(start1,0,0);
      
      //start game
      if(mousePressed){
        gameState = PLAYING;
      }
    }
    
    break;
    
  case PLAYING:  
    
    //backgound
    image(bg1,bg1X,0);
    bg1X+=rollSpeed;
    image(bg2,bg2X,0);
    bg2X+=rollSpeed;;
    
    //background repeat
    if(bg1X==640){
      //bg1X = bg1X-1280;
      bg1X = -640;
    }else if(bg2X==640){
      //bg2X-=1280;
      bg2X = -640;
    }
    
    
    //fighter--//
        //fighter image
    image(fighter,fighterX,fighterY);
    
        //fighter move
    if (upPressed) {
        fighterY -= fighterSpeed;
      }
    if (downPressed) {
        fighterY += fighterSpeed;
      }
    if (leftPressed) {
        fighterX -= fighterSpeed;
      }
    if (rightPressed) {
        fighterX += fighterSpeed;
      }
      
        //fighter boundary detection
    if(fighterX>590){
      fighterX = 590;
    }
    if(fighterX<0){
      fighterX = 0;
    }
    if(fighterY>430){
      fighterY = 430;
    }
    if(fighterY<0){
      fighterY = 0;
    }
    
    //--fighter//
    
    
    
    
        
    //treasure--// 
    if(showTreasureImage){
      image(treasure,treasureX,treasureY);
    }
       
       //blood limit
    if(bloodAmount>BLOOD*10){
      bloodAmount = BLOOD*10;
    }else if(bloodAmount <=0){
      gameState = LOSE;
    }
             
        //hp and blood
    fill(255,0,0);
    noStroke();     
    rect(29,20,bloodAmount,20);
    image(hp,20,20);
    
        
          
        //fighter vs treasure vs blood
    if(fighterX>treasureX-20 && fighterX<(treasureX+21) && fighterY>treasureY-20 && fighterY<(treasureY+21) ){
      bloodAmount= bloodAmount+BLOOD;
      showTreasureImage = false;
      treasureX = random(0,600);
      treasureX = random(0,440);
    }
    
        //re-show
    if(counter%30==0){
    showTreasureImage = true;
    }
    counter++;
    
    //--treasure//
    
    
    //enemy--//
    
        //show enemy and track fighter
    image(enemy,enemyX,enemyY);
    if(enemyY>fighterY){
      enemyY-=enemySpeed;
    }else if(enemyY<fighterY){
      enemyY+=enemySpeed;
    }
    enemyX += enemySpeed;
    enemyX %= width;
    
        //enemy attack
    if(fighterX>enemyX-35 && fighterX<(enemyX+35) && fighterY>enemyY-35 && fighterY<(enemyY+35)){
      bloodAmount = bloodAmount -BLOOD*2;
      enemyX = 0;
    }    
    //--enemy//
    break;
  
  case WIN:
    break;
    
  case LOSE:
    image(end2,0,0);
    //hover
    if(mouseX>215 && mouseX<425 && mouseY>300 && mouseY<340){
      image(end1,0,0);
      //restart
      if(mousePressed){
        gameState = PLAYING;
        
        //reset game setting
        bloodAmount = BLOOD*2;
        fighterX = width-60;
        fighterY = height/2;
      }
     }
    
    break;
 }

}
void keyPressed(){
  
   if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }

}
void keyReleased(){
  
   if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
      
    }
  }

}
