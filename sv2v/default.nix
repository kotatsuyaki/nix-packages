{ pkgs }: pkgs.stdenv.mkDerivation
rec {
  pname = "sv2v";
  version = "0.0.9";

  src = ./.;
  installPhase = ''
    mkdir -p $out/bin
    cp ./sv2v $out/bin/sv2v
  '';

  meta = with pkgs.lib; {
    description = " SystemVerilog to Verilog conversion ";
    homepage = "https://github.com/zachjs/sv2v";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}
