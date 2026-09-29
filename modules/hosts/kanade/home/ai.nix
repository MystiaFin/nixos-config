{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    pytorch-bin
    torchvision-bin
    pip
  ];
}
