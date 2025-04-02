{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    R
    rstudio
    rPackages.ISLR2
    rPackages.ggplot2
    rPackages.xtable
    rPackages.GGally
  ];
}
