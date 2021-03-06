# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, dataDefault, hasteCompiler, hastePerch, monadsTf
, transformers
}:

cabal.mkDerivation (self: {
  pname = "hplayground";
  version = "0.1.0.3";
  sha256 = "1k46b94n9wkbh7374mjyg5jnwxxrhj8ai53q3r4lysx1rzgw7ak6";
  buildDepends = [
    dataDefault hasteCompiler hastePerch monadsTf transformers
  ];
  meta = {
    homepage = "https://github.com/agocorona/hplayground";
    description = "a client-side haskell framework that compiles to javascript with the haste compiler";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ tomberek ];
  };
})
