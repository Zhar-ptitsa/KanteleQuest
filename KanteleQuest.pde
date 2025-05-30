int xSquares;
int ySquares;
final int SQUARE_SIZE=10;
PVector vel=new PVector(0,0);
Player p;
int frameSpd;
PVector gravity;
PVector upForce;

void setup(){
  size(1080,720);
  drawGrid();
  p=new Player();
  frameSpd=5;
  gravity=new PVector(0,0.009);
  upForce=new PVector(0,0);
}

void drawGrid(){
  xSquares=width/SQUARE_SIZE;
  ySquares=height/SQUARE_SIZE;
  fill(255);
  stroke(0);
  strokeWeight(1);
  int x=0;
  int y=0;
  for(int r=0;r<ySquares;r++){
    for(int c=0;c<xSquares;c++){
      square(x,y,SQUARE_SIZE);
      x+=SQUARE_SIZE;
    }
    x=0;
    y+=SQUARE_SIZE;
  }
}

void draw(){
  background(255);
  drawGrid();
  Block b=new Block(20*SQUARE_SIZE,60*SQUARE_SIZE,70*SQUARE_SIZE,10*SQUARE_SIZE,#199017);
  b.display();
  p.display();
  if(frameCount%frameSpd==0){
    p.updatePos();
    p.accelerate(gravity);
  }
}

void displayPause(){
  stroke(#233CD8);
  strokeWeight(3);
  fill(#0D98FF);
  rect(width/4,height/4,width/2,height/2);
  fill(0);
  textAlign(CENTER);
  textSize(40);
  text("Paused",width/2,height/3);
  textSize(20);
  text("Press 'P' To Unpause",width/2,height*5/13);
}

void keyPressed(){
  if(keyCode=='P'){
    if(looping){
      noLoop();
      displayPause();
    }
    else{
      loop();
    }
  }
  
  if(keyCode=='R'){
    setup();
  }
  
  if(key==CODED){
    if(keyCode==UP){
      upForce=new PVector(0,-0.01);
      p.accelerate(upForce);
    }
    if(keyCode==LEFT){
      vel=new PVector(-SQUARE_SIZE,0);
      p.updateVel(vel);
    }
    if(keyCode==RIGHT){
      vel=new PVector(SQUARE_SIZE,0);
      p.updateVel(vel);
    }
  }
}
