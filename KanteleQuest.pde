int xSquares;
int ySquares;
final int SQUARE_SIZE=10;
PVector vel=new PVector(0,0);
Player p;
int frameSpd;
PVector gravity;
PVector upForce;
ArrayList<Button> levelSelectButtons;
ArrayList<Button> pauseButtons;
boolean paused;
boolean levelSelectScreen;

void setup(){
  rectMode(CORNER);
  size(1080,720);
  drawGrid();
  p=new Player();
  frameSpd=5;
  gravity=new PVector(0,0.009);
  upForce=new PVector(0,0);
  
  paused=false;
  levelSelectScreen=false;
  
  levelSelectButtons=new ArrayList<Button>();
  Button but=new Button(width/3,height/3,80,80,"hi");
  levelSelectButtons.add(but);
  
  Button levelSelect=new Button(450,height/2,200,80,"Level Select");
  pauseButtons=new ArrayList<Button>();
  pauseButtons.add(levelSelect);
}

void drawGrid(){
  rectMode(CORNER);
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
  if(levelSelectScreen){
    levelSelect();
  }
  else if(!paused){
    background(255);
    drawGrid();
    Block b=new Block(20,20,10,10);
    b.display();
    p.display();
    if(frameCount%frameSpd==0){
      p.updatePos();
      p.accelerate(gravity);
    }
  }
  if(paused){
    displayPause();
    for(int i=0;i<pauseButtons.size();i++){
      Button button=pauseButtons.get(i);
      button.displayButton();
      if(button.overButton()){
        button.displayHover();
      }
    }
  }
}

void displayPause(){
  rectMode(CORNER);
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
}

void levelSelect(){
  background(#FCDFBA);
  fill(0);
  textAlign(CENTER);
  textSize(40);
  text("LEVEL SELECT",width/2,50);
  for(int i=0;i<levelSelectButtons.size();i++){
    Button button=levelSelectButtons.get(i);
    button.displayButton();
    if(button.overButton()){
      button.displayHover();
    }
  }
}

void keyPressed(){
  if(keyCode=='P'){
    if(paused==false){
      paused=true;
    }
    else{
      paused=false;
    }
  }
  
  if(keyCode=='R'){
    setup();
  }
  
  if(key==CODED){
    if(keyCode==UP){
 //     upForce=new PVector(0,-0.01);
    //  p.accelerate(upForce);
    }
    if(keyCode==LEFT){
      vel=new PVector(-SQUARE_SIZE,0);
      p.updateVel(vel);
    }
    if(keyCode==RIGHT){
      vel=new PVector(SQUARE_SIZE,0);
      p.updateVel(vel);
    }
  }
}

void mousePressed(){
  if(paused){
    for(int i=0;i<pauseButtons.size();i++){
      Button button=pauseButtons.get(i);
      if(button.overButton()){
        if(button.text=="Level Select"){
          levelSelectScreen=true;
          paused=false;
        }
        else{
          background(180,0,0);
        }
      }
    }
  }
  else{
    for(int i=0;i<levelSelectButtons.size();i++){
      Button button=levelSelectButtons.get(i);
      if(button.overButton()){
        background(180,0,0);
      }
    }
  }
}
