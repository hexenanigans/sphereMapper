int texSphereDensity = 80;
int ledSphereDensity = 22;
int sphereSize = 200;

PShape sphere;

//make this texture a syphon source
PImage planetTexture;

ArrayList<Vertex> texSphereVerts = new ArrayList<Vertex>();
ArrayList<Vertex> ledSphereVerts = new ArrayList<Vertex>(); 

OPC opc;


//----------------------------
void setup()
{
  size( 600, 600, P3D );
  
  //OPC stuff
  opc = new OPC(this, "127.0.0.1", 7890);
  
  
  //LED Sphere stuff
  // This will probably need to be manually specified verts or similar
  sphereDetail( ledSphereDensity );
  sphere = createShape( SPHERE, sphereSize );
  
  println( "number of LED vertices = " + sphere.getVertexCount() );
  for( int i = 0; i < sphere.getVertexCount(); i++ )
  {
    float x, y, z, u, v, nx, ny, nz;
    x = sphere.getVertex(i).x;
    y = sphere.getVertex(i).y;
    z = sphere.getVertex(i).z;
    //normals and UVs mightn't be needed
    u = sphere.getTextureU(i);
    v = sphere.getTextureV(i);
    nx = sphere.getNormalX(i);
    ny = sphere.getNormalY(i);
    nz = sphere.getNormalZ(i);
    ledSphereVerts.add( new Vertex( x, y, z, u, v, nx, ny, nz ) );
  }  
  
  
  
    
  //Texture stuff
  planetTexture = loadImage( "planet.jpg" );
  
  
   //Texture Sphere stuff
  sphereDetail( texSphereDensity );
  sphere = createShape( SPHERE, sphereSize );
  sphere.setTexture( planetTexture );
  
  println( "number of texture vertices = " + sphere.getVertexCount() );
  for( int i = 0; i < sphere.getVertexCount(); i++ )
  {
    float x, y, z, u, v, nx, ny, nz;
    x = sphere.getVertex(i).x;
    y = sphere.getVertex(i).y;
    z = sphere.getVertex(i).z;
    u = sphere.getTextureU(i);
    v = sphere.getTextureV(i);
    //normals mightn't be needed
    nx = sphere.getNormalX(i);
    ny = sphere.getNormalY(i);
    nz = sphere.getNormalZ(i);
    texSphereVerts.add( new Vertex( x, y, z, u, v, nx, ny, nz ) );
  }  
  
  

  //openGL stuff
  //hint( DISABLE_DEPTH_MASK );
  //hint( ENABLE_DEPTH_MASK );

  //set up drawing
  fill( 255 );
  stroke( 255, 200 );
  strokeWeight( 2 );

}


//----------------------------
void draw()
{
  //lights();
  noLights();
  background( 0 );

  /**********************************************************************************************
  *  The idea is to use the texture sphere (tSphere) as a way to find UVs.                      *
  *  Another sphere is created around it with vertices representing the positions               *
  *  of LEDs on the ball.  This second sphere can then rotate freely around the texture sphere. *
  *  Each vertex on the LED sphere can look for the closest vertex on the tSphere.              *
  *  The found vertices have associated UVs which can be used to look up the texture            *
  *  and assign a colour to the LED.                                                            *
  *  This completely decouples the texture mapping from the LED mapping.                        *
  ***********************************************************************************************/

  pushMatrix();
    
    translate( width/2, height/2 );
    rotateY( (float)millis()/4000 );
    
    drawTexSphere( true, true );
    
    //drawLedSphere( (float)millis()/1000 , 0.9, 0.5, 0.2 );
    //the above should be equivalant to this (but currently isn't):
    /*pushMatrix();
      rotate( radians( (float)millis()/100 ), 0.9, 0.5, 0.2 ); 
      drawLedSphere();
    popMatrix();*/

    // set true to pull colour from texture
    drawNearestVerts( true );
    
  popMatrix();
  
  update();
}



void update()
{
  //update all the things
  findNearestVerts(  (float)millis()/100 , 0.9, 0.5, 0.2 );
}





void findNearestVerts( float angle, float x, float y, float z )
{
  //This function finds the nearest tSphere vertices of all ledSphere vertices
  
  for( int i = 0; i < ledSphereVerts.size(); i++ )
  {
    int foundIndex = -1;
    
    float foundDistance = 1000.0;
    
    //rotate vertex as needed
    Vertex rotatedVertex = ledSphereVerts.get(i).rotate3d( angle, x, y, z );
    
    for( int j = 0; j < texSphereVerts.size(); j++ )
    {
      float currentDistance = rotatedVertex.dist( texSphereVerts.get(j) );
      if( currentDistance < foundDistance )
      {
        foundDistance = currentDistance;
        foundIndex = j;
      }
    }
    
    ledSphereVerts.get(i).setNearestAssociatedVertexIndex( foundIndex ); 
  }
}








//----------------------------
void drawTexSphere( boolean doPoints, boolean doColour )
{
  stroke( 255, 90 );
  strokeWeight( 2 );
  
  if( doPoints)
  {
    for( int i = 0; i < texSphereVerts.size(); i++ )
    {
      if( doColour )
      {
        float u = texSphereVerts.get( i ).u;
        float v = texSphereVerts.get( i ).v;
        stroke( planetTexture.get( (int)(u * planetTexture.width), (int)(v * planetTexture.height) ) );
      }
      
      point( texSphereVerts.get(i).x , 
             texSphereVerts.get(i).y, 
             texSphereVerts.get(i).z ); 
    }
  }
  else
  {
    fill( 255, 90 );
    stroke( 255, 90 );
    shape( sphere, 0, 0 );
  }
}


//----------------------------
void drawLedSphere()
{
  stroke( 255, 150, 0, 200 );
  strokeWeight( 10 );
  for( int i = 0; i < ledSphereVerts.size(); i++ )
  {
    point( ledSphereVerts.get(i).x , 
           ledSphereVerts.get(i).y, 
           ledSphereVerts.get(i).z ); 
  }
}

//----------------------------
void drawLedSphere( float theta, float rx, float ry, float rz )
{
  stroke( 255, 150, 0, 200 );
  strokeWeight( 10 );
  for( int i = 0; i < ledSphereVerts.size(); i++ )
  {
    point( ledSphereVerts.get(i).rotate3d(theta, rx, ry, rz ).x , 
           ledSphereVerts.get(i).rotate3d(theta, rx, ry, rz ).y, 
           ledSphereVerts.get(i).rotate3d(theta, rx, ry, rz ).z ); 
  }
}




//----------------------------
void drawNearestVerts( boolean doColour )
{
  stroke( 255, 170 );
  strokeWeight( 15 );
  for( int i = 0; i < ledSphereVerts.size(); i++ )
  {
    int nearestIndex = ledSphereVerts.get(i).nearestAssociatedVertexIndex;
    
    //check nearestAssocVertIndex exists
    if( nearestIndex >= 0 )
    {
      if( doColour )
      {
        float u, v;
        u = texSphereVerts.get( nearestIndex ).u;
        v = texSphereVerts.get( nearestIndex ).v;
        
        stroke( planetTexture.get( (int)(u * planetTexture.width), (int)(v * planetTexture.height) ) );
        
      }
      
      
      point( texSphereVerts.get( nearestIndex ).x , 
             texSphereVerts.get( nearestIndex ).y, 
             texSphereVerts.get( nearestIndex ).z );
    }
  }
}