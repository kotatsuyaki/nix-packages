{ pkgs }: pkgs.rustPlatform.buildRustPackage
rec {
  pname = "svls";
  version = "0.1.28";

  src = pkgs.fetchFromGitHub {
    owner = "dalance";
    repo = "svls";
    rev = "7bec9e8da7e9c4844ca690ace6f629578d8e484c";
    sha256 = "s2ti8tHjG8Dnq/iwRzBHz3fVyD7/Kn4jIhmjqOtXlTk=";
    fetchSubmodules = true;
  };

  cargoSha256 = "sha256-4al2b6KMLEwE+Mi9cDQkTXd8ifv8e8Q5AaPT3l7JwAw=";
  meta = with pkgs.lib; {
    description = "SystemVerilog language server";
    homepage = "https://github.com/dalance/svls";
    license = licenses.mit;
    maintainers = with maintainers; [ trepetti ];
  };
}
