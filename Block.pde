class Block {
  PVector velocity;
 PVector[] edges;
 PVector[] buffered;
 PVector center;
 int type;
 PImage graphics;
 
 Block(PVector[] edges, PImage graphics){
   this.graphics = graphics;
   this.edges = edges;
   type = 0;
   velocity = new PVector(0,0);
   center = new PVector(0,0);
   for (PVector edge : edges){
     center.add(edge); 
   }
   center.div(edges.length);
   buffered = new PVector[edges.length];
   for (int i = 0; i<edges.length; i++){
     buffered[i] = edges[i].copy().add((PVector.sub(edges[i], center)).normalize().mult(3));
   }
 }
  
  void display(){
    imageMode(CENTER);
    image(graphics,center.x,center.y);
   // rectMode(CORNERS);
  //  strokeWeight(0);
  //  fill(0,0,255);
 //   rect(edges[0].x,edges[0].y,edges[2].x,edges[2].y);
 //   strokeWeight(5);
  //  circle(center.x,center.y,5);
 //   for (PVector buffer : buffered){
  //    circle(buffer.x,buffer.y,5); 
  //  }
    //strokeWeight(0);
  }
  
}
