class Levels{
  
  ArrayList<Block> obstacles = new ArrayList<Block>();
  PVector gravity;
  PVector startPosition;
  float jump;
  float walk;
  color backdrop;
  
  Levels(String file){
    String[] lines  = loadStrings(file);
      backdrop = Integer.parseInt(lines[0]);
      startPosition = new PVector(Float.parseFloat(lines[1]),Float.parseFloat(lines[2]));
      gravity = new PVector(Float.parseFloat(lines[3]),Float.parseFloat(lines[4]));
      jump = Float.parseFloat(lines[5]);
      walk = Float.parseFloat(lines[6]);
      
      int index = 7;
      while (index<lines.length){
        int x = Integer.parseInt(lines[index+1]);
        int y = Integer.parseInt(lines[index+2]);
        int w = Integer.parseInt(lines[index+3]);
        int h = Integer.parseInt(lines[index+4]);
        
        if (lines[index].charAt(0)=='O'){
          obstacles.add(new Obstacle(x,y,w,h));
        } else if (lines[index].charAt(0)=='B'){
          obstacles.add(new Block(x,y,w,h));
        } else if (lines[index].charAt(0)=='G'){
          obstacles.add(new Goal(x,y,w,h));
        }
        index+=5;
      }

  }
  
  
}
