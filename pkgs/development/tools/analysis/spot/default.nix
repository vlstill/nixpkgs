{stdenv, fetchurl, boost, python }:

stdenv.mkDerivation {
  name = "spot-1.2.1";

  src = fetchurl {
    url = http://spot.lip6.fr/dl/spot-1.2.1.tar.gz;
    sha256 = "108smjmz33id3hkk1lm0i2sm6cbv48rbk8hmckx6wx0ppqi5wzab";
  };

  buildInputs = [ boost python ];

  meta = {
    description = "Spot is an object-oriented model checking library written in C++.";
    homepage = http://spot.lip6.fr/wiki/;
    license = "GPL";
    maintainers = with stdenv.lib.maintainers; [ vlstill ];
  };
}
