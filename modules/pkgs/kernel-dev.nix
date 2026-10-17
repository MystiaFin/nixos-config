{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # reads each project's rust-toolchain.toml, so every folder gets its own toolchain
    rustup
    # host-cpu-only build: x86_64 emulation without every other arch
    qemu_kvm
    gdb
  ];

  # rustup's rust-analyzer proxy runs the folder's toolchain, so outside a project with its
  # own rust-toolchain.toml it lands on stable, which ships without rust-analyzer or rust-src;
  # only checked locally so a switch doesn't touch the network once these are installed
  home.activation.rustupStable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rustup=${pkgs.rustup}/bin/rustup
    if ! $rustup which --toolchain stable rust-analyzer >/dev/null 2>&1; then
      run $rustup toolchain install stable --profile default \
        --component rust-analyzer --component rust-src \
        || warnEcho "rustup: couldn't install stable rust-analyzer, retry on the next switch"
    fi
    $rustup default >/dev/null 2>&1 || run $rustup default stable
  '';
}
