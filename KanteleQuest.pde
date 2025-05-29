int xSquares;
int ySquares;
final int SQUARE_SIZE=10;
PVector vel=new PVector(0,0);
Player p;
int frameSpd;
PVector gravity;
PVector upForce;

void setup(){
  size(1000,800);
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
  Block b=new Block(20*SQUARE_SIZE,60*SQUARE_SIZE,60*SQUARE_SIZE,15*SQUARE_SIZE,#199017);
  b.display();
  p.display();
  if(frameCount%frameSpd==0){
    p.updatePos();
    p.accelerate(gravity);
  }
}

void keyPressed() {
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
