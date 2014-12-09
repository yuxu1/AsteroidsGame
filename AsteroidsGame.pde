SpaceShip rocket=new SpaceShip();
ArrayList<Star> stars;
ArrayList<Asteroid> rock;
ArrayList<bullet> bomb;
public void setup()
{
  size(500, 500, P2D);
  stars=new ArrayList<Star>();
  bomb=new ArrayList<bullet>();
  for (int i=0; i<100; i++) {
    stars.add(new Star());
  }
  rock=new ArrayList<Asteroid>();
  for (int i=0; i<10; i++) {
    rock.add(new Asteroid());
  }
}
public void draw()
{
  background(0);
  for (int i=0; i<100; i++) {
    stars.get(i).show();
  }
  for (int i=0; i<rock.size (); i++) {
    if (dist(rocket.getX(), rocket.getY(), rock.get(i).getX(), rock.get(i).getY())>30) {
      rock.get(i).setCrash(false);
    } else {
      rock.get(i).setCrash(true);
    }
  }
  for (int i=0; i<rock.size (); i++)
  {
    for (int j=0; j<bomb.size (); j++)
    {
      if (j!=bomb.size()) {
        if (dist(rock.get(i).getX(), rock.get(i).getY(), bomb.get(j).getX(), bomb.get(j).getY())<13) {
          rock.remove(i);
          bomb.remove(j);
        }
      }
    }
  }
  for (int i=0; i<rock.size (); i++) {
    if (i!=rock.size()) {
      if (rock.get(i).getCrash()==false) {
        rock.get(i).move();
        rock.get(i).show();
      } else {
        rock.remove(i);
        if (rock.size()<45) {
          rock.add(new Asteroid());
        }
      }
    }
  }
  for (int j=0; j<bomb.size (); j++) {
    if (j!=bomb.size()) {
      bomb.get(j).move();
      bomb.get(j).show();
    }
    if (bomb.get(j).getX()>=height || bomb.get(j).getX()<=0 || bomb.get(j).getY()>height || bomb.get(j).getY()<0) {
      bomb.remove(j);
    }
  }
  for (int j=0; j<bomb.size (); j++) {
    if (bomb.get(j).getCrash()==true) {
      bomb.remove(j);
    }
  }
  rocket.move();
  rocket.show();
}
public void keyPressed()
{
  if (key==CODED && keyCode==LEFT) {
    rocket.rotate(-5);
  } //Rotate Left
  if (key==CODED && keyCode==RIGHT) {
    rocket.rotate(5);
  } //Rotate Right
  if (key==CODED && keyCode==UP) {
    rocket.accelerate(0.05);
  }//accelerate forward
  if (key==CODED && keyCode==DOWN) {
    rocket.accelerate(-0.05);
  }//accelerate backward
  if (keyPressed==true && key==' ') {
    rocket.setX(350);
    rocket.setY(350);
    rocket.setDirectionX(0);
    rocket.setDirectionY(0);
    rocket.accelerate(0);
    rocket.setPointDirection(0);
  }//hyperspace
  if (keyPressed==true && key=='s') {
    bomb.add(new bullet(rocket));
    for (int i=0; i<bomb.size (); i++) {
      bomb.get(i).move();
      bomb.get(i).show();
    }
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
    xCorners[1] = -12;
    xCorners[2] = -12;
    yCorners[0] = 0;
    yCorners[1] = 9;
    yCorners[2] = -9;
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
    ellipse(starX, starY, 2, 2);
  }
}
class Asteroid extends Floater
{
  private int rotationSpeed;
  private boolean crash;
  public Asteroid()
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
    myCenterX=(int)(0);
    myCenterY=(int)(Math.random()*height);
    myDirectionX=(int)(Math.random()*10)-5;
    myDirectionY=(int)(Math.random()*10)-5;
    if (myDirectionX==0 && myDirectionY==0) {
      myDirectionX=1;
      myDirectionY=2;
    }
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
class bullet extends Floater
{
  private boolean crash;
  public bullet(SpaceShip theShip)
  {
    myColor=color(255,249,57);
    myCenterX=theShip.getX();
    myCenterY=theShip.getY();
    myPointDirection=theShip.getPointDirection();
    double dRadians=myPointDirection*(Math.PI/180);
    myDirectionX=5*(Math.cos(dRadians))+theShip.getDirectionX();
    myDirectionY=5*(Math.sin(dRadians))+theShip.getDirectionY();
    crash=false;
  }
  public void show()
  {
    noStroke();
    fill(myColor);
    ellipse((int) myCenterX, (int)myCenterY, 10, 8);
  }
  public void move()
  {
    myCenterX+=myDirectionX;
    myCenterY+=myDirectionY;
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
