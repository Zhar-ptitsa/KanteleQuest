class Button{
  int x1;
  int y1;
  int x2;
  int y2;
  int w;
  int h;
  color col;
  color border;
  color hover;
  String text;
  
  Button(int x,int y,int w,int h,String str){
    x1=x;
    y1=y;
    x2=x+w;
    y2=y+h;
    this.w=w;
    this.h=h;
    col=color(#F0CB0F);
    border=color(#867113);
    hover=color(#FCEA96);
    text=str;
  }
  
  void displayButton(){
    rectMode(CORNER);
    stroke(border);
    fill(col);
    strokeWeight(3);
    rect(x1,y1,w,h);
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(35);
    text(text,x1+w/2,y1+h/2);
  }
  void displayHover(){
    stroke(border);
    fill(hover);
    strokeWeight(3);
    rect(x1,y1,w,h);
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(35);
    text(text,x1+w/2,y1+h/2);
  }
  
  boolean overButton(){
    if(mouseX>=x1&&mouseX<=x2&&mouseY>=y1&&mouseY<=y2){
      return true;
    }
    return false;
  }
  
}
