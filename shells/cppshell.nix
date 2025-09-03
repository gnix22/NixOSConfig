{ pkgs ? import <nixpkgs> { }, ... }:

with pkgs;
mkShell {
  buildInputs = with pkgs; [
     gnumake
     libgcc
     python3
  ];
}
