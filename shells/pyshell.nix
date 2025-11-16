{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.mkShell {
  buildInputs = with pkgs.python312Packages; [
    # python
    pkgs.python312
    matplotlib
    textual-dev
    rich
    numpy
    pandas
    pip
    scikit-learn
    seaborn
    sympy
    platformdirs
    pyyaml
  ];
}
