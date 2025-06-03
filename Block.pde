class Block {
 PVector[] edges;
 int type;
 
 Block(PVector[] edges){
   this.edges = edges;
   type = 0;
 }
  
  void display(){
    rectMode(CORNERS);
    strokeWeight(0);
    fill(0,0,255);
    rect(edges[0].x,edges[0].y,edges[2].x,edges[2].y);
  }
  
}
