{ stdenv, fetchurl, boost, python,
  autoconf, automake, libtool, flex, bison, emacs24-nox, swig, doxygen,
  perl, perlPackages }:

let locategettex = perlPackages.LocaleGettext
in
stdenv.mkDerivation {
  name = "spot-git";

  src = fetchgit {
    url = git://git.lrde.epita.fr/spot
    sha256 = "3bde7b2a1a2b4b8f0364a230984b8d3434a25d5723af23484c13a1ef4669e0b7";
  };

  buildInputs = [ boost python ];

  meta = {
    description = "Spot is an object-oriented model checking library written in C++.";
    homepage = http://spot.lip6.fr/wiki/;
    license = "GPL";
    maintainers = with stdenv.lib.maintainers; [ vlstill ];
  };
}

#  GNU Autoconf >= 2.61
#  GNU Automake >= 1.11
#  GNU Libtool >= 2.4
#  GNU Flex (the version seems to matters, we used 2.5.35)
#  GNU Bison >= 2.7
#  GNU Emacs (preferably >= 24 but it may work with older versions)
#  SWIG >= 2.0
#  Doxygen >= 1.4.0
#  Perl, with its Gettext module (it might be called something like
#    liblocale-gettext-perl or p5-locale-gettext in your distribution)
#  A complete LaTeX distribution, including latexmk.
#
#Bootstrap the GIT tree by running
#
#  % autoreconf -vfi
#
#and then go on with the usual
#
#  % ./configure
#  % make
#
