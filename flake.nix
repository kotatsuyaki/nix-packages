{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-21.11;
    utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.svls = import ./svls.nix
          {
            inherit pkgs;
          };
        packages.nb = import ./nb.nix { inherit pkgs; };
        packages.sv2v = import ./sv2v { inherit pkgs; };
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            rnix-lsp
            nixpkgs-fmt
          ];
        };
      });
}
