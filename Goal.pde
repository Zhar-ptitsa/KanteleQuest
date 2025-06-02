class Goal extends Block{
  
  Goal(int x, int y, int w, int h){
    super(x,y,w,h);
    super.type = 2;
  }
  
  @Override
  void display(){
    rectMode(CENTER);
    strokeWeight(0);
    fill(255,255,0);
    rect(coords[0],coords[1],2*coords[2],2*coords[3]);
  }
}
