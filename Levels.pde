class Levels{
  
  ArrayList<Block> obstacles = new ArrayList<Block>();
  ArrayList<Text> textBoxes = new ArrayList<Text>();
  PVector gravity;
  PVector startPosition;
  float jump;
  float walk;
  PImage backdrop;
  String PlayerFolder;
  
  String track;
  
  String[] lines;
  
  Levels(String file){
      lines  = loadStrings(file);
      backdrop = loadImage(lines[0]);
      track= lines[1];
      startPosition = new PVector(Float.parseFloat(lines[2]),Float.parseFloat(lines[3]));
      gravity = new PVector(Float.parseFloat(lines[4]),Float.parseFloat(lines[5]));
      jump = Float.parseFloat(lines[6]);
      walk = Float.parseFloat(lines[7]);
      PlayerFolder = lines[8];
      reset();


  }
  
  void reset(){
    obstacles.clear();
    textBoxes.clear();
          int index = 9;
      while (index<lines.length){
        if(lines[index].charAt(0)=='T'){
          int textX=Integer.parseInt(lines[index+1]);
          int textY=Integer.parseInt(lines[index+2]);
          String t=lines[index+3];
          int size=Integer.parseInt(lines[index+4]);
          textBoxes.add(new Text(textX,textY,t,color(#F0BC11),size));
          index+=9;
        }
        
      else{
        PImage blockGraphics = loadImage(lines[index+1]);
        int pointCount = Integer.parseInt(lines[index+2]);
        PVector[] edges = new PVector[pointCount];
        for (int i = 0; i<pointCount;i++){
          float x = Float.parseFloat(lines[index+3+2*i]);
          float y = Float.parseFloat(lines[index+4+2*i]);
          edges[i]=new PVector(x,y);
        }
        if (lines[index].charAt(0)=='O'){
          if (lines[index].length()>1 && lines[index].charAt(1)=='M'){
            PVector velocity = new PVector(Float.parseFloat(lines[index+3+2*pointCount]),Float.parseFloat(lines[index+4+2*pointCount]));
            int extent = Integer.parseInt(lines[index+5+2*pointCount]);
            int type = Integer.parseInt(lines[index+6+2*pointCount]);
            obstacles.add(new MovingObstacle(edges,velocity, extent,type, blockGraphics));
          }else{
            obstacles.add(new Obstacle(edges, blockGraphics));
          }
        } else if (lines[index].charAt(0)=='B'){
           if (lines[index].length()>1 && lines[index].charAt(1)=='M'){
            PVector velocity = new PVector(Float.parseFloat(lines[index+3+2*pointCount]),Float.parseFloat(lines[index+4+2*pointCount]));
            int extent = Integer.parseInt(lines[index+5+2*pointCount]);
            int type = Integer.parseInt(lines[index+6+2*pointCount]);
            obstacles.add(new MovingBlock(edges,velocity, extent,type, blockGraphics));
           }else{
          obstacles.add(new Block(edges, blockGraphics));
           }
        } else if (lines[index].charAt(0)=='G'){
          obstacles.add(new Goal(edges, blockGraphics));
        }
        
        index+=7+2*pointCount;
      }
    }  
  }
  
  
}
