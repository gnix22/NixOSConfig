{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    R
    rstudio
    rPackages.ISLR2
  ];
}
