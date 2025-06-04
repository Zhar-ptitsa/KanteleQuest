class Player {
 PVector pos;
 PVector vel;
 PVector acc;
 boolean[] directions= new boolean[]{false,false,false};
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
   if (mode == 0){
         strokeWeight(0);

     fill(0,255,0);
    rectMode(CORNERS);
    rect(pos.x-offset.x,pos.y-offset.y,pos.x+offset.x,pos.y+offset.y,5);
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
 
}
