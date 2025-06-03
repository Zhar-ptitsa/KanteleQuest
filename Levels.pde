class Levels{
  
  ArrayList<Block> obstacles = new ArrayList<Block>();
  PVector gravity;
  PVector startPosition;
  float jump;
  float walk;
  color backdrop;
  
  String[] lines;
  
  Levels(String file){
      lines  = loadStrings(file);
      backdrop = Integer.parseInt(lines[0]);
      startPosition = new PVector(Float.parseFloat(lines[1]),Float.parseFloat(lines[2]));
      gravity = new PVector(Float.parseFloat(lines[3]),Float.parseFloat(lines[4]));
      jump = Float.parseFloat(lines[5]);
      walk = Float.parseFloat(lines[6]);
      reset();


  }
  
  void reset(){
    obstacles.clear();
          int index = 7;
      while (index<lines.length){
        int pointCount = Integer.parseInt(lines[index+1]);
        PVector[] edges = new PVector[pointCount];
        for (int i = 0; i<pointCount;i++){
          float x = Float.parseFloat(lines[index+2+2*i]);
          float y = Float.parseFloat(lines[index+3+2*i]);
          edges[i]=new PVector(x,y);
        }
        if (lines[index].charAt(0)=='O'){
          if (lines[index].length()>1 && lines[index].charAt(1)=='M'){
            PVector velocity = new PVector(Float.parseFloat(lines[index+2+2*pointCount]),Float.parseFloat(lines[index+3+2*pointCount]));
            int extent = Integer.parseInt(lines[index+4+2*pointCount]);
            int type = Integer.parseInt(lines[index+5+2*pointCount]);
            obstacles.add(new MovingObstacle(edges,velocity, extent,type));
          }else{
            obstacles.add(new Obstacle(edges));
          }
        } else if (lines[index].charAt(0)=='B'){
           if (lines[index].length()>1 && lines[index].charAt(1)=='M'){
            PVector velocity = new PVector(Float.parseFloat(lines[index+2+2*pointCount]),Float.parseFloat(lines[index+3+2*pointCount]));
            int extent = Integer.parseInt(lines[index+4+2*pointCount]);
            int type = Integer.parseInt(lines[index+5+2*pointCount]);
            obstacles.add(new MovingBlock(edges,velocity, extent,type));
           }else{
          obstacles.add(new Block(edges));
           }
        } else if (lines[index].charAt(0)=='G'){
          obstacles.add(new Goal(edges));
        }
        index+=6+2*pointCount;
      }
  }
  
  
}
