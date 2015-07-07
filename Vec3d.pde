class Vec3d extends PVector
{
  float u;
  float v;
  
  Vec3d( float x, float y, float z )
  {
    super(x, y, z);
  }
  
  void setUv( float u, float v )
  {
    this.u = u;
    this.v = v;
  }
}