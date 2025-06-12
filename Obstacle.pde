class Obstacle extends Block{
  Obstacle(PVector[] edges, PImage graphics){
    super(edges, graphics);
    super.type = 1;
  }
  
  @Override
  void display(){
    imageMode(CENTER);
    image(graphics,center.x,center.y);
  }
}
