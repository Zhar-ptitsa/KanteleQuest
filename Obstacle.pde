class Obstacle extends Block{
  Obstacle(int x, int y, int w, int h){
    super(x,y,w,h);
    super.type = 1;
  }
  
  @Override
  void display(){
    rectMode(CENTER);
    strokeWeight(0);
    fill(255,0,0);
    rect(coords[0],coords[1],2*coords[2],2*coords[3]);
  }
}
