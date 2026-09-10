package luaslice.script;

class ScriptSource
{
  public static function normalize(source:String):String
  {
    if (StringTools.startsWith(source, '\uFEFF')) source = source.substr(1);
    return source;
  }
}
