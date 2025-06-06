class Obstacle extends Block{
  Obstacle(PVector[] edges, PImage graphics){
    super(edges, graphics);
    super.type = 1;
  }
  
  @Override
  void display(){
    imageMode(CENTER);
    image(graphics,center.x,center.y);
   // rectMode(CORNERS);
  //  strokeWeight(0);
  //  fill(255,0,0);
  //  rect(edges[0].x,edges[0].y,edges[2].x,edges[2].y);
  //      strokeWeight(5);
  //  circle(center.x,center.y,5);
  //  for (PVector buffer : buffered){
  //    circle(buffer.x,buffer.y,5); 
  //  }
    //strokeWeight(0);
  }
}
