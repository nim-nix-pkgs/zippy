{
  description = ''Pure Nim implementation of deflate, zlib, gzip and zip.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-zippy-0_10_4.flake = false;
  inputs.src-zippy-0_10_4.ref   = "refs/tags/0.10.4";
  inputs.src-zippy-0_10_4.owner = "guzba";
  inputs.src-zippy-0_10_4.repo  = "zippy";
  inputs.src-zippy-0_10_4.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-zippy-0_10_4"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-zippy-0_10_4";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}