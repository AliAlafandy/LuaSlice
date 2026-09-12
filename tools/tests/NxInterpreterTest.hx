import nx.script.Interpreter;

class NxInterpreterTest
{
  static function main():Void
  {
    final owner = {counter: 0};
    final script = new Interpreter(false, false);
    script.enableSandbox();
    script.withParent(owner);
    script.set('state', owner);
    script.run('func onCreate() { state.counter = 7 }\nfunc onBeatHit(beat) { state.counter += beat }', 'hooks.nx');
    if (!script.has('onCreate')) throw 'NxScript discarded onCreate';
    script.call('onCreate', []);
    if (owner.counter != 7) throw 'NxScript did not update its owner';
    script.call('onBeatHit', [3]);
    if (owner.counter != 10) throw 'NxScript hook arguments failed';
    for (i in 0...36000) script.call('onBeatHit', [1]);
    if (owner.counter != 36010) throw 'NxScript repeated hooks failed';
    final withBom = new Interpreter(false, false);
    withBom.run(luaslice.script.ScriptSource.normalize('\uFEFFfunc onCreate() { return 1 }'), 'utf8-bom.nx');
    if (!withBom.has('onCreate')) throw 'UTF-8 BOM prevented loading';
    withBom.call('onCreate', []);
    Sys.println('NxScript UTF-8 BOM passed');
    Sys.println('NxScript interpreter hooks passed');
  }
}
