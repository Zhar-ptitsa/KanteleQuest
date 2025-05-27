import java.util.Comparator;
import java.util.Collections;

Player vaino;
PVector gravity;
ArrayList<Block> obstacles;

void setup(){
  frameRate(5);
  size(1080,720);
  background(0);
  vaino = new Player(width/2,height/2);
  gravity = new PVector(0,0.00);
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
  strokeWeight(5);
  stroke(255);
           vaino.update();

  line(vaino.oldpos.x,vaino.oldpos.y,vaino.pos.x+((vaino.pos.x-vaino.oldpos.x)*100),(vaino.pos.y-vaino.oldpos.y)*(100)+vaino.pos.y);
  
  ArrayList<int[]> Xlist = new ArrayList<int[]>();
  for (Block b : obstacles){
    for (int[] points : new int[][]{{0,1},{1,2},{2,3},{3,0}}){
      stroke(255);
      line(b.edges[points[0]].x,b.edges[points[0]].y,b.edges[points[1]].x,b.edges[points[1]].y);
      
      float latestX = -1;
      float latestY = -1;
      
      if ((b.edges[points[1]].x-b.edges[points[0]].x)==0){
        if ((vaino.oldpos.x-vaino.pos.x)!=0){
          latestX = b.edges[points[0]].x;
          latestY = (vaino.oldpos.y-vaino.pos.y)/(vaino.oldpos.x-vaino.pos.x) * latestX + ( vaino.pos.y*vaino.oldpos.x-vaino.oldpos.y*vaino.pos.x)/(vaino.oldpos.x-vaino.pos.x);
        }else{
           continue; 
        }
      }else if ((vaino.oldpos.x-vaino.pos.x)==0){
        latestX = vaino.pos.x;
                  latestY = (b.edges[points[1]].y-b.edges[points[0]].y)/(b.edges[points[1]].x-b.edges[points[0]].x) * latestX + ((b.edges[points[0]].y*b.edges[points[1]].x-b.edges[points[1]].y*b.edges[points[0]].x)/(b.edges[points[1]].x-b.edges[points[0]].x));
      }else{
      latestX = (( ((b.edges[points[0]].y*b.edges[points[1]].x-b.edges[points[1]].y*b.edges[points[0]].x)/(b.edges[points[1]].x-b.edges[points[0]].x)) - ( vaino.pos.y*vaino.oldpos.x-vaino.oldpos.y*vaino.pos.x)/(vaino.oldpos.x-vaino.pos.x) ) / ( (vaino.oldpos.y-vaino.pos.y)/(vaino.oldpos.x-vaino.pos.x)- (b.edges[points[1]].y-b.edges[points[0]].y)/(b.edges[points[1]].x-b.edges[points[0]].x))) ;
                latestY = (vaino.oldpos.y-vaino.pos.y)/(vaino.oldpos.x-vaino.pos.x) * latestX + ( vaino.pos.y*vaino.oldpos.x-vaino.oldpos.y*vaino.pos.x)/(vaino.oldpos.x-vaino.pos.x);
    }
    stroke(150);
           circle(latestX,latestY,5); 
         stroke(255);   
   
    boolean condition1 = (vaino.pos.x<=latestX && latestX>=vaino.oldpos.x) || (vaino.pos.x>=latestX && latestX<=vaino.oldpos.x) || (vaino.pos.y<=latestY && vaino.oldpos.y>=latestY) || (vaino.pos.y>=latestY && vaino.oldpos.y<=latestY);
    boolean condition2 = (b.edges[points[0]].x<= latestX && b.edges[points[1]].x>=latestX) || (b.edges[points[0]].x>=latestX && b.edges[points[1]].x<=latestX) || (b.edges[points[0]].y<= latestY && b.edges[points[1]].y>=latestY) || (b.edges[points[0]].y>=latestY && b.edges[points[1]].y<=latestY);
    println(latestX+","+latestY);
    println(condition1);   
    println(condition2);  
      
      println();
      if (condition1 && condition2){
        Xlist.add(new int[]{int(latestX),int(latestY)});
        stroke(0,150,0);
        circle(latestX,latestY,3);
      }
  }
  }
  if (vaino.pos.y<vaino.oldpos.y){
    Xlist.sort(Comparator.comparingInt(arr -> arr[0]));
    Collections.reverse(Xlist);
  }
  if (vaino.pos.y>vaino.oldpos.x){
    Xlist.sort(Comparator.comparingInt(arr -> arr[0]));
  }
  if (Xlist.size()>0){
    float Xedit;
    float Yedit;
    if (vaino.oldpos.x==vaino.pos.x){
      Xedit = 0;
      Yedit = 0;
      if (vaino.oldpos.y<vaino.pos.y){
        Yedit = -vaino.size/2;
      }
      if (vaino.oldpos.y>vaino.pos.y){
        Yedit = vaino.size/2;
      }
    }else{
      float slope = (vaino.oldpos.y-vaino.pos.y)/(vaino.oldpos.x-vaino.pos.x);
      if (abs(slope)==1){
        Xedit = -vaino.size/2;
        Yedit = -vaino.size/2;
      }else if (abs(slope)<1){
        Yedit = -vaino.size/2;
        Xedit = ( (vaino.oldpos.x-vaino.pos.x)*Yedit - ( vaino.pos.y*vaino.oldpos.x-vaino.oldpos.y*vaino.pos.x) ) / (vaino.oldpos.y-vaino.pos.y);
        if (abs(Xedit)>vaino.size/2){
          Xedit = -vaino.size/2;
        }
      }else if (slope!=0){
        Xedit = -vaino.size/2;
        Yedit = (vaino.oldpos.y-vaino.pos.y)/(vaino.oldpos.x-vaino.pos.x) * Xedit + ( vaino.pos.y*vaino.oldpos.x-vaino.oldpos.y*vaino.pos.x)/(vaino.oldpos.x-vaino.pos.x);
                if (abs(Yedit)>vaino.size/2){
          Yedit = -vaino.size/2;
        }
      }else{
       Xedit = vaino.size/2;
       Yedit = 0;
      }
      
      if (slope>0){
        Yedit*=-1;
      }
      if (vaino.pos.x<vaino.oldpos.x){
       Xedit*=-1;
       Yedit*=-1;
      }
      
      println(slope);
    }
    println(Xedit+","+Yedit);
    //vaino.pos = new PVector(Xlist.get(0)[0]+Xedit, Xlist.get(0)[1]+Yedit);
    circle(Xlist.get(0)[0], Xlist.get(0)[1], 5);
  }
}
