uniform float uSize;
uniform vec2 uResolution;
attribute float aSize;
uniform float uProgress;

float remap(float value, float originMin, float originMax, float destinationMin, float destinationMax)
{
    return destinationMin + (value - originMin) * (destinationMax - destinationMin) / (originMax - originMin);
}

void main()
{  
    vec3 newPosition = position;

     // Falling
    float fallingProgress = remap(uProgress, 0.1, 1.0, 0.0, 1.0);
    fallingProgress = clamp(fallingProgress, 0.0, 1.0);
    fallingProgress = 1.0 - pow(1.0 - fallingProgress, 3.0);
    newPosition.y -= fallingProgress * 0.2;

   // Exploding
      float explodingProgress = remap(uProgress, 0.0, 0.1, 0.0, 1.0);
    explodingProgress = clamp(explodingProgress, 0.0, 1.0);
     explodingProgress = 1.0 - pow(1.0-explodingProgress, 3.0);
    newPosition = mix(vec3(0.0), newPosition, explodingProgress);


   // Final Position
 vec4 modelPosition = modelMatrix * vec4(newPosition, 1.0);
 vec4 viewPosition = viewMatrix * modelPosition;
 gl_Position = projectionMatrix * viewPosition;

 // Final size
 gl_PointSize = uSize * uResolution.y * aSize;;
 gl_PointSize *= 1.0 / - viewPosition.z;

}