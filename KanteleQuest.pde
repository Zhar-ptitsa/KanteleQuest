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
 PVector beamEnd = vaino.pos.copy();
   PVector beam = new PVector((vaino.pos.x-vaino.oldpos.x),(vaino.pos.y-vaino.oldpos.y));
 float beamSlope = (vaino.oldpos.y-vaino.pos.y)/(vaino.oldpos.x-vaino.pos.x);
 if (beam.mag()<vaino.size){
   float beamScaler = vaino.size/(beam.mag()*2);
   println(beam.mag()+" "+beamScaler);
   beam.mult(beamScaler);
   beamEnd = vaino.oldpos.copy().add(beam);
   println("Beam: "+beam.mag());
 }
  line(vaino.oldpos.x,vaino.oldpos.y,beamEnd.x+((beamEnd.x-vaino.oldpos.x)*0),(beamEnd.y-vaino.oldpos.y)*(0)+beamEnd.y);
  stroke(0,0,150);
  circle(beamEnd.x,beamEnd.y,7);
  stroke(150,150,0);
  circle(vaino.oldpos.x,vaino.oldpos.y,7);
  ArrayList<float[]> Xlist = new ArrayList<float[]>();
  for (Block b : obstacles){
    for (int[] points : new int[][]{{0,1},{1,2},{2,3},{3,0}}){
      stroke(255);
      //line(b.edges[points[0]].x,b.edges[points[0]].y,b.edges[points[1]].x,b.edges[points[1]].y);
      
      float latestX = -1;
      float latestY = -1;
      float slope = -1;
      
      if ((b.edges[points[1]].x-b.edges[points[0]].x)==0){
        if ((vaino.oldpos.x-beamEnd.x)!=0){
          latestX = b.edges[points[0]].x;
          latestY = (vaino.oldpos.y-beamEnd.y)/(vaino.oldpos.x-beamEnd.x) * latestX + ( beamEnd.y*vaino.oldpos.x-vaino.oldpos.y*beamEnd.x)/(vaino.oldpos.x-beamEnd.x);
        }else{
           continue; 
        }
      }else if ((vaino.oldpos.x-beamEnd.x)==0){
        latestX = beamEnd.x;
                  latestY = (b.edges[points[1]].y-b.edges[points[0]].y)/(b.edges[points[1]].x-b.edges[points[0]].x) * latestX + ((b.edges[points[0]].y*b.edges[points[1]].x-b.edges[points[1]].y*b.edges[points[0]].x)/(b.edges[points[1]].x-b.edges[points[0]].x));
      }else{
      latestX = (( ((b.edges[points[0]].y*b.edges[points[1]].x-b.edges[points[1]].y*b.edges[points[0]].x)/(b.edges[points[1]].x-b.edges[points[0]].x)) - ( beamEnd.y*vaino.oldpos.x-vaino.oldpos.y*beamEnd.x)/(vaino.oldpos.x-beamEnd.x) ) / ( (vaino.oldpos.y-beamEnd.y)/(vaino.oldpos.x-beamEnd.x)- (b.edges[points[1]].y-b.edges[points[0]].y)/(b.edges[points[1]].x-b.edges[points[0]].x))) ;
                latestY = (vaino.oldpos.y-beamEnd.y)/(vaino.oldpos.x-beamEnd.x) * latestX + ( beamEnd.y*vaino.oldpos.x-vaino.oldpos.y*beamEnd.x)/(vaino.oldpos.x-beamEnd.x);
    }
    stroke(150);
           circle(latestX,latestY,5); 
         stroke(255);   
   
    boolean condition1 = ((beamEnd.x<=latestX && vaino.oldpos.x>=latestX) || (beamEnd.x>=latestX && vaino.oldpos.x<=latestX)) && ((beamEnd.y<=latestY && vaino.oldpos.y>=latestY) || (beamEnd.y>=latestY && vaino.oldpos.y<=latestY));
    boolean condition2 = ((b.edges[points[0]].x<= latestX && b.edges[points[1]].x>=latestX) || (b.edges[points[0]].x>=latestX && b.edges[points[1]].x<=latestX)) && ((b.edges[points[0]].y<= latestY && b.edges[points[1]].y>=latestY) || (b.edges[points[0]].y>=latestY && b.edges[points[1]].y<=latestY));
 
      
            if (condition1 && condition2){
              slope = (b.edges[points[1]].y-b.edges[points[0]].y)/(b.edges[points[1]].x-b.edges[points[0]].x);
        Xlist.add(new float[]{latestX,latestY, slope});
        stroke(0,150,0);
        circle(latestX,latestY,3);
      }
  }
  }
  if (beamEnd.y<vaino.oldpos.y){
    Xlist.sort(Comparator.comparingInt(arr -> int(arr[0])));
    Collections.reverse(Xlist);
  }
  if (beamEnd.y>vaino.oldpos.x){
    Xlist.sort(Comparator.comparingInt(arr -> int(arr[0])));
  }
  if (Xlist.size()>0){
    float theta = 0;
    float edgeSlope = Xlist.get(0)[2];
    if (Float.isInfinite(edgeSlope)){
      //non-vertical beam, vertical wall
      if (beamSlope==0){
         theta = PI/2; 
         println("check1");
      }else{
        theta = abs(atan(beamSlope)-PI/2);
        println("check2");
      }
    }else{
      if (Float.isInfinite(beamSlope)){
        //vertical beam, non-vertical wall
        if (edgeSlope==0){
          theta = PI/2;
          println("check3");
        }else{
        theta = abs(atan(beamSlope));
        println("check4");
        }
      }else{
      //combine slopes
      if (edgeSlope/beamSlope==-1){
        theta = PI/2;
        println("check5");
      }else{
        theta = abs(atan((edgeSlope-beamSlope)/(1+edgeSlope*beamSlope)));
        println(edgeSlope/beamSlope);
        println(edgeSlope+","+beamSlope);
        println("check6");
      }
      }
    }
    if (theta>PI/2){
      theta-=PI;
      theta = abs(theta);
    }
    println(theta*360/(2*PI));
    
    float buffer = vaino.size / (2*sin(theta));
    println(buffer);
    
    float phi = 0;
    if (Float.isInfinite(beamSlope)){
     phi = PI/2; 
    }else{
      phi = atan(beamSlope);
    }
    float xbuffer = cos(phi)*buffer;
    float ybuffer = sin(phi)*buffer;
    
    if (beamEnd.y>vaino.oldpos.y){
       ybuffer*=-1; 
    }
    if (beamEnd.x>vaino.oldpos.x){
     xbuffer*=-1; 
    }
    
    println(xbuffer+","+ybuffer);
    println(phi*360/(2*PI));
    
    
    //normal force
    PVector normal = new PVector(0,0);
    if (!Float.isInfinite(edgeSlope)){
     float rho = atan(edgeSlope);
     float normMag = gravity.y*cos(rho);
     normal = new PVector(normMag*sin(rho),normMag*cos(rho));
     println(normal.x+","+normal.y+","+rho+","+normMag);
     println(normal.y+","+gravity.y);
     println(vaino.vel.y+","+frameCount);
    }
    
    
    
    vaino.pos = new PVector(Xlist.get(0)[0]+xbuffer, Xlist.get(0)[1]+ybuffer);
    vaino.vel.sub(normal);
    circle(Xlist.get(0)[0], Xlist.get(0)[1], 5);
  }
}
