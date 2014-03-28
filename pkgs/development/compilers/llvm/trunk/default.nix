{ newScope, stdenv, isl, fetchsvn }:
let
  callPackage = newScope (self // { inherit stdenv isl version fetch; });

  version = "r204666";

  fetch = name: sha256: fetchsvn {
    url = "http://llvm.org/svn/llvm-project/${name}/trunk";
    rev = 204666;
    inherit sha256;
  };

  self = {
    llvm = callPackage ./llvm.nix {};

    clang = callPackage ./clang.nix {};

    lld = callPackage ./lld.nix {};

    lldb = callPackage ./lldb.nix {};

    polly = callPackage ./polly.nix {};

    dragonegg = callPackage ./dragonegg.nix {};
  };
in self
