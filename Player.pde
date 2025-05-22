class Player {
 PVector pos;
 PVector vel;
 PVector acc;
 
 Player(int x, int y){
  pos = new PVector(x, y);
  vel = new PVector(0,0);
  acc = new PVector(0,0);
 }
}
