class Player {
 PVector pos;
 PVector vel;
 PVector acc;
 boolean[] directions= new boolean[]{false,false,false};
 
 
 PImage air;
 PImage ground;
 PImage left;
 PImage right;
 
 
 PVector oldpos;
 PVector offset;
 PVector[] modeBox;
 float modeHeading;
 int modeIndex;
 float jump;
 float walk;

 int size;
 int mode;
 
 
 Player(float x, float y, float j, float w){
  pos = new PVector(x, y);
  oldpos = pos;
  vel = new PVector(0,0);
  acc = new PVector(0,0);
  size = 10;
  offset = new PVector(size,size*1.5);
  mode = 0;
  jump = j;
  walk = w;
  modeBox = new PVector[]{new PVector(0,0), new PVector(0,0), new PVector(0,0), new PVector(0,0)};
  modeHeading = 0;
  modeIndex = 0;
 }
 
 void display(){
   //println(mode);
    // strokeWeight(0);
    // fill(75*mode,255-75*mode,75*mode);
   // rectMode(CORNERS);
   // rect(pos.x-offset.x,pos.y-offset.y,pos.x+offset.x,pos.y+offset.y,5);
   imageMode(CENTER);
   if (mode == 0){
     image(air,pos.x,pos.y);
   }else if (mode == 1){
     image(ground,pos.x,pos.y);
   }else if (mode == 3){
    image(right,pos.x,pos.y); 
   }else if (mode == 2){
     image(left,pos.x,pos.y);
   }

 }
 
 void update(){
   vel.add(acc);
   pos.add(vel);
   acc = new PVector(0,0);
 }
   
 
 
 void accelerate(PVector newInput){
    acc.add(newInput); 
 }
 
 void loadFolder(String location){
   air = loadImage(location+"/air.png");
   ground = loadImage(location+"/ground.png");
   left = loadImage(location+"/left.png");
   right = loadImage(location+"/right.png");

 }
 
}
