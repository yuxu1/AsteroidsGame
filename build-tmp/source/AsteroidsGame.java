import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

SpaceShip rocket;
ArrayList<Star> stars;
ArrayList<Asteroids> rock;
public void setup()
{
  size(500, 500);
  rocket=new SpaceShip();
  stars=new ArrayList<Star>();
  for (int i=0; i<10; i++) {
    stars.add(new Star());
  }
  rock=new ArrayList<Asteroids>();
  for (int i=0; i<10; i++) {
    rock.add(new Asteroids());
  }
}
public void draw()
{
  background(0);
  rocket.move();
  rocket.show();
  for (int i=0; i<10; i++) {
    stars.get(i).show();
  }
  for (int i=0; i<rock.size (); i++) {
    if (dist(rocket.getX(), rocket.getY(), rock.get(i).getX(), rock.get(i).getY())>25) {
      rock.get(i).setCrash(false);
    } else {
      rock.get(i).setCrash(true);
    }
  }
  for (int i=0; i<rock.size (); i++) {
    if (i!=rock.size()) {
      if (rock.get(i).getCrash()==false) {
        rock.get(i).move();
        rock.get(i).show();
      } else {
        rocket.myColor=color(255, 0, 0);
        rock.remove(i);
        rocket.myColor=color(255);
        if (rock.size()<9) {
          rock.add(new Asteroids());
        }
      }
    }
  }
}
public void keyPressed()
{
  if (key==CODED && keyCode==LEFT) //Rotate Left
  {
    rocket.rotate(-5);
  } 
  if (key==CODED && keyCode==RIGHT) //Rotate Right
  {
    rocket.rotate(5);
  } 
  if (key==CODED && keyCode==UP) //accelerate forward
  {
    rocket.accelerate(0.1f);
  }
  if (key==CODED && keyCode==DOWN) //accelerate backward
  {
    rocket.accelerate(-0.1f);
  }
  if (keyPressed==true && key==' ')//hyperspace
  {
    rocket.setX((int)(Math.random()*height));
    rocket.setY((int)(Math.random()*height));
    rocket.myDirectionX=0;
    rocket.myDirectionY=0;
  }
}
class SpaceShip extends Floater
{
  public SpaceShip()
  {
    corners = 3;
    xCorners = new int [corners];
    yCorners = new int [corners];
    xCorners[0] = 6;
    xCorners[1] = -8;
    xCorners[2] = -8;
    yCorners[0] = 0;
    yCorners[1] = 10;
    yCorners[2] = -10;
    myColor = 255;
    myColor= color(255);
    myCenterX=height/2;
    myCenterY=height/2;
    myDirectionX=5;
    myDirectionY=5;
    myPointDirection=0;
  }
  public void setX(int x) {
    myCenterX=x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY=y;
  }
  public int getY() {
    return (int) myCenterY;
  }
  public void setDirectionX(double x) {
    myDirectionX=x;
  }
  public double getDirectionX() {
    return (double) myDirectionX;
  }
  public void setDirectionY(double y) {
    myDirectionY =y;
  }
  public double getDirectionY() {
    return (double) myDirectionY;
  }
  public void setPointDirection(int degrees) {
    myPointDirection=degrees;
  }
  public double getPointDirection() {
    return (int) myPointDirection;
  }
}
class Star
{
  private int starX, starY;
  public Star()
  {
    starX=(int)(Math.random()*height);
    starY=(int)(Math.random()*height);
  }
  public void show()
  {
    fill(255);
    noStroke();
    ellipse(starX, starY, 5, 5);
  }
}
class Asteroids extends Floater
{
  private int rotationSpeed;
  private boolean crash;
  public Asteroids()
  {
    corners=4;
    xCorners = new int [corners];
    yCorners = new int [corners];
    xCorners[0]=-18;
    yCorners[0]=10;
    xCorners[1]=0;
    yCorners[1]=13;
    xCorners[2]=6;
    yCorners[2]=-5;
    xCorners[3]=-7;
    yCorners[3]=-8;
    myColor= color(100, 0, 150);
    myCenterX=((int)(Math.random())*height);
    myCenterY=(int)(Math.random()*height);
    myDirectionX=(int)(Math.random()*10)-5;
    myDirectionY=(int)(Math.random()*10)-5;
    myPointDirection=(int)(Math.random()*180);
    rotationSpeed=(int)(Math.random()*10)-5;
    crash=false;
  }
  public void move()
  {
    rotate(rotationSpeed);
    frameRate(30);
    super.move();
  }
  public void setX(int x) {
    myCenterX=x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY=y;
  }
  public int getY() {
    return (int) myCenterY;
  }
  public void setDirectionX(double x) {
    myDirectionX=x;
  }
  public double getDirectionX() {
    return (double) myDirectionX;
  }
  public void setDirectionY(double y) {
    myDirectionY =y;
  }
  public double getDirectionY() {
    return (double) myDirectionY;
  }
  public void setPointDirection(int degrees) {
    myPointDirection=degrees;
  }
  public double getPointDirection() {
    return (int) myPointDirection;
  }
  public void setCrash(boolean check) {
    crash=check;
  }
  public boolean getCrash() {
    return crash;
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class
{
  protected int corners; //the number of corners, a triangular floater has 3
  protected int[] xCorners;
  protected int[] yCorners;
  protected int myColor;
  protected double myCenterX, myCenterY; //holds center coordinates
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel
  protected double myPointDirection; //holds current direction the ship is pointing in degrees
  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();
  //Accelerates the floater in the direction it is pointing (myPointDirection)
  public void accelerate (double dAmount)
  {
    //convert the current direction the floater is pointing to radians
    double dRadians =myPointDirection*(Math.PI/180);
    //change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }
  public void rotate (int nDegreesOfRotation)
  {
    //rotates the floater by a given number of degrees
    myPointDirection+=nDegreesOfRotation;
  }
  public void move () //move the floater in the current direction of travel
  {
    //change the x and y coordinates by myDirectionX and myDirectionY
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
    //wrap around screen
    if (myCenterX >width)
    {
      myCenterX = 0;
    } else if (myCenterX<0)
    {
      myCenterX = width;
    }
    if (myCenterY >height)
    {
      myCenterY = 0;
    } else if (myCenterY < 0)
    {
      myCenterY = height;
    }
  }
  public void show () //Draws the floater at the current position
  {
    fill(myColor);
    stroke(myColor);
    //convert degrees to radians for sin and cos
    double dRadians = myPointDirection*(Math.PI/180);
    int xRotatedTranslated, yRotatedTranslated;
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      //rotate and translate the coordinates of the floater using current direction
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
      vertex(xRotatedTranslated, yRotatedTranslated);
    }
    endShape(CLOSE);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
