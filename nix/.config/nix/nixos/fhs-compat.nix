{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.envfs.enable = lib.mkDefault true;
  programs.nix-ld.enable = lib.mkDefault true;
  programs.nix-ld.libraries = with pkgs; [
    acl
    attr
    bzip2
    dbus
    expat
    fontconfig
    freetype
    fuse3
    icu
    libnotify
    libsodium
    libssh
    libunwind
    libusb1
    libuuid
    nspr
    nss
    stdenv.cc.cc
    util-linux
    zlib
    zstd
  ];
}
