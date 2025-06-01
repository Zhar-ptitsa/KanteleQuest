import java.util.Comparator;
import java.util.Collections;

Player vaino;
PVector gravity;
ArrayList<Block> obstacles;

void setup(){
  frameRate(2);
  size(1080,720);
  background(0);
  vaino = new Player(width/2,height/2);
  gravity = new PVector(0,0.009);
  obstacles = new ArrayList<Block>();
  obstacles.add(new Block(width/4,height/2+50,100,100));
    obstacles.add(new Block(3*width/4,height/2+50,100,100));
        obstacles.add(new Block(2*width/4,3*height/4+50,100,100));


   vaino.display();

  
}

void draw(){
  background(0);
 vaino.accelerate(gravity);
 

 for (Block s : obstacles){
  s.display(); 
 }
 
  moveCharacter();

 vaino.display();


}

void keyPressed(){
  if (keyPressed){
     if (key==CODED){

      if (keyCode==UP){
        vaino.accelerate(new PVector(0,-2));
      }
      if (keyCode==DOWN){
        vaino.accelerate(new PVector(0, 2));
      }
      if (keyCode==LEFT){
        vaino.accelerate(new PVector(-10,0));
      }
      if (keyCode==RIGHT){
        vaino.accelerate(new PVector(10,0));
      }
    }
  }
}

void moveCharacter(){
  strokeWeight(5);
  stroke(255);
  vaino.update();
  circle(vaino.oldpos.x,vaino.oldpos.y,7);
  for (Block b : obstacles){
    for (int[] points : new int[][]{{0,1},{1,2},{2,3},{3,0}}){
      stroke(255);
      line(b.edges[points[0]].x,b.edges[points[0]].y,b.edges[points[1]].x,b.edges[points[1]].y);
    }
  }
}
