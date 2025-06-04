class Obstacle extends Block{
  Obstacle(PVector[] edges){
    super(edges);
    super.type = 1;
  }
  
  @Override
  void display(){
    rectMode(CORNERS);
    strokeWeight(0);
    fill(255,0,0);
    rect(edges[0].x,edges[0].y,edges[2].x,edges[2].y);
  //      strokeWeight(5);
  //  circle(center.x,center.y,5);
  //  for (PVector buffer : buffered){
  //    circle(buffer.x,buffer.y,5); 
  //  }
    //strokeWeight(0);
  }
}
