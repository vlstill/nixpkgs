# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, commandQq, doctest, filepath, free, hspec, lens
, semigroups, temporary, text, transformers, unorderedContainers
}:

cabal.mkDerivation (self: {
  pname = "directory-layout";
  version = "0.7.4.1";
  sha256 = "0hj7dfv5i2s1dk0rws2fg84crpxz1kgvrq68f373a6hwkbfhv89b";
  buildDepends = [
    commandQq filepath free hspec lens semigroups text transformers
    unorderedContainers
  ];
  testDepends = [
    commandQq doctest filepath free hspec lens semigroups temporary
    text transformers unorderedContainers
  ];
  meta = {
    description = "Directory layout DSL";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
