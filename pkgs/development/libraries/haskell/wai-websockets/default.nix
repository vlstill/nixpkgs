# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, blazeBuilder, caseInsensitive, fileEmbed, httpTypes
, ioStreams, network, text, transformers, wai, waiAppStatic, warp
, websockets
}:

cabal.mkDerivation (self: {
  pname = "wai-websockets";
  version = "3.0.0.1";
  sha256 = "01rbwyx2ks6hdaw5qw7dibidyw4bh85s2gzqy4rhmxpdcnmxxmnz";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    blazeBuilder caseInsensitive fileEmbed httpTypes ioStreams network
    text transformers wai waiAppStatic warp websockets
  ];
  meta = {
    homepage = "http://github.com/yesodweb/wai";
    description = "Provide a bridge betweeen WAI and the websockets package";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
