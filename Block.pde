class Block {
 PVector[] edges;
 int[] coords;
 int type;
 
 Block(int x, int y, int w, int h){
   coords = new int[]{x,y,w,h};
   edges = new PVector[]{new PVector(x-w,y+h),new PVector(x+w,y+h),new PVector(x+w,y-h),new PVector(x-w,y-h)};
   type = 0;
 }
  
  void display(){
    rectMode(CENTER);
    strokeWeight(0);
    fill(0,0,255);
    rect(coords[0],coords[1],2*coords[2],2*coords[3]);
  }
  
}
