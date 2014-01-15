{ stdenv, fetchsvn, fetchurl, cmake, libunwind, version }:

assert version == "3.4" || version == "190100";

let rev = "190100"; in

stdenv.mkDerivation rec {
  name = if version == rev
          then "libc++-pre${rev}"
          else "libc++-${version}";

  src = if version == rev
    then fetchsvn {
      url = "http://llvm.org/svn/llvm-project/libcxx/trunk";
      inherit rev;
      sha256 = "0hnfvzzrkj797kp9sk2yncvbmiyx0d72k8bys3z7l6i47d37xv03";
    } else fetchurl {
      url = "http://llvm.org/releases/3.4/libcxx-3.4.src.tar.gz";
      sha256 = "1sqd5qhqj7qnn9zjxx9bv7ky4f7xgmh9sbgd53y1kszhg41217xx";
    };

  cxxabi = if version == rev
    then fetchsvn {
      url = "http://llvm.org/svn/llvm-project/libcxxabi/trunk";
      inherit rev;
      sha256 = "1kdyvngwd229cgmcqpawaf0qizas8bqc0g8s08fmbgwsrh1qrryp";
    } else fetchsvn {
      url = "http://llvm.org/svn/llvm-project/libcxxabi/trunk";
      rev = "199249";
      sha256 = "0h1x1s40x5r65ar53rv34lmgcfil3zxaknqr64dka1mz29xhhrxy";
    };

  buildInputs = [ cmake ];

  preConfigure = ''
      sed -i 's/;cxa_demangle.h//' CMakeLists.txt
      cp -R ${cxxabi} cxxabi
      chmod u+w -R cxxabi # umm
      (export NIX_CFLAGS_COMPILE="-I${libunwind}/include -I$PWD/include";
       export NIX_CFLAGS_LINK="-L${libunwind}/lib -lunwind";
       cd cxxabi/lib
       sed -e s,-lstdc++,, -i buildit # do not link to libstdc++!
       ./buildit
       mkdir -p $out/lib && cp libc++abi.so.1.0 $out/lib
       cd $out/lib
       ln -s libc++abi.so.1.0 libc++abi.so
       ln -s libc++abi.so.1.0 libc++abi.so.1)
  '';

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release"
                 "-DLIBCXX_LIBCXXABI_INCLUDE_PATHS=${cxxabi}/include"
                 "-DLIBCXX_CXX_ABI=libcxxabi" ];
  buildPhase = ''NIX_CFLAGS_LINK="-L$out/lib -lc++abi" make'';

  enableParallelBuilding = true;

  meta = {
    homepage = http://libcxx.llvm.org/;
    description = "A new implementation of the C++ standard library, targeting C++11";
    license = "BSD";
    maintainers = stdenv.lib.maintainers.shlevy;
    platforms = stdenv.lib.platforms.all;
  };
}

