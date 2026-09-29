{ pkgs, pkgs-unstable, inputs, ... }:

{
  home.packages = with pkgs; [
    pytorch-bin
    torchvision-bin
    pip
    pkgs-unstable.claude-code
  ];
}
