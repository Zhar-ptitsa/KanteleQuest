import java.util.Collections;

Player vaino;
PVector gravity;
PVector startPosition;
ArrayList<Block> obstacles;
boolean started;
int levelIndex;
Levels[] levels;

void setup(){
  frameRate(60);
  size(1080,720);
  
  started = false;
  levelIndex = 0;
 levels = new Levels[]{new Levels("level1.txt"),new Levels("level2.txt")};
  
}

void draw(){
  if (!started){
      //level data
  background(levels[levelIndex].backdrop);
  gravity = levels[levelIndex].gravity;
  obstacles = levels[levelIndex].obstacles;
  startPosition = levels[levelIndex].startPosition;
  float jump = levels[levelIndex].jump;
  float walk = levels[levelIndex].walk;
  
  vaino = new Player(startPosition.x,startPosition.y, jump, walk);



   vaino.display();
   started = true;
  }
  background(0);
 vaino.accelerate(gravity);
 

 for (Block s : obstacles){
  s.display(); 
 }
  moveCharacter();
   vaino.display();




}

void keyPressed(){
     if (key==CODED){

      if (keyCode==UP && !vaino.directions[0]){
        vaino.accelerate(new PVector(0,-vaino.jump));
        vaino.directions[0]=true;
      }
      if (keyCode==LEFT && !vaino.directions[1]){
        vaino.accelerate(new PVector(-vaino.walk,0));
        vaino.directions[1]=true;
      }
      if (keyCode==RIGHT && !vaino.directions[2]){
        vaino.accelerate(new PVector(vaino.walk,0));
        vaino.directions[2]=true;
      }
      
    }
}

void keyReleased(){
     if (key==CODED){

      if (keyCode==UP){
        if (vaino.vel.y<-vaino.jump){
        vaino.accelerate(new PVector(0,vaino.jump));
        }else{
         vaino.vel.y=0; 
        }
        vaino.directions[0]=false;
      }
      if (keyCode==LEFT){
        if (vaino.vel.x<-vaino.walk){
        vaino.accelerate(new PVector(vaino.walk,0));
        }else{
         vaino.vel.x=0; 
        }
        vaino.directions[1]=false;
      }
      if (keyCode==RIGHT){
        if (vaino.vel.x>vaino.walk){
        vaino.accelerate(new PVector(-vaino.walk,0));
        }else{
         vaino.vel.x=0; 
        }
        vaino.directions[2]=false;
      }
      
    }
}

void reset(){
  vaino.display();
  vaino.pos= startPosition.copy();
  vaino.vel= new PVector(0,0);
  vaino.acc= new PVector(0,0);
}

void levelup(){
  vaino.display();
  reset();
  if (levelIndex<levels.length-1){
     levelIndex+=1;
     started = false;
  }else{
        noLoop();
    background(255);
  }
}

void moveCharacter(){
  ArrayList<float[]> collisions = new ArrayList<float[]>();
  strokeWeight(5);
  stroke(255);
  vaino.update();
  PVector[] pCorners = new PVector[]{new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y-vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y-vaino.offset.y))};
  
  for (Block b : obstacles){
    for (int pointIndex=0; pointIndex<=b.edges.length; pointIndex++){
      PVector[] side = new PVector[]{b.edges[(pointIndex)%b.edges.length],b.edges[(pointIndex+1)%b.edges.length]};
      stroke(255);
      //line(side[0].x,side[0].y,side[1].x,side[1].y);
      
      for (int i = 0; i < pCorners.length; i++){
         PVector[] beam = new PVector[]{pCorners[i],PVector.sub(pCorners[i],vaino.vel)};
         //line(beam[0].x,beam[0].y,beam[1].x+100*(beam[1].x-beam[0].x),beam[1].y+100*(beam[1].y-beam[0].y));
         
         float intersectX;
         float intersectY;
         
         if(beam[0].x==beam[1].x){
           if (side[0].x==side[1].x){
             if (beam[0].x==side[0].x){
             }
             continue;
           }else{
             intersectX = beam[0].x;
             
             if( (side[0].x <= intersectX && side[1].x >= intersectX) || (side[0].x >= intersectX && side[1].x <= intersectX) ){
               
               intersectY = intersectX * (side[1].y-side[0].y)/(side[1].x-side[0].x) + (side[0].y*side[1].x-side[1].y*side[0].x)/(side[1].x-side[0].x);
               if( (beam[0].y <= intersectY && beam[1].y >= intersectY) || (beam[0].y >= intersectY && beam[1].y <= intersectY) ){
               
                   if (b.type == 0){
                     
                     collisions.add(new float[]{new PVector(intersectX,intersectY).sub(beam[0]).mag()/vaino.vel.mag(),PVector.sub(side[1],side[0]).heading()});
                     
                   }else if (b.type==1){
                     reset();

                   }else if (b.type==2){
                     levelup();
                   }
                 
               }else{
                 continue;
               }
               
             }else{
               continue;
             }
             
             
           }
         } else if (side[0].x==side[1].x){
           intersectX = side[0].x;
             
             if( (beam[0].x <= intersectX && beam[1].x >= intersectX) || (beam[0].x >= intersectX && beam[1].x <= intersectX) ){
               
               intersectY = intersectX * (beam[1].y-beam[0].y)/(beam[1].x-beam[0].x) + (beam[0].y*beam[1].x-beam[1].y*beam[0].x)/(beam[1].x-beam[0].x);
               if( (side[0].y <= intersectY && side[1].y >= intersectY) || (side[0].y >= intersectY && side[1].y <= intersectY) ){
               
                   if (b.type == 0){
                     
                     collisions.add(new float[]{new PVector(intersectX,intersectY).sub(beam[0]).mag()/vaino.vel.mag(),PVector.sub(side[1],side[0]).heading()});
                     
                   }else if (b.type==1){
                     reset();

                   }else if (b.type==2){
                     levelup();
                   }
                 
               }else{
                 continue;
               }
               
             }else{
               continue;
             }
           
         } else if (beam[0].y==beam[1].y && side[0].y==side[1].y){
             if (beam[0].y==side[0].y){
             }
           continue;
         } else{
           intersectX = ( (side[0].y*side[1].x-side[1].y*side[0].x)/(side[1].x-side[0].x) - (beam[0].y*beam[1].x-beam[1].y*beam[0].x)/(beam[1].x-beam[0].x) ) / ( (beam[1].y-beam[0].y)/(beam[1].x-beam[0].x) - (side[1].y-side[0].y)/(side[1].x-side[0].x) );
             if( (beam[0].x <= intersectX && beam[1].x >= intersectX) || (beam[0].x >= intersectX && beam[1].x <= intersectX) ){
               if( (side[0].x <= intersectX && side[1].x >= intersectX) || (side[0].x >= intersectX && side[1].x <= intersectX) ){
               intersectY = intersectX * (beam[1].y-beam[0].y)/(beam[1].x-beam[0].x) + (beam[0].y*beam[1].x-beam[1].y*beam[0].x)/(beam[1].x-beam[0].x);
               
                   if (b.type == 0){
                     
                     collisions.add(new float[]{new PVector(intersectX,intersectY).sub(beam[0]).mag()/vaino.vel.mag(),PVector.sub(side[1],side[0]).heading()});
                     
                   }else if (b.type==1){
                     reset();

                     
                   }else if (b.type==2){
                     levelup();
                   }
               
               }else{
                continue; 
               }
             }else{
              continue; 
             }
       }
         

      }
      }

      }
      if (collisions.size()>0){
      Collections.sort(collisions, (arr1, arr2) -> Float.compare(abs(arr1[1]-PI),abs(arr2[1]-PI)));
      Collections.sort(collisions, (arr2, arr1) -> Float.compare(arr1[0],arr2[0]));
    //  for (float[] values:collisions){
      //  print(values[0]+","+values[1]+"   ");
     // }
      //print(vaino.vel.heading());
      //println();
      (vaino.pos.sub(PVector.mult(vaino.vel, collisions.get(0)[0]))).sub(vaino.vel.copy().normalize().mult(0.25));
      if (PI/2<collisions.get(0)[1] && collisions.get(0)[1]<3*PI/2){
        if (collisions.get(0)[1]==PI){

          vaino.accelerate(gravity.copy().mult(-1));
          vaino.vel=new PVector(vaino.vel.x,0);
        }else{
          vaino.accelerate(new PVector(gravity.x*(cos(collisions.get(0)[1])*sin(collisions.get(0)[1])),gravity.y*(cos(collisions.get(0)[1])*cos(collisions.get(0)[1]))));
          vaino.vel.sub(new PVector(0,vaino.vel.copy().rotate(-1*collisions.get(0)[1]).y).rotate(collisions.get(0)[1]));
        }
      }else{
          vaino.vel.sub(new PVector(0,vaino.vel.copy().rotate(-1*collisions.get(0)[1]).y).rotate(collisions.get(0)[1]));
      }
      
      }
      
}
