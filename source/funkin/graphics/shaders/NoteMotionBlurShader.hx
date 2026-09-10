package funkin.graphics.shaders;

import flixel.system.FlxAssets.FlxShader;

class NoteMotionBlurShader extends FlxShader
{
  @:glFragmentSource('
    #pragma header

    void main()
    {
      vec2 uv = openfl_TextureCoordv;
      vec2 stepUV = vec2(0.0, 1.125 / openfl_TextureSize.y);
      gl_FragColor = flixel_texture2D(bitmap, uv - 2.0 * stepUV) * 0.0625
        + flixel_texture2D(bitmap, uv - stepUV) * 0.25
        + flixel_texture2D(bitmap, uv) * 0.375
        + flixel_texture2D(bitmap, uv + stepUV) * 0.25
        + flixel_texture2D(bitmap, uv + 2.0 * stepUV) * 0.0625;
    }
  ')
  public function new()
  {
    super();
  }
}
