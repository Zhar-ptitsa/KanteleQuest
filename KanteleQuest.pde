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
 levels = new Levels[]{new Levels("levels/level1.txt"), new Levels("levels/level2.txt"), new Levels("levels/level3.txt"),new Levels("levels/level4.txt")};
  
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
  background(levels[levelIndex].backdrop);
 vaino.accelerate(gravity);
 

 for (Block s : obstacles){
  s.display(); 
 }
 try{
  moveCharacter();
 }catch(Exception e){
   //array changed --> reset or new level
 }
   vaino.display();




}

void keyPressed(){
     if (key==CODED){

      if (vaino.mode != 0 && keyCode==UP && !vaino.directions[0]){
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
        }else if (vaino.vel.y<0){
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

void reset() throws Exception{
  levels[levelIndex].reset();
  vaino.display();
  vaino.pos= startPosition.copy();
  vaino.vel= new PVector(0,0);
  vaino.acc= new PVector(0,0);
  throw new Exception("ARRAY CHANGED");
}

void levelup() throws Exception{
  vaino.display();
  if (levelIndex<levels.length-1){
     levelIndex+=1;
     started = false;
     throw new Exception("beam me up");
  }else{
        noLoop();
    background(255);
  }
}

boolean parity(PVector[] vertices, PVector point){
 // line(point.x,point.y,0,0);
  
  int count = 0;
  
  for (int vertexIndex = 0; vertexIndex < vertices.length; vertexIndex++){
    PVector[] edge = new PVector[]{vertices[vertexIndex], vertices[(vertexIndex+1)%vertices.length]};
    
    float intersectX;
    float intersectY;
    
    if (point.x==0){
      if (edge[0].x==edge[1].x){
         if (edge[0].x==0){
           if ((edge[0].y<=point.y && edge[1].y>=point.y) || (edge[1].y<=point.y && edge[0].y>=point.y)){
             count ++;
           }
         }
        continue;
      }else if ((edge[0].x<=0 && edge[1].x>=0) || (edge[1].x<=0 && edge[0].x>=0)){
        intersectX = 0;
       intersectY = intersectX * (edge[1].y-edge[0].y)/(edge[1].x-edge[0].x) + (edge[0].y*edge[1].x-edge[1].y*edge[0].x)/(edge[1].x-edge[0].x);
               if( (point.y <= intersectY && point.y >= intersectY) || (point.y >= intersectY && point.y <= intersectY) ){
                   count++;
               }
             }
        
      continue;
    
  
    } else if (edge[0].x==edge[1].x){
           intersectX = edge[0].x;
             
             if( (point.x <= intersectX && 0 >= intersectX) || (point.x >= intersectX && 0 <= intersectX) ){
               
               intersectY = intersectX * (point.y)/(point.x);
               if( (edge[0].y <= intersectY && edge[1].y >= intersectY) || (edge[0].y >= intersectY && edge[1].y <= intersectY) ){
               
                   count++;
                 
               }
           
         }
    continue;
    
    
    } else if (point.y==0 && edge[0].y==edge[1].y){
             if (edge[0].y==0){
               if ((edge[0].x<=point.x && edge[1].x>=point.x) || (edge[1].x<=point.x && edge[0].x>=point.x)){
                 count ++;
               }
             }
           continue;
           
           
         } else{
           intersectX = ((edge[0].y*edge[1].x-edge[1].y*edge[0].x)/(edge[1].x-edge[0].x)) / ( (point.y)/(point.x) - (edge[1].y-edge[0].y)/(edge[1].x-edge[0].x) );
             if( (0 <= intersectX && point.x >= intersectX) || (0 >= intersectX && point.x <= intersectX) ){
               if( (edge[0].x <= intersectX && edge[1].x >= intersectX) || (edge[0].x >= intersectX && edge[1].x <= intersectX) ){
                 count++;               
                 }
             }
             continue;
       }
         
    
  }
  if (count%2==0){
    return false;
  }
  return true;
}






void moveCharacter() throws Exception{
 // println(vaino.modeBox);
//  stroke(255,0,0);
  for (int i = 0; i<4;i++){
//    strokeWeight(5);
 //   line(vaino.modeBox[i].x,vaino.modeBox[i].y,vaino.modeBox[(i+1)%4].x,vaino.modeBox[(i+1)%4].y);
  }
  
  
  ArrayList<float[]> collisions = new ArrayList<float[]>();
  strokeWeight(5);
  stroke(255);
//println(frameCount+": "+vaino.vel);
  PVector[] OldpCorners = new PVector[]{new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y-vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y-vaino.offset.y))};
    boolean insideMode = false;

  for (PVector corner : OldpCorners){
      if (parity(vaino.modeBox, corner)){
        insideMode = true;
      }
  }
      if (insideMode){
        
             //   println("check check");
         for (PVector vertex : vaino.modeBox){
           vertex.add(obstacles.get(vaino.modeIndex).velocity);
         }
        
        if (PI/2<vaino.modeHeading && vaino.modeHeading<3*PI/2){
        if (vaino.modeHeading==PI){

          vaino.accelerate(gravity.copy().mult(-1));
     //     println(vaino.acc+","+vaino.vel);
          if (vaino.vel.y>0){
            vaino.vel=new PVector(vaino.vel.x,0);
          }
        }else{
     //     println();
          vaino.accelerate(new PVector(gravity.x*(cos(vaino.modeHeading)*sin(vaino.modeHeading)),gravity.y*(cos(vaino.modeHeading)*cos(vaino.modeHeading))));
        if(vaino.vel.copy().rotate(-1*vaino.modeHeading).y<0) {
          vaino.vel.sub(new PVector(0,vaino.vel.copy().rotate(-1*vaino.modeHeading).y).rotate(vaino.modeHeading));
        }
        }
      }else{
                if(vaino.vel.copy().rotate(-1*vaino.modeHeading).y<0) {
          vaino.vel.sub(new PVector(0,vaino.vel.copy().rotate(-1*vaino.modeHeading).y).rotate(vaino.modeHeading));
                }
      }

      }else{
        vaino.mode = 0;
        vaino.modeBox = new PVector[]{new PVector(0,0), new PVector(0,0), new PVector(0,0), new PVector(0,0)};
        vaino.modeHeading = 0;
      }
  
  
  vaino.update();
  OldpCorners = new PVector[]{new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y-vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y-vaino.offset.y))};
  
  for (Block b : obstacles){
    boolean inside = false;
    for (PVector corner : OldpCorners){
      if (parity(b.buffered, corner)){
        inside = true;
      }
    }
    if (inside){
      vaino.pos.add(b.velocity);
    }
  }
  PVector[] pCorners = new PVector[]{new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y-vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y-vaino.offset.y))};

  
  
  for (int blockIndex = 0; blockIndex < obstacles.size(); blockIndex++){
    Block b = obstacles.get(blockIndex);
    
    
    for (int pointIndex=0; pointIndex<=b.edges.length; pointIndex++){
      PVector[] side = new PVector[]{b.edges[(pointIndex)%b.edges.length],b.edges[(pointIndex+1)%b.edges.length]};
      stroke(255);
      strokeWeight(1);
      line(side[0].x,side[0].y,side[1].x,side[1].y);
      strokeWeight(5);
      for (int i = 0; i < pCorners.length; i++){
         PVector[] beam = new PVector[]{pCorners[i],PVector.sub(OldpCorners[i],vaino.vel)};
      //   line(beam[0].x,beam[0].y,beam[1].x+100*(beam[1].x-beam[0].x),beam[1].y+100*(beam[1].y-beam[0].y));
         
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
                     
                     collisions.add(new float[]{new PVector(intersectX,intersectY).sub(beam[0]).mag()/vaino.vel.mag(),PVector.sub(side[1],side[0]).heading(),side[0].x,side[0].y,side[1].x,side[1].y, blockIndex});
                     
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
                     
                     collisions.add(new float[]{new PVector(intersectX,intersectY).sub(beam[0]).mag()/vaino.vel.mag(),PVector.sub(side[1],side[0]).heading(),side[0].x,side[0].y,side[1].x,side[1].y, blockIndex});
                     
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
                     
                     collisions.add(new float[]{new PVector(intersectX,intersectY).sub(beam[0]).mag()/vaino.vel.mag(),PVector.sub(side[1],side[0]).heading(),side[0].x,side[0].y,side[1].x,side[1].y, blockIndex});
                     
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
      (vaino.pos.sub(PVector.mult(vaino.vel, collisions.get(0)[0]))).sub(vaino.vel.copy().normalize().mult(0.5));

        PVector[] barrier = new PVector[]{new PVector(collisions.get(0)[2],collisions.get(0)[3]),new PVector(collisions.get(0)[4],collisions.get(0)[5])};
        
          PVector shifter = new PVector(collisions.get(0)[2]-collisions.get(0)[4],collisions.get(0)[3]-collisions.get(0)[5]).rotate(PI/2).normalize().mult(1);
       
        vaino.modeBox = new PVector[]{barrier[0].copy().sub(shifter),barrier[0].copy().add(shifter),barrier[1].copy().add(shifter),barrier[1].copy().sub(shifter)};
     //   for (PVector vert : vaino.modeBox){
     //    circle(vert.x,vert.y,5); 
     //   }
        vaino.modeHeading = collisions.get(0)[1];
        vaino.modeIndex = int(collisions.get(0)[6]);
       // println(collisions.get(0)[1]);
        if (collisions.get(0)[1]==PI){
          vaino.mode = 1;
        }else if(collisions.get(0)[1]>2*PI/5 && collisions.get(0)[1]<3*PI/5){
          vaino.mode = 2;
        }else if(collisions.get(0)[1]<-2*PI/5 && collisions.get(0)[1]>-3*PI/5){
          vaino.mode = 3;
        }
      }
      
}
