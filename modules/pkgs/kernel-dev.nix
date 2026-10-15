{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # reads each project's rust-toolchain.toml, so every folder gets its own toolchain
    rustup
    # host-cpu-only build: x86_64 emulation without every other arch
    qemu_kvm
    gdb
  ];
}
