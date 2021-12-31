{ pkgs }:
let
  deps = with pkgs; [
    # Not sure the purpose of this
    ncat
    # For export
    pandoc
    texlive.combined.scheme-full
    # For encryption
    openssl
    file
    # For navigation
    ripgrep
    ripgrep-all
    bat
    ranger
  ];
in
pkgs.stdenv.mkDerivation rec {
  pname = "nb";
  version = "6.7.9-r6";

  src = pkgs.fetchFromGitHub {
    owner = "xwmx";
    repo = "nb";
    rev = "337ae2af42e39ecb42d8b29d957b8333ae1fb418";
    sha256 = "sha256-TCuFRQ5t620dNhGAFT6ux8egLydElHi/wRWMPvp2QZ0=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = with pkgs; [ installShellFiles makeWrapper ];
  builtInputs = deps;

  buildPhase = "true";
  installPhase = ''
    # Install main files
    mkdir -p $out/bin
    install ./nb $out/bin
    install bin/bookmark $out/bin

    # Install shell completion
    installShellCompletion --bash --name nb.bash etc/nb-completion.bash
    installShellCompletion --zsh --name _nb etc/nb-completion.zsh
  '';
  postFixup = ''
    # Replace /usr/bin/env shebangs
    patchShebangs $out/bin/nb

    # Prevent the script name from being .nb-wrapped
    substituteInPlace $out/bin/nb \
      --replace '_ME="$(basename "''${0}")"' '_ME="nb"'

    grep _ME= ./nb
    # Wrap with ncat
    wrapProgram $out/bin/nb \
      --prefix PATH : "${pkgs.lib.makeBinPath deps}" \
      --set BROWSER firefox
  '';

  meta = with pkgs.lib; {
    description = "CLI and local web plain text note‑taking, bookmarking, and archiving with linking, tagging, filtering, search, Git versioning & syncing, Pandoc conversion, + more, in a single portable script";
    homepage = "https://xwmx.github.io/nb/";
    license = licenses.agpl3;
    maintainers = with maintainers; [ ];
  };
}
