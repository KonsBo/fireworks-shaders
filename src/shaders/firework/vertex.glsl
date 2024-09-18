uniform float uSize;
uniform vec2 uResolution;
uniform sampler2D uTexture;
 
void main()
{
   // Final Position
 vec4 modelPosition = modelMatrix * vec4(position, 1.0);
 vec4 viewPosition = viewMatrix * modelPosition;
 gl_Position = projectionMatrix * viewPosition;

 // Final size
 gl_PointSize = uSize * uResolution.y;
 gl_PointSize *= 1.0 / - viewPosition.z;

}