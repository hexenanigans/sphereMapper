class Vector3D {
  float x;
  float y;
  float z;
  
  public Vector3D(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Vector3D(float[] v) {
    x = v[0];
    y = v[1];
    z = v[2];
  }
  
  float length() {
    return sqrt(x*x + y*y + z*z);
  }
  
  Vector3D scaled(float s) {
    return new Vector3D(x*s, y*s, z*s);
  }
  
  Vector3D unit() {
    return scaled(1.0 / length());
  }
};

Vector3D add3D(Vector3D v1, Vector3D v2) {
  return new Vector3D(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
}

Vector3D subtract3D(Vector3D v1, Vector3D v2) {
  return new Vector3D(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
}

Vector3D cross3D(Vector3D v1, Vector3D v2) {
  return new Vector3D(v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x);
}

float dot3D(Vector3D v1, Vector3D v2) {
  return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}
