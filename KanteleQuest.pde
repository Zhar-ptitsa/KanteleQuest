int xSquares;
int ySquares;
final int SQUARE_SIZE=10;
PVector vel=new PVector(0,0);
Player p;
int frameSpd;
PVector gravity;
PVector upForce;
ArrayList<Button> buttons;
ArrayList<Button> pauseButtons;
boolean paused;

void setup(){
  size(1080,720);
  drawGrid();
  p=new Player();
  frameSpd=5;
  gravity=new PVector(0,0.009);
  upForce=new PVector(0,0);
  buttons=new ArrayList<Button>();
  Button but=new Button(width/2,height/2,80,80,"hi");
  buttons.add(but);
  paused=false;
  Button levelSelect=new Button(width/2,height/2,200,80,"Level Select");
  pauseButtons=new ArrayList<Button>();
  pauseButtons.add(levelSelect);
}

void drawGrid(){
  xSquares=width/SQUARE_SIZE;
  ySquares=height/SQUARE_SIZE;
  fill(255);
  stroke(0);
  strokeWeight(1);
  int x=0;
  int y=0;
  for(int r=0;r<ySquares;r++){
    for(int c=0;c<xSquares;c++){
      square(x,y,SQUARE_SIZE);
      x+=SQUARE_SIZE;
    }
    x=0;
    y+=SQUARE_SIZE;
  }
}

void draw(){
  background(255);
  drawGrid();
  Block b=new Block(20*SQUARE_SIZE,60*SQUARE_SIZE,70*SQUARE_SIZE,10*SQUARE_SIZE,#199017);
  b.display();
  p.display();
  if(frameCount%frameSpd==0){
    p.updatePos();
    p.accelerate(gravity);
  }
  for(int i=0;i<buttons.size();i++){
    Button button=buttons.get(i);
    button.displayButton();
    if(button.overButton()){
      button.displayHover();
    }
  }
}

void displayPause(){
  stroke(#233CD8);
  strokeWeight(3);
  fill(#0D98FF);
  rect(width/4,height/4,width/2,height/2);
  fill(0);
  textAlign(CENTER);
  textSize(40);
  text("Paused",width/2,height/3);
  textSize(20);
  text("Press 'P' To Unpause",width/2,height*5/13);
  for(int i=0;i<pauseButtons.size();i++){
    Button button=pauseButtons.get(i);
    button.displayButton();
  }
}

void keyPressed(){
  if(keyCode=='P'){
    if(looping){
      paused=true;
      noLoop();
      displayPause();
    }
    else{
      paused=false;
      loop();
    }
  }
  
  if(keyCode=='R'){
    setup();
  }
  
  if(key==CODED){
    if(keyCode==UP){
      upForce=new PVector(0,-0.01);
      p.accelerate(upForce);
    }
    if(keyCode==LEFT){
      vel=new PVector(-SQUARE_SIZE,0);
 //     p.updateVel(vel);
    }
    if(keyCode==RIGHT){
      vel=new PVector(SQUARE_SIZE,0);
  //    p.updateVel(vel);
    }
  }
}

void mousePressed(){
  if(paused){
    for(int i=0;i<pauseButtons.size();i++){
      Button button=pauseButtons.get(i);
      if(button.overButton()){
        background(180,0,0);
        noLoop();
      }
    }
  }
  else{
    for(int i=0;i<buttons.size();i++){
      Button button=buttons.get(i);
      if(button.overButton()){
        background(180,0,0);
        noLoop();
      }
    }
  }
}
