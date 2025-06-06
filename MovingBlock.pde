class MovingBlock extends Block{
  
  int extent;
  int type;
  int passed;
  PVector startCenter;
  PVector[] startEdges;
  PVector[] bufferedStart;
  MovingBlock(PVector[] edges,PVector velocity, int extent, int type, PImage graphics){
        super(edges, graphics);
        startCenter = center.copy();
        startEdges = new PVector[edges.length];
        bufferedStart  = new PVector[edges.length];
        for (int i = 0; i<edges.length;i++){
         startEdges[i]=edges[i].copy();
         bufferedStart[i]=super.buffered[i].copy();
        }
        this.velocity=velocity;
        this.extent=extent;
        this.type = type;
  }
  
  @Override
    void display(){
      if (passed >= 0 && passed<extent){
        for (int i = 0; i<edges.length;i++){
          edges[i].add(velocity);
          buffered[i].add(velocity);
          
        }
                  center.add(velocity);

        passed++;
      }else{
        if (type==0){
          velocity = velocity.mult(-1);
                  passed = 0;

        }else if (type==1){
          for (int i = 0; i<startEdges.length;i++){
             edges[i]=startEdges[i].copy();
             buffered[i]=bufferedStart[i].copy();
             passed = 0;

          }
                       center = startCenter.copy();

        }else if (type==2){
          velocity=new PVector(0,0);
        }
      }
      
      super.display();
  }
}
