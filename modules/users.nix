{ pkgs, ... }:

{
  users.users.mystiafin = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "libvirtd" "docker" ];
    packages = with pkgs; [
      tree
    ];
  };
}
