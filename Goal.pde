class Goal extends Block{
  
  Goal(PVector[] edges, PImage graphics){
    super(edges, graphics);
    super.type = 2;
  }
  
  @Override
  void display(){
    imageMode(CENTER);
    image(graphics,center.x,center.y);
  }
}
