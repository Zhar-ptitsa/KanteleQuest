Player vaino;
PVector gravity;
ArrayList<Block> obstacles;

void setup(){
  size(1080,720);
  background(0);
  vaino = new Player(width/2,height/2);
  gravity = new PVector(0,0.0);
  obstacles = new ArrayList<Block>();
  obstacles.add(new Block(10,10,10,10));
   vaino.display();

  
}

void draw(){
  background(0);
 vaino.accelerate(gravity);
 
 moveCharacter();
   vaino.update();


 
 vaino.display();
 for (Block s : obstacles){
  s.display(); 
 }
}
void keyReleased(){
 if (key==CODED){
  if ( keyCode==UP || keyCode==DOWN || keyCode == LEFT || keyCode == RIGHT){
   vaino.characterMotion(new PVector(0,0)); 
  }
 }
}
void keyPressed(){
 if (key==CODED){
  // if UP is pressed => dir = new PVector(...)
  // same thing for DOWN, LEFT, RIGHT
  // UP (0, -1)


  if (keyCode==UP){
        vaino.characterMotion(new PVector(0, -10));
  }
  // DOWN(0, 1)
    if (keyCode==DOWN){
          vaino.characterMotion(new PVector(0, 10));
  }
  // LEFT(-1,0)
    if (keyCode==LEFT){
                vaino.characterMotion(new PVector(-10, 0));

  }
  // RIGHT(1,0)
    if (keyCode==RIGHT){
                vaino.characterMotion(new PVector(10, 0));
  }
  } 
}

void moveCharacter(){
  strokeWeight(10);
  stroke(255);
  line(vaino.oldpos.x,vaino.oldpos.y,vaino.pos.x,vaino.pos.y);
}
