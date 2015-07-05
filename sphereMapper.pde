int sphereDensity;
int sphereSize;
PShape sphere;
PImage planetTexture;


OPC opc;


//----------------------------
void setup()
{
  size( 600, 600, P3D );
  
  //OPC stuff
  opc = new OPC(this, "127.0.0.1", 7890);
  
  
  //Texture stuff
  planetTexture = loadImage( "planet.jpg" );
  
  
  //Sphere stuff
  sphereDensity = 20;
  sphereDetail( sphereDensity );
  
  sphereSize = 200; 
  
  sphere = createShape( SPHERE, sphereSize );
  sphere.setTexture( planetTexture );
  
  
  //openGL stuff
  hint( ENABLE_DEPTH_MASK );
  
}


//----------------------------
void draw()
{
  lights();
  background( 0 );


  pushMatrix();
  
    translate( width/2, height/2 );
    drawSphere();
  
  popMatrix();
  
}


//----------------------------
void drawSphere(){
  noStroke();
  fill( 255 );
  shape( sphere );
}
