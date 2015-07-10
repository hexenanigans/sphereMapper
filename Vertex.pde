class Vertex extends PVector
{
  float u;
  float v;
  PVector normal;
  
  
  //use this to specify nearest vertex of other object.
  //This might be better as a reference to the actual 
  //vertex object rather than the index.
  // -1 indicates no found index
  int nearestAssociatedVertexIndex;
  
  //constructors
  //------------------------------
  Vertex( float x, float y, float z )
  {
    super(x, y, z);
    normal = new PVector();
    u = 0.0;
    v = 0.0;
    nearestAssociatedVertexIndex = -1;
  }

  Vertex( float x, float y, float z, float u, float v )
  {
    super(x, y, z);
    this.u = u;
    this.v = v;
    normal = new PVector();
    nearestAssociatedVertexIndex = -1;
  }

  Vertex( float x, float y, float z, float u, float v, float nx, float ny, float nz )
  {
    super(x, y, z);
    this.u = u;
    this.v = v;
    normal = new PVector(nx, ny, nz);
    nearestAssociatedVertexIndex = -1;
  }
  
  
  //setters
  //------------------------------
  void setUv( float u, float v )
  {
    this.u = u;
    this.v = v;
  }
  
  
  void setNormal( float x, float y, float z )
  {
    normal.set( x, y, z );
    normal.normalize();
  }
  
  
  void setNearestAssociatedVertexIndex( int i )
  {
    nearestAssociatedVertexIndex = i;
  }
  
  
  Vertex rotate3d( float theta, float rx, float ry, float rz )
  { 
    Vertex outVertex = new Vertex( this.x, this.y, this.z );
    
    PMatrix3D rMat = new PMatrix3D();
    rMat.rotate( radians( theta ), rx, ry, rz );
    rMat.mult(this, outVertex);
    
    return outVertex;
  }
  
}
