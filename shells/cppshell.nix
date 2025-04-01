{ pkgs ? import <nixpkgs> { }, ... }:

with pkgs;
mkShell {
  buildInputs = with pkgs; [
     libgcc
     python3
  ];
}
