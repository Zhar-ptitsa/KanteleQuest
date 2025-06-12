import java.util.Collections;
import beads.*;

Player vaino;
PVector gravity;
PVector startPosition;
ArrayList<Block> obstacles;
boolean started;
int levelIndex;
Levels[] levels;

SamplePlayer mainTrack;
Gain mainGain;

AudioContext audioCon;

PFont mainFont;

ArrayList<Button> levelSelectButtons;
ArrayList<Button> pauseButtons;
ArrayList<Button> titleScreenButtons;
Button winToTitle;

boolean paused;
boolean levelSelectScreen;
boolean titleScreen;
boolean youWin;

void setup(){
  frameRate(60);
  size(1080,720);
  JavaSoundAudioIO jsaio = new JavaSoundAudioIO(512);
  //jsaio.printMixerInfo();
  jsaio.selectMixer(1);
  //audioCon = new AudioContext(jsaio);    //FOR LINUX
  audioCon  = AudioContext.getDefaultContext();  //FOR WINDOWS
  mainGain = new Gain(2, 0.05);

  mainFont = createFont(sketchPath("Gabriola.ttf"),128);
  started = false;
  levelIndex = 0;
  levels = new Levels[]{new Levels("levels/training1.txt"),new Levels("levels/training2.txt"),new Levels("levels/training3.txt"),new Levels("levels/training4.txt"),new Levels("levels/training5.txt"), new Levels("levels/Ilmarinen1.txt")};


  paused=false;
  levelSelectScreen=false;
  titleScreen=true;
  youWin=false;

  levelSelectButtons=new ArrayList<Button>();
  int x=100;
  int y=100;
  int num=1;
  for(int r=0;r<4;r++){
    for(int c=0;c<5;c++){
      Button but=new Button(x,y,80,80,String.valueOf(num));
      levelSelectButtons.add(but);
      num++;
      x+=200;
    }
    x=100;
    y+=150;
  }
  Button title=new Button(20,20,60,60,"Title");
  levelSelectButtons.add(title);

  pauseButtons=new ArrayList<Button>();
  Button levelSelect=new Button(450,height/2,200,80,"Level Select");
  pauseButtons.add(levelSelect);

  titleScreenButtons=new ArrayList<Button>();
  Button levelSelectTitle=new Button(width/2+50,height*3/5,300,100,"Start");
  titleScreenButtons.add(levelSelectTitle);
  Button settings=new Button(width/2-350,height*3/5,300,100,"Settings");
  titleScreenButtons.add(settings);

  winToTitle=new Button(450,height/2,200,80,"Back To Title");
}

void draw(){

  if(titleScreen){
    title();
  }
  else if(youWin){
    displayWin();
    if(winToTitle.overButton()){
      winToTitle.displayHover();
    }
  }
  else if(levelSelectScreen){
    levelSelect();
  }
  else if(paused){
    displayPause();
    for(int i=0;i<pauseButtons.size();i++){
      Button button=pauseButtons.get(i);
      button.displayButton();
      if(button.overButton()){
        button.displayHover();
      }
    }
  }

  else{
  if (frameCount == 1){
        delay(5000);
  }
  if (!started){
      //level data
  background(levels[levelIndex].backdrop);
  gravity = levels[levelIndex].gravity;
  obstacles = levels[levelIndex].obstacles;
  startPosition = levels[levelIndex].startPosition;
  float jump = levels[levelIndex].jump;
  float walk = levels[levelIndex].walk;

  vaino = new Player(startPosition.x,startPosition.y, jump, walk);
  vaino.loadFolder(levels[levelIndex].PlayerFolder);

  mainTrack = new SamplePlayer(audioCon, SampleManager.sample(sketchPath(levels[levelIndex].track)));
  mainTrack.setKillOnEnd(false);
  mainTrack.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  mainGain.addInput(mainTrack);
  audioCon.out.addInput(mainGain);
  audioCon.start();



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
     vaino.display();

 }catch(Exception e){
   //array changed --> reset or new level
 }

  }


  }

void displayPause(){
  rectMode(CORNER);
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

void levelSelect(){
  background(#FCDFBA);
  fill(0);
  textAlign(CENTER);
  textSize(60);
  text("LEVEL SELECT",width/2,60);
  for(int i=0;i<levelSelectButtons.size();i++){
    Button button=levelSelectButtons.get(i);
    button.displayButton();
    if(button.overButton()){
      button.displayHover();
    }
  }
}

void title(){
  background(#24ADFF);
  fill(0);
  textAlign(CENTER,CENTER);
  textSize(80);
  textFont(mainFont);
  text("KANTELE QUEST",width/2,height/4);
  for(int i=0;i<titleScreenButtons.size();i++){
    Button button=titleScreenButtons.get(i);
    button.displayButton();
    if(button.overButton()){
      button.displayHover();
    }
  }
}

void displayWin(){
  background(#24ADFF);
  fill(0);
  textAlign(CENTER,CENTER);
  textSize(80);
  text("YOU WIN!!!",width/2,height/4);
  winToTitle.displayButton();
}

void displaySettings(){
  ;
}

void keyPressed(){
  if(paused==false){
     if (key==CODED){
      if (started){
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
  }

  if(keyCode=='P'){
    if(!levelSelectScreen){
      if(paused==false){
        paused=true;
      }
      else{
        paused=false;
      }
    }
  }

  try{
    if(keyCode=='R'){
      reset();
    }
  }
  catch(Exception e){
    e.printStackTrace();
  }

}

void keyReleased(){
     if (key==CODED){
      if (started){
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
}


void mousePressed(){
  if(titleScreen){
    for(int i=0;i<titleScreenButtons.size();i++){
      Button button=titleScreenButtons.get(i);
      if(button.overButton()){
        if(button.text=="Start"){
          titleScreen=false;
          levelSelectScreen=true;
        }
        else if(button.text=="Settings"){
          displaySettings();
        }
      }
    }
  }
  else if(youWin){
    if(winToTitle.overButton()){
      youWin=false;
      titleScreen=true;
      started=false;
    }
  }
  else if(paused){
    for(int i=0;i<pauseButtons.size();i++){
      Button button=pauseButtons.get(i);
      if(button.overButton()){
        if(button.text=="Level Select"){
          levelSelectScreen=true;
          paused=false;
          started=false;
        }
      }
    }
  }
  else{
    for(int i=0;i<levelSelectButtons.size();i++){
      Button button=levelSelectButtons.get(i);
      if(button.overButton()){
        if(button.text=="Title"){
          titleScreen=true;
        }
        else{
          levelIndex=Integer.parseInt(button.text)-1;
        }
        levelSelectScreen=false;
      }
    }
  }
}


void reset() throws Exception{
  levels[levelIndex].reset();

  mainTrack.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
      mainTrack.setKillOnEnd(true);
    mainTrack.setToEnd();
    mainTrack = new SamplePlayer(audioCon, SampleManager.sample(sketchPath(levels[levelIndex].track)));
  mainTrack.setKillOnEnd(false);
  mainTrack.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  mainGain.addInput(mainTrack);
  audioCon.out.addInput(mainGain);

  vaino.pos= startPosition.copy();
  vaino.vel= new PVector(0,0);
  vaino.acc= new PVector(0,0);
  throw new Exception("ARRAY CHANGED");
}

void levelup() throws Exception{
    mainTrack.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
      mainTrack.setKillOnEnd(true);
    mainTrack.setToEnd();
  levels[levelIndex].reset();
  vaino.vel= new PVector(0,0);
  vaino.acc= new PVector(0,0);
  if (levelIndex<levels.length-1){
      vaino.display();
     levelIndex+=1;
     started = false;
  }else{
    youWin=true;
  }
       throw new Exception("beam me up");

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
        // vaino.pos.add(obstacles.get(vaino.modeIndex).velocity);
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
      if (b.type == 1){
        vaino.display();
        reset();
      }
    }
  }
  PVector[] pCorners = new PVector[]{new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y-vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x-vaino.offset.x),(vaino.pos.y+vaino.offset.y)),new PVector((vaino.pos.x+vaino.offset.x),(vaino.pos.y-vaino.offset.y))};



  for (int blockIndex = 0; blockIndex < obstacles.size(); blockIndex++){
    Block b = obstacles.get(blockIndex);


    for (int pointIndex=0; pointIndex<=b.edges.length; pointIndex++){
      PVector[] side = new PVector[]{b.edges[(pointIndex)%b.edges.length],b.edges[(pointIndex+1)%b.edges.length]};
      stroke(255);
      strokeWeight(1);
    //  line(side[0].x,side[0].y,side[1].x,side[1].y);
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
