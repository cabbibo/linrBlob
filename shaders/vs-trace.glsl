
uniform mat4 iModelMat;

varying vec3 vPos;
varying vec3 vNorm;
varying vec3 vCam;

varying vec3 vMNorm;
varying vec3 vMPos;

varying vec2 vUv;
varying float vNoiseVal;


uniform float _NoiseSize;
uniform float _NoiseSpeed;
uniform float _NoiseOffset;
uniform float time;

uniform float _FFTSize;
uniform float _FFTStart;



uniform sampler2D t_audio;

$noise



void main(){

  vUv = uv;

  vPos = position;
  vNorm = normal;


  float n = snoise( vPos  * _NoiseSize + vec3(0.,0.,1.) * _NoiseSpeed * time );

  vNoiseVal = n * .5 + .5;

  vec4 audio = texture2D(t_audio,vec2(n * _FFTSize + _FFTStart,0.));

  vPos += vNorm * n * _NoiseOffset * length(audio);


  vMNorm = normalMatrix * normal;
  vMPos = (modelMatrix * vec4( position , 1. )).xyz;

  //vLight = ( iModelMat * vec4(  vec3( 400. , 1000. , 400. ) , 1. ) ).xyz;


  // Use this position to get the final position 
  gl_Position = projectionMatrix * modelViewMatrix * vec4( vPos , 1.);

}