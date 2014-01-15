{ stdenv, fetchurl, perl, groff, llvm_versioned, cmake, libxml2, python, version }:

assert version == "3.4" || version == "3.3";

let
  llvm = llvm_versioned version;
  gccReal = if (stdenv.gcc.gcc or null) == null then stdenv.gcc else stdenv.gcc.gcc;
in

stdenv.mkDerivation {
  name = "clang-${version}";

  buildInputs = [ perl llvm groff cmake libxml2 python ];

  patches = [ ./clang-tablegen-dir.patch ] ++
            stdenv.lib.optional (stdenv.gcc.libc != null)
                (if version == "3.3" then ./clang-purity-33.patch
                                    else ./clang-purity-34.patch)
            ++
            stdenv.lib.optional (version == "3.4") ./clang-include-dir.patch;


  cmakeFlags = [
    "-DCLANG_PATH_TO_LLVM_BUILD=${llvm}"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DLLVM_TARGETS_TO_BUILD=all"
    "-DGCC_INSTALL_PREFIX=${gccReal}"
  ] ++ stdenv.lib.optionals (stdenv.gcc.libc != null) [
    "-DC_INCLUDE_DIRS=${stdenv.gcc.libc}/include/"
  ];

  enableParallelBuilding = true;

  src = if version == "3.4"
    then fetchurl {
        url = "http://llvm.org/releases/${version}/clang-${version}.src.tar.gz";
        sha256 = "06rb4j1ifbznl3gfhl98s7ilj0ns01p7y7zap4p7ynmqnc6pia92";
    } else /* 3.3 */ fetchurl {
        url = "http://llvm.org/releases/${version}/cfe-${version}.src.tar.gz";
        sha256 = "15mrvw43s4frk1j49qr4v5viq68h8qlf10qs6ghd6mrsmgj5vddi";
    };


  passthru = { gcc = stdenv.gcc.gcc; };

  meta = {
    homepage = http://clang.llvm.org/;
    description = "A C language family frontend for LLVM";
    license = "BSD";
    maintainers = with stdenv.lib.maintainers; [viric shlevy];
    platforms = with stdenv.lib.platforms; all;
  };
}
