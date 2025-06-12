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
  }
  
}
