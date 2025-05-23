int xSquares;
int ySquares;
final int SQUARE_SIZE=10;

void setup(){
  size(1000,800);
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
  Block b=new Block(20*SQUARE_SIZE,60*SQUARE_SIZE,60*SQUARE_SIZE,15*SQUARE_SIZE,#199017);
  b.drawBlock();
  Player p=new Player();
  p.drawPlayer();
}
