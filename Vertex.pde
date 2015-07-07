class Vertex extends PVector
{
  float u;
  float v;
  PVector normal;
  
  
  Vertex( float x, float y, float z )
  {
    super(x, y, z);
    normal = new PVector();
    u = 0.0;
    v = 0.0;
  }

  Vertex( float x, float y, float z, float u, float v )
  {
    super(x, y, z);
    this.u = u;
    this.v = v;
    normal = new PVector();
  }

  Vertex( float x, float y, float z, float u, float v, float nx, float ny, float nz )
  {
    super(x, y, z);
    this.u = u;
    this.v = v;
    normal = new PVector(nx, ny, nz);
  }
  
  
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
  
}