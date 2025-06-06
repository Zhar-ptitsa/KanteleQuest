class Goal extends Block{
  
  Goal(PVector[] edges, PImage graphics){
    super(edges, graphics);
    super.type = 2;
  }
  
  @Override
  void display(){
    imageMode(CENTER);
    image(graphics,center.x,center.y);
  //  rectMode(CORNERS);
 //   strokeWeight(0);
 //   fill(255,255,0);
 //   rect(edges[0].x,edges[0].y,edges[2].x,edges[2].y);
  }
}
