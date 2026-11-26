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

  // Signed distance approximation
  vec2 corner = max(q, 0.0);

  float sum = pow(corner.x, p) + pow(corner.y, p);
  float d = pow(sum, 1.0 / p);

  float dist = d + min(max(q.x, q.y), 0.0) - r;

  // Gradient correction for Euclidean distance
  if (q.x > 0.0 && q.y > 0.0 && d > 0.0001) {
      vec2 gradient = pow(corner, vec2(p - 1.0))
                    / pow(d, p - 1.0);

      float gradientLength = length(gradient);
      dist /= max(gradientLength, 0.0001);
  }

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
