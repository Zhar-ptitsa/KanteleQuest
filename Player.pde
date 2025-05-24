class Player {
 PVector pos;
 PVector vel;
 PVector acc;
 
 PVector oldpos;
 
 int size;
 int mode;
 
 PVector action;
 
 Player(int x, int y){
  pos = new PVector(x, y);
  oldpos = pos;
  vel = new PVector(0,0);
  acc = new PVector(0,0);
  size = 10;
  mode = 0;
  action = new PVector(0,0);
 }
 
 void display(){
   if (mode == 0){
         strokeWeight(0);

     fill(0,255,0);
    rectMode(CENTER);
    rect(pos.x,pos.y,size,size*2,5);
   }
 }
 
 void update(){
   oldpos = pos.copy();
   pos.add(vel);
   vel.add(acc);
   acc = new PVector(0,0);
 }
   
 
 void characterMotion(PVector newInput){
   if (!action.equals(newInput)){
    vel.sub(action);
    action = newInput;
    vel.add(action);
   }
 }
 
 void accelerate(PVector newInput){
    acc.add(newInput); 
 }
 
}
