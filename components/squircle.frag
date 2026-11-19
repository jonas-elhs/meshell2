// Disclaimer: AI generated
// qsb --qt6 -o components/squircle.frag.qsb components/squircle.frag

#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
  mat4 qt_Matrix;
  float qt_Opacity;

  vec2 size;
  float radius;
  float roundingPower;
  float borderWidth;

  vec4 color;
  vec4 borderColor;
};

void main()
{
  vec2 halfSize = size * 0.5;

  float r = clamp(radius, 0.0, min(halfSize.x, halfSize.y));
  float p = clamp(roundingPower, 1.0, 10.0);

  // Centered coordinates
  vec2 pos = abs((qt_TexCoord0 - 0.5) * size);
  vec2 q = pos - halfSize + r;

  // Superellipse corner distance
  vec2 corner = max(q, 0.0);
  float d;
  if (abs(p - 4.0) < 0.001) {
    vec2 c2 = corner * corner;
    d = sqrt(sqrt(dot(c2, c2)));
  } else {
    d = pow(
      pow(corner.x, p) + pow(corner.y, p),
      1.0 / p
    );
  }

  // Signed distance approximation
  float dist = d + min(max(q.x, q.y), 0.0) - r;

  // Antialiasing
  float aa = max(fwidth(dist), 0.0001);
  float coverage = 1.0 - smoothstep(-aa, aa, dist);

  // Border
  float border = borderWidth > 0.0
    ? smoothstep(-borderWidth - aa, -borderWidth + aa, dist)
    : 0.0;

  // Color composition
  vec4 finalColor = mix(color, borderColor, border);
  float alpha = coverage * finalColor.a * qt_Opacity;

  fragColor = vec4(finalColor.rgb * alpha, alpha);
}
