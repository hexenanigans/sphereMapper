int sphereDensity;
int sphereSize;
PShape sphere;
PImage planetTexture;

ArrayList<Vertex> sphereVecs = new ArrayList<Vertex>();

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
  sphereDensity = 200;
  sphereDetail( sphereDensity );
  sphereSize = 200; 
  sphere = createShape( SPHERE, sphereSize );
  sphere.setTexture( planetTexture );
  
  println( "number of vertices = " + sphere.getVertexCount() );
  for( int i = 0; i < sphere.getVertexCount(); i++ )
  {
    //where are tex coords?
    sphereVecs.add( new Vertex( sphere.getVertex(i).x, sphere.getVertex(i).y, sphere.getVertex(i).z ) );
  }  
  
  //openGL stuff
  hint( ENABLE_DEPTH_MASK );
    
    
    
  //set up drawing
  noStroke();
  fill( 255 );
  stroke( 255, 200 );
  strokeWeight( 5 );

}


//----------------------------
void draw()
{
  lights();
  background( 0 );

  pushMatrix();

    translate( width/2, height/2 );
    rotate( (float)millis()/1000, 0.9, 0.5, 0.2 );
    drawSphere();
  
  popMatrix();
}


//----------------------------
void drawSphere()
{
  for( int i = 0; i < sphereVecs.size(); i++ )
  {
    point( sphereVecs.get(i).x , sphereVecs.get(i).y, sphereVecs.get(i).z ); 
  }
}