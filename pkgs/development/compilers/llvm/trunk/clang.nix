{ stdenv, fetch, cmake, libxml2, libedit, llvm, version }:

stdenv.mkDerivation {
  name = "clang-${version}";

  unpackPhase = ''
    unpackFile ${fetch "cfe" "1qbcfbfpmnavwsbrfmmvz1xcqzlwrfiy73zp2zqr9z5rybv74i45"}
    mv cfe-${version} clang
    sourceRoot=$PWD/clang
    unpackFile ${fetch "clang-tools-extra" "0rmvg49lf7kpzqyh02fv96wy80kxpn2z3wsmj8davhwn81zijyxr"}
    chmod u+w -R .
    mv clang-tools-extra-${version} $sourceRoot/tools/extra
    export cmakeFlags="$cmakeFlags -DCLANG_PATH_TO_LLVM_SOURCE=$PWD/llvm-${version}"
  '';

  patches = [ ./clang-purity.patch ];

  buildInputs = [ cmake libedit libxml2 ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_CXX_FLAGS=-std=c++11"
    "-DLLVM_CONFIG=${llvm}/bin/llvm-config"
  ] ++
  (stdenv.lib.optional (stdenv.gcc.libc != null) "-DC_INCLUDE_DIRS=${stdenv.gcc.libc}/include") ++
  (stdenv.lib.optional (stdenv.gcc.gcc != null) "-DGCC_INSTALL_PREFIX=${stdenv.gcc.gcc}");

  # Clang expects to find LLVMgold in its own prefix
  postInstall = "ln -sv ${llvm}/lib/LLVMgold.so $out/lib";

  passthru.gcc = stdenv.gcc.gcc;

  enableParallelBuilding = true;

  meta = {
    description = "A c, c++, objective-c, and objective-c++ frontend for the llvm compiler";
    homepage    = http://llvm.org/;
    license     = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.shlevy ];
    platforms   = stdenv.lib.platforms.all;
  };
}
