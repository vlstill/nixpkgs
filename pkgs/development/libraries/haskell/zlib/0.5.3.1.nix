# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, zlib }:

cabal.mkDerivation (self: {
  pname = "zlib";
  version = "0.5.3.1";
  sha256 = "1hj56lk4g2zr7acdda39zib1bj02777q0asm5ms9rfj7kp81caiq";
  extraLibraries = [ zlib ];
  meta = {
    description = "Compression and decompression in the gzip and zlib formats";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    hydraPlatforms = self.stdenv.lib.platforms.none;
  };
})
